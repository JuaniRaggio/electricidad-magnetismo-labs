"""
Extra: Analisis computacional de circuitos CC mediante las leyes de Kirchhoff.

1. Resolucion matricial de los circuitos (nodos + mallas)
2. Analisis de sensibilidad: como cambian las corrientes al variar cada resistencia
3. Analisis conexionado corto vs. largo: error en funcion de R_componente / R_voltimetro
"""

import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

plt.rcParams.update({
    "font.family": "serif",
    "font.size": 11,
    "axes.grid": True,
    "grid.alpha": 0.3,
    "figure.figsize": (8, 5),
})

OUT = Path(__file__).parent / "assets"
OUT.mkdir(exist_ok=True)

# =============================================
# 1. RESOLUCION MATRICIAL DE KIRCHHOFF
# =============================================

def resolver_circuito(R1, R2, R3, V1, V2):
    """
    Resuelve el circuito de dos mallas con tres ramas.

    Sistema de ecuaciones:
        Nodo:    I1 - I2 - I3 = 0
        Malla 1: R1*I1 + R2*I2 = V1
        Malla 2: -R2*I2 + R3*I3 = V2

    Retorna I1, I2, I3 en Ampere.
    """
    A = np.array([
        [1,    -1,   -1 ],
        [R1,    R2,   0  ],
        [0,    -R2,   R3 ],
    ])
    b = np.array([0, V1, V2])
    return np.linalg.solve(A, b)


# Valores nominales
R1, R2, R3 = 220, 330, 150

# Circuito 1: fuente normal
V1_c1, V2_c1 = 9.0, 1.5
I_c1 = resolver_circuito(R1, R2, R3, V1_c1, V2_c1)

# Circuito 2: fuente invertida (con valores medidos de las pilas)
V1_c2, V2_c2 = 9.22, -2.66
I_c2 = resolver_circuito(R1, R2, R3, V1_c2, V2_c2)

# Valores medidos en laboratorio
I_med_c1 = np.array([23.3, 13.0, 10.03]) * 1e-3
I_med_c2 = np.array([32.2, 6.8, 3.1]) * 1e-3

print("=" * 60)
print("Resolucion matricial de kirchhoff")
print("=" * 60)

for nombre, I_calc, I_med in [
    ("Circuito 1 (normal)", I_c1, I_med_c1),
    ("Circuito 2 (invertida)", I_c2, I_med_c2),
]:
    print(f"\n{nombre}:")
    print(f"  {'Corriente':>10} {'Calculada':>12} {'Medida':>12} {'Error %':>10}")
    for i in range(3):
        err = abs(I_calc[i] - I_med[i]) / abs(I_med[i]) * 100
        print(f"  {'I' + str(i+1):>10} {I_calc[i]*1e3:>10.2f} mA {I_med[i]*1e3:>10.2f} mA {err:>8.1f} %")

    # Verificacion ley de nodos
    residuo_nodos = I_calc[0] - I_calc[1] - I_calc[2]
    print(f"  Verificacion nodos (I1 - I2 - I3): {residuo_nodos:.2e} A")

    residuo_nodos_med = I_med[0] - I_med[1] - I_med[2]
    print(f"  Verificacion nodos medidos: {residuo_nodos_med*1e3:.2f} mA")

# --- Grafico comparativo ---
fig, axes = plt.subplots(1, 2, figsize=(12, 5))

labels = [r"$I_1$", r"$I_2$", r"$I_3$"]
x = np.arange(3)
w = 0.3

for ax, nombre, I_calc, I_med in [
    (axes[0], "Circuito 1 (fuente normal)", I_c1, I_med_c1),
    (axes[1], "Circuito 2 (fuente invertida)", I_c2, I_med_c2),
]:
    bars1 = ax.bar(x - w/2, I_calc * 1e3, w, label="Calculada (Kirchhoff)", color="#2563eb", alpha=0.85)
    bars2 = ax.bar(x + w/2, I_med * 1e3, w, label="Medida (lab)", color="#dc2626", alpha=0.85)

    for bar, val in zip(bars1, I_calc * 1e3):
        ax.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 0.3,
                f"{val:.1f}", ha="center", va="bottom", fontsize=9)
    for bar, val in zip(bars2, I_med * 1e3):
        ax.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 0.3,
                f"{val:.1f}", ha="center", va="bottom", fontsize=9)

    ax.set_xticks(x)
    ax.set_xticklabels(labels)
    ax.set_ylabel("Corriente (mA)")
    ax.set_title(nombre)
    ax.legend(fontsize=9)

fig.tight_layout()
fig.savefig(OUT / "comparacion_corrientes.png", dpi=200, bbox_inches="tight")
plt.close(fig)
print(f"\nGuardado: {OUT / 'comparacion_corrientes.png'}")


# =============================================
# 2. ANALISIS DE SENSIBILIDAD
# =============================================

print("\n" + "=" * 60)
print("ANALISIS DE SENSIBILIDAD")
print("=" * 60)

def sensibilidad(R1_base, R2_base, R3_base, V1, V2, delta_pct=5):
    """
    Varia cada resistencia +-delta_pct% y calcula el cambio en cada corriente.
    Retorna matriz de sensibilidad (3x3): fila = resistencia variada, col = corriente afectada.
    """
    I_base = resolver_circuito(R1_base, R2_base, R3_base, V1, V2)
    resistencias = [R1_base, R2_base, R3_base]
    nombres_R = ["R1", "R2", "R3"]
    sens = np.zeros((3, 3))

    for i in range(3):
        R_mod = resistencias.copy()
        # Derivada centrada: (I(R+dR) - I(R-dR)) / (2*dR) * R (sensibilidad relativa)
        dR = resistencias[i] * delta_pct / 100

        R_mod_plus = resistencias.copy()
        R_mod_plus[i] += dR
        I_plus = resolver_circuito(*R_mod_plus, V1, V2)

        R_mod_minus = resistencias.copy()
        R_mod_minus[i] -= dR
        I_minus = resolver_circuito(*R_mod_minus, V1, V2)

        # Sensibilidad: cambio porcentual en I por cambio porcentual en R
        for j in range(3):
            if abs(I_base[j]) > 1e-12:
                sens[i, j] = ((I_plus[j] - I_minus[j]) / (2 * dR)) * (resistencias[i] / I_base[j])

    return sens, I_base


sens_c1, I_base_c1 = sensibilidad(R1, R2, R3, V1_c1, V2_c1)
sens_c2, I_base_c2 = sensibilidad(R1, R2, R3, V1_c2, V2_c2)

nombres_R = [r"$R_1$ (220 $\Omega$)", r"$R_2$ (330 $\Omega$)", r"$R_3$ (150 $\Omega$)"]
nombres_I = [r"$I_1$", r"$I_2$", r"$I_3$"]

fig, axes = plt.subplots(1, 2, figsize=(13, 5))

for ax, sens, titulo in [
    (axes[0], sens_c1, "Circuito 1 (fuente normal)"),
    (axes[1], sens_c2, "Circuito 2 (fuente invertida)"),
]:
    im = ax.imshow(sens, cmap="RdBu_r", vmin=-1.5, vmax=1.5, aspect="auto")
    ax.set_xticks(range(3))
    ax.set_xticklabels(nombres_I)
    ax.set_yticks(range(3))
    ax.set_yticklabels(nombres_R)
    ax.set_xlabel("Corriente afectada")
    ax.set_ylabel("Resistencia variada")
    ax.set_title(titulo)

    for i in range(3):
        for j in range(3):
            color = "white" if abs(sens[i, j]) > 0.8 else "black"
            ax.text(j, i, f"{sens[i, j]:.2f}", ha="center", va="center",
                    fontsize=11, fontweight="bold", color=color)

fig.colorbar(im, ax=axes, label=r"$\frac{\partial I / I}{\partial R / R}$ (sensibilidad relativa)", shrink=0.8)
fig.suptitle("Sensibilidad de las corrientes a variaciones en las resistencias", fontsize=13, y=1.02)
fig.tight_layout()
fig.savefig(OUT / "sensibilidad.png", dpi=200, bbox_inches="tight")
plt.close(fig)
print(f"Guardado: {OUT / 'sensibilidad.png'}")

# Imprimir tabla
for titulo, sens in [("Circuito 1", sens_c1), ("Circuito 2", sens_c2)]:
    print(f"\n{titulo} - Sensibilidad relativa (dI/I)/(dR/R):")
    print(f"  {'':>15} {'I1':>8} {'I2':>8} {'I3':>8}")
    for i, nombre in enumerate(["R1 (220)", "R2 (330)", "R3 (150)"]):
        print(f"  {nombre:>15} {sens[i,0]:>8.3f} {sens[i,1]:>8.3f} {sens[i,2]:>8.3f}")


# =============================================
# 3. ANALISIS CONEXIONADO CORTO VS LARGO
# =============================================

print("\n" + "=" * 60)
print("ANALISIS CONEXIONADO CORTO VS LARGO")
print("=" * 60)

def error_corto(R, Rv):
    """
    Conexionado corto: voltimetro en paralelo solo con R.
    El voltimetro mide correctamente V_R, pero el amperimetro mide
    I_total = I_R + I_V = V/R + V/Rv.
    R_medido = V / I_total = R * Rv / (R + Rv)
    Error relativo = -R / (R + Rv)
    """
    return -R / (R + Rv)


def error_largo(R, Ra):
    """
    Conexionado largo: voltimetro abarca R + amperimetro.
    El amperimetro mide correctamente I_R, pero el voltimetro mide
    V_total = I*(R + Ra).
    R_medido = V_total / I = R + Ra
    Error relativo = Ra / R
    """
    return Ra / R


Rv = 10e6   # Resistencia interna voltimetro: 10 MOhm
Ra = 1.0    # Resistencia interna amperimetro: ~1 Ohm

R_range = np.logspace(0, 8, 1000)  # 1 Ohm a 100 MOhm

err_cc = np.abs(error_corto(R_range, Rv)) * 100
err_cl = np.abs(error_largo(R_range, Ra)) * 100

# Punto critico: donde ambos errores son iguales
# R/(R+Rv) = Ra/R  =>  R^2 = Ra*(R+Rv)  =>  R^2 - Ra*R - Ra*Rv = 0
R_critico = (Ra + np.sqrt(Ra**2 + 4 * Ra * Rv)) / 2
print(f"\nResistencia critica (crossover): {R_critico:.0f} Ohm = {R_critico/1e3:.1f} kOhm")
print(f"  Para R < {R_critico:.0f} Ohm: conviene conexionado largo")
print(f"  Para R > {R_critico:.0f} Ohm: conviene conexionado corto")

# Valores del TP
R_tp = {
    r"$R_1$ = 220 $\Omega$": 220,
    r"$R_2$ = 330 $\Omega$": 330,
    r"$R_3$ = 150 $\Omega$": 150,
    r"10 M$\Omega$": 10e6,
}

fig, ax = plt.subplots(figsize=(10, 6))

ax.loglog(R_range, err_cc, label="Conexionado corto (CC)", color="#2563eb", linewidth=2)
ax.loglog(R_range, err_cl, label="Conexionado largo (CL)", color="#dc2626", linewidth=2)
ax.axvline(R_critico, color="gray", linestyle="--", alpha=0.7, linewidth=1)
ax.text(R_critico * 1.3, 30, f"$R_{{critico}}$ = {R_critico/1e3:.1f} k$\\Omega$",
        fontsize=10, color="gray")

# Marcar resistencias del TP
for nombre, R_val in R_tp.items():
    err_cc_val = abs(error_corto(R_val, Rv)) * 100
    err_cl_val = abs(error_largo(R_val, Ra)) * 100
    mejor = "CC" if err_cc_val < err_cl_val else "CL"
    err_mejor = min(err_cc_val, err_cl_val)
    ax.plot(R_val, err_mejor, "ko", markersize=8, zorder=5)
    ax.annotate(nombre, (R_val, err_mejor),
                textcoords="offset points", xytext=(10, 10),
                fontsize=9, arrowprops=dict(arrowstyle="->", color="black", lw=0.8))

# Region optima
ax.fill_between(R_range[R_range <= R_critico],
                err_cl[R_range <= R_critico], 0.001,
                alpha=0.08, color="#dc2626", label="Zona optima CL")
ax.fill_between(R_range[R_range >= R_critico],
                err_cc[R_range >= R_critico], 0.001,
                alpha=0.08, color="#2563eb", label="Zona optima CC")

ax.set_xlabel(r"Resistencia del componente ($\Omega$)")
ax.set_ylabel("Error relativo de medicion (%)")
ax.set_title(f"Error de medicion segun conexionado ($R_V$ = {Rv/1e6:.0f} M$\\Omega$, $R_A$ = {Ra:.0f} $\\Omega$)")
ax.legend(fontsize=9)
ax.set_ylim(1e-4, 100)
ax.set_xlim(1, 1e8)

fig.tight_layout()
fig.savefig(OUT / "corto_vs_largo.png", dpi=200, bbox_inches="tight")
plt.close(fig)
print(f"Guardado: {OUT / 'corto_vs_largo.png'}")

# Tabla de errores para cada resistencia del TP
print(f"\n{'Componente':>20} {'Err CC (%)':>12} {'Err CL (%)':>12} {'Mejor':>8}")
for nombre, R_val in R_tp.items():
    err_cc_val = abs(error_corto(R_val, Rv)) * 100
    err_cl_val = abs(error_largo(R_val, Ra)) * 100
    mejor = "CC" if err_cc_val < err_cl_val else "CL"
    print(f"  {R_val:>15.0f} Ohm {err_cc_val:>12.4f} {err_cl_val:>12.4f} {mejor:>8}")

print("\nAnalisis completo.")
