"""Pagina 6: Factor de idealidad del diodo y LED."""

import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

import streamlit as st
import plotly.graph_objects as go
import numpy as np
import pandas as pd

from data import obtener_todos, V_T
from analysis import factor_idealidad

st.title("Factor de Idealidad")
st.markdown("Extraccion de $n$ del grafico semilogaritmico: $\\ln(I) = \\ln(I_s) + V/(nV_T)$")

datos = obtener_todos()

# --- Analisis para diodo y LED ---
componentes_analizar = ["diodo", "led"]

fig = go.Figure()
resultados_tabla = []

for nombre in componentes_analizar:
    comp = datos[nombre]

    # Sliders para seleccionar rango
    st.sidebar.subheader(f"{comp.nombre}")
    mask_positivo = comp.I > 0
    if not np.any(mask_positivo):
        continue

    V_range = st.sidebar.slider(
        f"Rango V - {comp.nombre}",
        float(comp.V[mask_positivo].min()),
        float(comp.V[mask_positivo].max()),
        (float(comp.V[mask_positivo].min()), float(comp.V[mask_positivo].max())),
        step=0.01,
        key=f"v_range_{nombre}",
    )

    n, I_s, r2, fit_data = factor_idealidad(
        comp.V, comp.I, V_min=V_range[0], V_max=V_range[1],
    )

    if fit_data is not None:
        V_fit, ln_I, resultado = fit_data

        # Datos semilog
        mask = comp.I > 0
        fig.add_trace(go.Scatter(
            x=comp.V[mask],
            y=np.log(comp.I[mask]),
            mode="markers",
            name=f"{comp.nombre} (datos)",
            marker=dict(color=comp.color, size=8),
        ))

        # Ajuste lineal
        V_linea = np.linspace(V_range[0], V_range[1], 100)
        ln_I_linea = resultado.slope * V_linea + resultado.intercept
        fig.add_trace(go.Scatter(
            x=V_linea,
            y=ln_I_linea,
            mode="lines",
            name=f"{comp.nombre} (ajuste, n={n:.2f})",
            line=dict(color=comp.color, width=2, dash="dash"),
        ))

        resultados_tabla.append({
            "Componente": comp.nombre,
            "n": f"{n:.3f}",
            "I_s [A]": f"{I_s:.3e}",
            "R^2": f"{r2:.4f}",
            "V_min [V]": f"{V_range[0]:.2f}",
            "V_max [V]": f"{V_range[1]:.2f}",
        })

fig.update_layout(
    xaxis_title="V [V]",
    yaxis_title="ln(I) [ln(A)]",
    template="plotly_white",
    height=600,
    hovermode="closest",
)

st.plotly_chart(fig, use_container_width=True)

# --- Tabla comparativa ---
st.subheader("Comparacion diodo vs LED")
if resultados_tabla:
    st.dataframe(pd.DataFrame(resultados_tabla), use_container_width=True, hide_index=True)

st.markdown(f"""
**Nota:** $V_T = kT/q = {V_T*1e3:.2f}$ mV a temperatura ambiente.
- Diodo ideal: $n = 1$ (difusion)
- Diodo real: $1 < n < 2$ (recombinacion en zona de deplexion)
- LED: $n$ puede ser mayor debido a la recombinacion radiativa y estructura del dispositivo
""")
