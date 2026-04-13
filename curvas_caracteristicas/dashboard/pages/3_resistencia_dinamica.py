"""Pagina 3: Resistencia dinamica r(V) = dV/dI."""

import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

import streamlit as st
import plotly.graph_objects as go
import numpy as np
import pandas as pd

from data import obtener_todos
from analysis import resistencia_dinamica

st.title("Resistencia Dinamica")
st.markdown("$r(V) = dV/dI$ - pendiente local de la curva I-V")

datos = obtener_todos()

# --- Controles ---
col1, col2 = st.columns(2)
with col1:
    componentes_sel = st.multiselect(
        "Componentes",
        options=list(datos.keys()),
        default=list(datos.keys()),
        format_func=lambda x: datos[x].nombre,
    )
with col2:
    ventana = st.slider("Ventana de suavizado (Savitzky-Golay)", 3, 15, 5, step=2)
    escala_log = st.checkbox("Escala logaritmica", value=True)

# --- Grafico ---
fig = go.Figure()

for nombre in componentes_sel:
    comp = datos[nombre]
    r_din = resistencia_dinamica(comp.V, comp.I, window=ventana)

    fig.add_trace(go.Scatter(
        x=comp.V,
        y=r_din,
        mode="markers+lines",
        name=comp.nombre,
        marker=dict(color=comp.color, size=6),
        line=dict(color=comp.color, width=1.5),
    ))

fig.update_layout(
    xaxis_title="Tension [V]",
    yaxis_title="r(V) [Ohm]",
    yaxis_type="log" if escala_log else "linear",
    template="plotly_white",
    height=600,
    hovermode="closest",
)

st.plotly_chart(fig, use_container_width=True)

# --- Tabla interpretacion ---
st.subheader("Interpretacion fisica")

interpretaciones = {
    "resistencia": "r(V) constante: comportamiento ohmico, r = R",
    "diodo": "r(V) decrece exponencialmente con V: zona de conduccion directa",
    "lampara": "r(V) crece con V: aumento de temperatura del filamento aumenta resistividad",
    "led": "r(V) decrece con V a partir del umbral: similar al diodo pero con mayor V_umbral",
}

tabla = []
for nombre in componentes_sel:
    comp = datos[nombre]
    r_din = resistencia_dinamica(comp.V, comp.I, window=ventana)
    tabla.append({
        "Componente": comp.nombre,
        "r_min [Ohm]": f"{np.min(r_din):.1f}",
        "r_max [Ohm]": f"{np.max(r_din):.1f}",
        "r_promedio [Ohm]": f"{np.mean(r_din):.1f}",
        "Interpretacion": interpretaciones.get(nombre, ""),
    })

st.dataframe(pd.DataFrame(tabla), use_container_width=True, hide_index=True)
