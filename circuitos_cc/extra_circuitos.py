"""
Extra: Analisis computacional del conexionado corto vs. largo.

Modela el error sistematico de cada conexionado en funcion de la resistencia
del componente y las resistencias internas de los instrumentos.
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


def error_corto(R, Rv):
    """
    Conexionado corto: voltimetro en paralelo solo con R.
    R_medido = R * Rv / (R + Rv)
    Error relativo = -R / (R + Rv)
    """
    return -R / (R + Rv)


def error_largo(R, Ra):
    """
    Conexionado largo: voltimetro abarca R + amperimetro.
    R_medido = R + Ra
    Error relativo = Ra / R
    """
    return Ra / R


# Parametros tipicos de multimetro digital
Rv = 10e6   # Resistencia interna voltimetro: 10 MOhm
Ra = 1.0    # Resistencia interna amperimetro: ~1 Ohm

R_range = np.logspace(0, 8, 1000)  # 1 Ohm a 100 MOhm

err_cc = np.abs(error_corto(R_range, Rv)) * 100
err_cl = np.abs(error_largo(R_range, Ra)) * 100

# Punto critico: donde ambos errores son iguales
# R/(R+Rv) = Ra/R  =>  R^2 = Ra*(R+Rv)  =>  R^2 - Ra*R - Ra*Rv = 0
R_critico = (Ra + np.sqrt(Ra**2 + 4 * Ra * Rv)) / 2
print(f"Resistencia critica (crossover): {R_critico:.0f} Ohm = {R_critico/1e3:.1f} kOhm")
print(f"  Para R < {R_critico:.0f} Ohm: conviene conexionado largo")
print(f"  Para R > {R_critico:.0f} Ohm: conviene conexionado corto")

# Resistencias del TP con posiciones de etiqueta (nombre, R, offset_x, offset_y)
R_tp_labels = [
    (r"$R_3$ = 150 $\Omega$",  150,    25, -30),
    (r"$R_1$ = 220 $\Omega$",  220,    45, -60),
    (r"$R_2$ = 330 $\Omega$",  330,    65, -90),
    (r"10 M$\Omega$",          10e6,  -80,  15),
]

fig, ax = plt.subplots(figsize=(10, 6))

ax.loglog(R_range, err_cc, label="Conexionado corto (CC)", color="#2563eb", linewidth=2)
ax.loglog(R_range, err_cl, label="Conexionado largo (CL)", color="#dc2626", linewidth=2)
ax.axvline(R_critico, color="gray", linestyle="--", alpha=0.7, linewidth=1)
ax.text(R_critico * 1.5, 40, f"$R_{{critico}}$ = {R_critico/1e3:.1f} k$\\Omega$",
        fontsize=10, color="gray")

# Marcar resistencias del TP
for nombre, R_val, ox, oy in R_tp_labels:
    err_cc_val = abs(error_corto(R_val, Rv)) * 100
    err_cl_val = abs(error_largo(R_val, Ra)) * 100
    err_mejor = min(err_cc_val, err_cl_val)
    ax.plot(R_val, err_mejor, "ko", markersize=7, zorder=5)
    ax.annotate(nombre, (R_val, err_mejor),
                textcoords="offset points", xytext=(ox, oy),
                fontsize=9, fontweight="bold",
                bbox=dict(boxstyle="round,pad=0.3", fc="white", ec="gray", alpha=0.9),
                arrowprops=dict(arrowstyle="->", color="black", lw=0.8))

# Sombreado suave solo entre las curvas
mask_cl = R_range <= R_critico
mask_cc = R_range >= R_critico
ax.fill_between(R_range[mask_cl], err_cc[mask_cl], err_cl[mask_cl],
                alpha=0.10, color="#dc2626", label="Zona optima CL")
ax.fill_between(R_range[mask_cc], err_cl[mask_cc], err_cc[mask_cc],
                alpha=0.10, color="#2563eb", label="Zona optima CC")

ax.set_xlabel(r"Resistencia del componente ($\Omega$)")
ax.set_ylabel("Error relativo de medicion (%)")
ax.set_title(f"Error segun conexionado ($R_V$ = {Rv/1e6:.0f} M$\\Omega$, $R_A$ = {Ra:.0f} $\\Omega$)")
ax.legend(fontsize=9, loc="lower right")
ax.set_ylim(1e-4, 100)
ax.set_xlim(1, 1e8)

fig.tight_layout()
fig.savefig(OUT / "corto_vs_largo.png", dpi=200, bbox_inches="tight")
plt.close(fig)
print(f"Guardado: {OUT / 'corto_vs_largo.png'}")

# Tabla de errores para cada resistencia del TP
print(f"\n{'Componente':>20} {'Err CC (%)':>12} {'Err CL (%)':>12} {'Mejor':>8}")
for nombre, R_val, _, _ in R_tp_labels:
    err_cc_val = abs(error_corto(R_val, Rv)) * 100
    err_cl_val = abs(error_largo(R_val, Ra)) * 100
    mejor = "CC" if err_cc_val < err_cl_val else "CL"
    print(f"  {R_val:>15.0f} Ohm {err_cc_val:>12.4f} {err_cl_val:>12.4f} {mejor:>8}")
