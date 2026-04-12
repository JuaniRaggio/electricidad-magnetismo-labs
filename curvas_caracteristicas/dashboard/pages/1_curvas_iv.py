"""Pagina 1: Explorador interactivo de curvas I-V."""

import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

import streamlit as st
import plotly.graph_objects as go
import numpy as np

from data import obtener_todos

st.set_page_config(page_title="Curvas I-V", layout="wide")
st.title("Curvas I-V - Explorador Interactivo")

datos = obtener_todos()

# --- Controles ---
col_ctrl1, col_ctrl2 = st.columns(2)

with col_ctrl1:
    componentes_sel = st.multiselect(
        "Componentes",
        options=list(datos.keys()),
        default=list(datos.keys()),
        format_func=lambda x: datos[x].nombre,
    )

with col_ctrl2:
    mostrar_errores = st.checkbox("Mostrar barras de error", value=True)
    escala_log = st.checkbox("Escala logaritmica en I", value=False)

# --- Grafico ---
fig = go.Figure()

for nombre in componentes_sel:
    comp = datos[nombre]

    error_y_config = None
    error_x_config = None
    if mostrar_errores:
        error_y_config = dict(type="data", array=comp.delta_I * 1e3, visible=True)
        error_x_config = dict(type="data", array=comp.delta_V, visible=True)

    fig.add_trace(go.Scatter(
        x=comp.V,
        y=comp.I * 1e3,
        mode="markers+lines",
        name=comp.nombre,
        marker=dict(color=comp.color, size=8),
        line=dict(color=comp.color, width=1.5),
        error_y=error_y_config,
        error_x=error_x_config,
    ))

fig.update_layout(
    xaxis_title="Tension [V]",
    yaxis_title="Corriente [mA]",
    yaxis_type="log" if escala_log else "linear",
    template="plotly_white",
    height=600,
    legend=dict(x=0.02, y=0.98),
    hovermode="closest",
)

st.plotly_chart(fig, use_container_width=True)

# --- Tabla comparativa ---
st.subheader("Resumen de datos")
resumen = []
for nombre, comp in datos.items():
    resumen.append({
        "Componente": comp.nombre,
        "Puntos": comp.n_puntos,
        "V_min [V]": f"{comp.V.min():.2f}",
        "V_max [V]": f"{comp.V.max():.2f}",
        "I_min [mA]": f"{comp.I.min()*1e3:.2f}",
        "I_max [mA]": f"{comp.I.max()*1e3:.2f}",
    })

import pandas as pd
st.dataframe(pd.DataFrame(resumen), use_container_width=True, hide_index=True)
