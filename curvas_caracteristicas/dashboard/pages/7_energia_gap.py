"""Pagina 7: Energia del gap del LED."""

import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

import streamlit as st
import plotly.graph_objects as go
import numpy as np
import pandas as pd

from data import obtener_todos, q, h, c
from analysis import energia_gap_led

st.set_page_config(page_title="Energia Gap LED", layout="wide")
st.title("Energia del Gap del LED")
st.markdown("Estimacion de $E_g$ y $\\lambda$ a partir de la tension umbral $V_{th}$")

datos = obtener_todos()
comp = datos["led"]

# --- Controles ---
col1, col2 = st.columns(2)
with col1:
    metodo = st.radio("Metodo de estimacion", ["tangente", "derivada"])
with col2:
    # Valor conocido para LED rojo tipico
    lambda_conocido = st.number_input(
        "Lambda conocido [nm] (referencia)", value=700.0, step=10.0,
    )

# --- Calculo ---
resultado = energia_gap_led(comp.V, comp.I, metodo=metodo)

# --- Metricas ---
st.subheader("Resultados")
col_m1, col_m2, col_m3, col_m4 = st.columns(4)
col_m1.metric("V_umbral", f"{resultado['V_th']:.3f} V")
col_m2.metric("E_g", f"{resultado['E_g_eV']:.3f} eV")
col_m3.metric("Lambda", f"{resultado['lambda_nm']:.1f} nm")

error_pct = abs(resultado["lambda_nm"] - lambda_conocido) / lambda_conocido * 100
col_m4.metric("Error vs conocido", f"{error_pct:.1f}%")

# --- Grafico ---
fig = go.Figure()

# Datos I-V
fig.add_trace(go.Scatter(
    x=comp.V, y=comp.I * 1e3,
    mode="markers",
    name="Datos",
    marker=dict(color=comp.color, size=8),
))

if metodo == "tangente":
    info = resultado["info"]
    # Linea tangente
    V_ext = np.linspace(resultado["V_th"] - 0.1, comp.V.max() + 0.1, 100)
    I_tang = (info["pendiente"] * V_ext + info["intercepto"]) * 1e3
    I_tang = np.clip(I_tang, -5, comp.I.max() * 1.2 * 1e3)

    fig.add_trace(go.Scatter(
        x=V_ext, y=I_tang,
        mode="lines",
        name="Tangente",
        line=dict(color="red", width=2, dash="dash"),
    ))

    # V_umbral
    fig.add_vline(x=resultado["V_th"], line_dash="dot", line_color="gray",
                  annotation_text=f"V_th = {resultado['V_th']:.3f} V")

elif metodo == "derivada":
    info = resultado["info"]
    # Grafico de derivada como segundo eje
    fig.add_trace(go.Scatter(
        x=comp.V, y=info["dI_dV"] * 1e3,
        mode="lines",
        name="dI/dV",
        line=dict(color="orange", width=1.5),
        yaxis="y2",
    ))

    fig.add_vline(x=resultado["V_th"], line_dash="dot", line_color="gray",
                  annotation_text=f"V_th = {resultado['V_th']:.3f} V")

    fig.update_layout(
        yaxis2=dict(
            title="dI/dV [mA/V]",
            overlaying="y",
            side="right",
        ),
    )

fig.update_layout(
    xaxis_title="V [V]",
    yaxis_title="I [mA]",
    template="plotly_white",
    height=500,
)

st.plotly_chart(fig, use_container_width=True)

# --- Tabla interpretacion ---
st.subheader("Interpretacion")

E_g_conocido = h * c / (lambda_conocido * 1e-9) / q  # en eV

comparacion = pd.DataFrame([
    {"Magnitud": "V_umbral [V]", "Medido": f"{resultado['V_th']:.3f}", "Referencia": "-"},
    {"Magnitud": "E_g [eV]", "Medido": f"{resultado['E_g_eV']:.3f}", "Referencia": f"{E_g_conocido:.3f}"},
    {"Magnitud": "Lambda [nm]", "Medido": f"{resultado['lambda_nm']:.1f}", "Referencia": f"{lambda_conocido:.0f}"},
])
st.dataframe(comparacion, use_container_width=True, hide_index=True)

st.markdown("""
**Relaciones usadas:**
- $E_g = q \\cdot V_{th}$
- $\\lambda = hc / E_g$
- LED rojo tipico: $\\lambda \\approx 620-750$ nm, $E_g \\approx 1.65-2.0$ eV
""")
