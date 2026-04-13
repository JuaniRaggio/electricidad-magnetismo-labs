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
    if st.button("Ir al TP1", key="btn_tp1", type="primary"):
        st.session_state.current_tp = "tp1"
        st.rerun()

# with st.container(border=True):
#     st.subheader("TP2 - ...")
#     st.markdown("Descripcion del TP2.")
#     if st.button("Ir al TP2", key="btn_tp2", type="primary"):
#         st.session_state.current_tp = "tp2"
#         st.rerun()

st.markdown("---")
st.markdown("""
**Integrantes:** Raggio, Moralejo, Pipet, Olivero, Abramzon

**Jefe de Catedra:** Andres Medus

**Fisica III | ITBA**
""")
