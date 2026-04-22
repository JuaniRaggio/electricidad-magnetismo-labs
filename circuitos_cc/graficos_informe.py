"""
Graficos complementarios para el informe de circuitos CC.

Genera 4 graficos en assets/:
  1. comparacion_resistencias.png - R nominal vs ohmetro vs calculada
  2. comparacion_corrientes.png   - I calculada vs I medida (circ 1 y 2)
  3. caidas_tension.png           - V calculado vs V medido (circ 1 y 2)
  4. potencia.png                 - Balance de potencia (circ 1 y 2)
"""

import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

plt.rcParams.update({
    "font.family": "serif",
    "font.size": 11,
    "axes.grid": True,
    "grid.alpha": 0.3,
    "figure.figsize": (10, 6),
})

OUT = Path(__file__).parent / "assets"
OUT.mkdir(exist_ok=True)

# =============================================
# DATOS
# =============================================

# Resistencias (Parte I)
R_names = [r"$R_1$", r"$R_2$", r"$R_3$"]
R_nominal = np.array([220, 330, 150], dtype=float)
R_ohmetro = np.array([218, 325, 148], dtype=float)
R_calculada = np.array([244.26, 704.76, 163.73])  # R2 tiene error de transcripcion

# Resistencias usadas para circuitos (ohmetro)
R1, R2, R3 = 218.0, 325.0, 148.0

# Fuentes
V1_fuente = 9.22
V2_c1 = 2.66       # circuito 1: V2 absorbe (corriente entra por +)
V2_c2 = 1.50        # circuito 2 (invertida): V2 entrega

# Corrientes medidas (A)
I_med_c1 = np.array([23.3, 13.0, 10.3]) * 1e-3
I_med_c2 = np.array([32.2, 6.8, 25.4]) * 1e-3

# Tensiones medidas en cada R (V)
V_med_c1 = np.array([5.70, 4.17, 1.51])
V_med_c2 = np.array([6.92, 2.21, 3.71])

Rs = np.array([R1, R2, R3])


# =============================================
# RESOLUCION TEORICA
# =============================================

def resolver_circuito(R1, R2, R3, V1, V2):
    """
    Resuelve el circuito de dos mallas:
      Nodo:    I1 - I2 - I3 = 0
      Malla 1: R1*I1 + R2*I2 = V1
      Malla 2: -R2*I2 + R3*I3 = V2
    Retorna I1, I2, I3 en Ampere.
    """
    A = np.array([
        [1,   -1,   -1],
        [R1,   R2,   0],
        [0,   -R2,  R3],
    ])
    b = np.array([0, V1, V2])
    return np.linalg.solve(A, b)


# Circuito 1: V2 en oposicion -> signo negativo en malla
I_teo_c1 = resolver_circuito(R1, R2, R3, V1_fuente, -V2_c1)
# Circuito 2: V2 invertida -> entrega
I_teo_c2 = resolver_circuito(R1, R2, R3, V1_fuente, V2_c2)

# Caidas de tension teoricas: V = I * R
V_teo_c1 = np.abs(I_teo_c1) * Rs
V_teo_c2 = np.abs(I_teo_c2) * Rs

# Potencia disipada en resistencias (mW)
P_R_c1 = I_teo_c1**2 * Rs * 1e3
P_R_c2 = I_teo_c2**2 * Rs * 1e3

# Potencia de fuentes (mW)
P_V1_c1 = V1_fuente * I_teo_c1[0] * 1e3     # V1 entrega
P_V2_c1 = V2_c1 * I_teo_c1[2] * 1e3          # V2 absorbe (I3 entra por +)

P_V1_c2 = V1_fuente * I_teo_c2[0] * 1e3     # V1 entrega
P_V2_c2 = V2_c2 * I_teo_c2[2] * 1e3          # V2 entrega (invertida)


def add_bar_labels(ax, bars, fmt="{:.1f}", offset=0.3, fontsize=8):
    """Agrega etiquetas de valor sobre cada barra."""
    for bar in bars:
        h = bar.get_height()
        if not np.isnan(h) and h > 0:
            ax.text(bar.get_x() + bar.get_width() / 2, h + offset,
                    fmt.format(h), ha="center", va="bottom", fontsize=fontsize)


# =============================================
# GRAFICO 1: Comparacion de metodos de R
# =============================================

fig, ax = plt.subplots(figsize=(9, 5))
x = np.arange(3)
w = 0.25

b1 = ax.bar(x - w, R_nominal, w, label="Nominal", color="#2563eb", edgecolor="white")
b2 = ax.bar(x, R_ohmetro, w, label="Ohmetro", color="#16a34a", edgecolor="white")
b3 = ax.bar(x + w, R_calculada, w, label="Calculada (V/I)", color="#dc2626", edgecolor="white")

# Marcar R2 calculada como erronea
b3[1].set_hatch("//")
b3[1].set_alpha(0.5)
ax.annotate(
    "Dato erroneo\n(ver nota en informe)",
    xy=(1 + w, R_calculada[1]),
    xytext=(1.8, 650),
    fontsize=8,
    arrowprops=dict(arrowstyle="->", color="gray", lw=0.8),
    bbox=dict(boxstyle="round,pad=0.3", fc="lightyellow", ec="gray", alpha=0.9),
)

add_bar_labels(ax, b1, fmt="{:.0f}", offset=5)
add_bar_labels(ax, b2, fmt="{:.0f}", offset=5)
# Solo etiquetas para R1 y R3 calculadas (R2 ya tiene anotacion)
for i in [0, 2]:
    h = b3[i].get_height()
    ax.text(b3[i].get_x() + b3[i].get_width() / 2, h + 5,
            f"{h:.0f}", ha="center", va="bottom", fontsize=8)

ax.set_xticks(x)
ax.set_xticklabels(R_names)
ax.set_ylabel(r"Resistencia ($\Omega$)")
ax.set_title("Comparacion de metodos de determinacion de resistencias")
ax.legend(loc="upper left")

fig.tight_layout()
fig.savefig(OUT / "comparacion_resistencias.png", dpi=200, bbox_inches="tight")
plt.close(fig)
print(f"Guardado: {OUT / 'comparacion_resistencias.png'}")


# =============================================
# GRAFICO 2: Corrientes teoria vs experimento
# =============================================

fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(11, 5), sharey=True)
x = np.arange(3)
w = 0.30
labels_I = [r"$I_1$", r"$I_2$", r"$I_3$"]

for ax, I_teo, I_med, titulo in [
    (ax1, I_teo_c1 * 1e3, I_med_c1 * 1e3, "Circuito 1"),
    (ax2, I_teo_c2 * 1e3, I_med_c2 * 1e3, "Circuito 2 (invertida)"),
]:
    b_teo = ax.bar(x - w / 2, I_teo, w, label="Calculada", color="#2563eb", edgecolor="white")
    b_med = ax.bar(x + w / 2, I_med, w, label="Medida", color="#dc2626", edgecolor="white")
    ax.set_xticks(x)
    ax.set_xticklabels(labels_I)
    ax.set_title(titulo)
    ax.legend(fontsize=9)
    add_bar_labels(ax, b_teo, offset=0.3)
    add_bar_labels(ax, b_med, offset=0.3)

ax1.set_ylabel("Corriente (mA)")
fig.suptitle("Corrientes: valores teoricos vs. medidos", fontsize=13, fontweight="bold")
fig.tight_layout()
fig.savefig(OUT / "comparacion_corrientes.png", dpi=200, bbox_inches="tight")
plt.close(fig)
print(f"Guardado: {OUT / 'comparacion_corrientes.png'}")


# =============================================
# GRAFICO 3: Caidas de tension
# =============================================

fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(11, 5), sharey=True)
x = np.arange(3)
w = 0.30
labels_V = [r"$V_{R_1}$", r"$V_{R_2}$", r"$V_{R_3}$"]

for ax, V_teo, V_med, titulo in [
    (ax1, V_teo_c1, V_med_c1, "Circuito 1"),
    (ax2, V_teo_c2, V_med_c2, "Circuito 2 (invertida)"),
]:
    b_teo = ax.bar(x - w / 2, V_teo, w, label="Calculada", color="#2563eb", edgecolor="white")
    b_med = ax.bar(x + w / 2, V_med, w, label="Medida", color="#dc2626", edgecolor="white")
    ax.set_xticks(x)
    ax.set_xticklabels(labels_V)
    ax.set_title(titulo)
    ax.legend(fontsize=9)
    add_bar_labels(ax, b_teo, fmt="{:.2f}", offset=0.05)
    add_bar_labels(ax, b_med, fmt="{:.2f}", offset=0.05)

ax1.set_ylabel("Tension (V)")
fig.suptitle("Caidas de tension: valores teoricos vs. medidos", fontsize=13, fontweight="bold")
fig.tight_layout()
fig.savefig(OUT / "caidas_tension.png", dpi=200, bbox_inches="tight")
plt.close(fig)
print(f"Guardado: {OUT / 'caidas_tension.png'}")


# =============================================
# GRAFICO 4: Balance de potencia
# =============================================

fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 5))

for ax, P_R, pv1, pv2, v2_tipo, titulo in [
    (ax1, P_R_c1, P_V1_c1, P_V2_c1, "absorbe", "Circuito 1"),
    (ax2, P_R_c2, P_V1_c2, P_V2_c2, "entrega", "Circuito 2 (invertida)"),
]:
    labels = [r"$P_{R_1}$", r"$P_{R_2}$", r"$P_{R_3}$", r"$P_{V_1}$", r"$P_{V_2}$"]
    values = list(P_R) + [pv1, pv2]

    if v2_tipo == "absorbe":
        colors = ["#dc2626", "#dc2626", "#dc2626", "#2563eb", "#f59e0b"]
    else:
        colors = ["#dc2626", "#dc2626", "#dc2626", "#2563eb", "#2563eb"]

    bars = ax.bar(labels, values, color=colors, edgecolor="white")

    for bar, v in zip(bars, values):
        h = bar.get_height()
        txt = f"{v:.1f}"
        if v2_tipo == "absorbe" and bar is bars[-1]:
            txt += "\n(absorbe)"
        ax.text(bar.get_x() + bar.get_width() / 2, h + 2, txt,
                ha="center", va="bottom", fontsize=8)

    ax.set_ylabel("Potencia (mW)")
    ax.set_title(titulo)

    # Linea de potencia total disipada
    P_total = sum(P_R)
    ax.axhline(P_total, color="gray", linestyle="--", alpha=0.5)
    ax.text(0.97, P_total + 3, f"Total disipada: {P_total:.1f} mW",
            ha="right", transform=ax.get_yaxis_transform(), fontsize=8, color="gray")

fig.suptitle("Balance de potencia en los circuitos", fontsize=13, fontweight="bold")
fig.tight_layout()
fig.savefig(OUT / "potencia.png", dpi=200, bbox_inches="tight")
plt.close(fig)
print(f"Guardado: {OUT / 'potencia.png'}")


# =============================================
# RESUMEN DE VALORES (para verificar tablas del informe)
# =============================================

print("\n" + "=" * 60)
print("RESUMEN DE VALORES CALCULADOS")
print("=" * 60)

print("\nCorrientes teoricas (mA):")
print(f"  Circ 1: I1={I_teo_c1[0]*1e3:.2f}, I2={I_teo_c1[1]*1e3:.2f}, I3={I_teo_c1[2]*1e3:.2f}")
print(f"  Circ 2: I1={I_teo_c2[0]*1e3:.2f}, I2={I_teo_c2[1]*1e3:.2f}, I3={I_teo_c2[2]*1e3:.2f}")

print("\nCaidas de tension teoricas (V):")
print(f"  Circ 1: VR1={V_teo_c1[0]:.2f}, VR2={V_teo_c1[1]:.2f}, VR3={V_teo_c1[2]:.2f}")
print(f"  Circ 2: VR1={V_teo_c2[0]:.2f}, VR2={V_teo_c2[1]:.2f}, VR3={V_teo_c2[2]:.2f}")

print("\nErrores en tension (%):")
for label, V_teo, V_med in [("Circ 1", V_teo_c1, V_med_c1), ("Circ 2", V_teo_c2, V_med_c2)]:
    errs = np.abs(V_teo - V_med) / V_teo * 100
    print(f"  {label}: VR1={errs[0]:.1f}%, VR2={errs[1]:.1f}%, VR3={errs[2]:.1f}%")

print("\nPotencia en resistencias (mW):")
print(f"  Circ 1: PR1={P_R_c1[0]:.1f}, PR2={P_R_c1[1]:.1f}, PR3={P_R_c1[2]:.1f} (total={sum(P_R_c1):.1f})")
print(f"  Circ 2: PR1={P_R_c2[0]:.1f}, PR2={P_R_c2[1]:.1f}, PR3={P_R_c2[2]:.1f} (total={sum(P_R_c2):.1f})")

print("\nPotencia de fuentes (mW):")
print(f"  Circ 1: PV1={P_V1_c1:.1f} (entrega), PV2={P_V2_c1:.1f} (absorbe)")
print(f"  Circ 2: PV1={P_V1_c2:.1f} (entrega), PV2={P_V2_c2:.1f} (entrega)")

print("\nBalance de potencia:")
print(f"  Circ 1: PV1 - PV2 = {P_V1_c1:.1f} - {P_V2_c1:.1f} = {P_V1_c1 - P_V2_c1:.1f} mW")
print(f"          Total R   = {sum(P_R_c1):.1f} mW")
print(f"  Circ 2: PV1 + PV2 = {P_V1_c2:.1f} + {P_V2_c2:.1f} = {P_V1_c2 + P_V2_c2:.1f} mW")
print(f"          Total R   = {sum(P_R_c2):.1f} mW")
