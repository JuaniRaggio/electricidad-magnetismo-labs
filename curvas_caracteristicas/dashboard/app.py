"""Dashboard Interactivo - Curvas Caracteristicas I-V | TP1 Fisica III ITBA."""

import sys
import os
sys.path.insert(0, os.path.dirname(__file__))

import streamlit as st
import pandas as pd
import numpy as np

from data import obtener_todos
from models import MODELOS
from fitting import ajustar_componente

st.set_page_config(
    page_title="Curvas I-V | TP1 Fisica III",
    page_icon="",
    layout="wide",
    initial_sidebar_state="expanded",
)

st.title("Curvas Caracteristicas I-V")
st.markdown("**TP1 - Fisica III | ITBA**")

# --- Sidebar ---
with st.sidebar:
    st.header("Informacion")
    st.markdown("""
    **Trabajo Practico 1**
    Curvas caracteristicas de componentes electricos

    **Integrantes:**
    - Juan Ignacio Raggio
    - Catalina Moralejo
    - Milagros Maria Pipet
    - Olivero
    - Abramzon

    **Jefe de Catedra:** Andres Medus

    **Componentes:**
    - Resistencia
    - Diodo
    - Lampara incandescente
    - LED
    """)

# --- Metricas resumen ---
datos = obtener_todos()

st.header("Resultados principales")
col1, col2, col3, col4 = st.columns(4)

# Ajustar cada componente y mostrar metrica clave
try:
    res_r = ajustar_componente(datos["resistencia"], MODELOS["resistencia"])
    col1.metric("R (Resistencia)", f"{res_r.parametros[0]:.1f} Ohm")
except Exception:
    col1.metric("R (Resistencia)", "Error")

try:
    res_d = ajustar_componente(datos["diodo"], MODELOS["diodo"])
    col2.metric("n (Diodo)", f"{res_d.parametros[1]:.2f}")
except Exception:
    col2.metric("n (Diodo)", "Error")

try:
    res_l = ajustar_componente(datos["lampara"], MODELOS["lampara"])
    col3.metric("b (Lampara)", f"{res_l.parametros[1]:.3f}")
except Exception:
    col3.metric("b (Lampara)", "Error")

try:
    res_led = ajustar_componente(datos["led"], MODELOS["led"])
    col4.metric("n (LED)", f"{res_led.parametros[1]:.2f}")
except Exception:
    col4.metric("n (LED)", "Error")

# --- Tablas de datos ---
st.header("Datos experimentales")

for nombre, comp in datos.items():
    with st.expander(f"Datos: {comp.nombre}"):
        df = pd.DataFrame({
            "V [V]": comp.V,
            "I [mA]": comp.I * 1e3,
            "delta_V [V]": comp.delta_V,
            "delta_I [mA]": comp.delta_I * 1e3,
        })
        st.dataframe(df, use_container_width=True, hide_index=True)

st.markdown("---")
st.markdown("Usa el menu lateral para navegar las paginas de analisis.")
