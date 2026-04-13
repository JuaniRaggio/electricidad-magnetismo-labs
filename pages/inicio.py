"""Pagina de inicio del Hub."""

import streamlit as st

st.title("Electricidad y Magnetismo")
st.markdown("**Laboratorios | Fisica III | ITBA**")

st.markdown("---")

st.header("Laboratorios")

with st.container(border=True):
    st.subheader("TP1 - Curvas Caracteristicas I-V")
    st.markdown("""
    Analisis interactivo de curvas I-V de resistencia, diodo, lampara y LED.
    Incluye ajuste de modelos, Monte Carlo, resistencia dinamica,
    temperatura del filamento y energia del gap.
    """)
    col1, col2 = st.columns(2)
    col1.markdown("**Componentes:** Resistencia, Diodo, Lampara, LED")
    col2.markdown("**Paginas:** 7 modulos de analisis")
    st.page_link("curvas_caracteristicas/dashboard/pages/0_resumen.py", label="Ir al TP1", icon=":material/arrow_forward:")

# with st.container(border=True):
#     st.subheader("TP2 - ...")
#     st.markdown("Descripcion del TP2.")
#     st.page_link("tp2/dashboard/pages/...", label="Ir al TP2", icon=":material/arrow_forward:")
