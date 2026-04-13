"""Hub Central - Laboratorios de Electricidad y Magnetismo | Fisica III ITBA."""

import streamlit as st

st.set_page_config(
    page_title="Fisica III - Labs",
    layout="centered",
    initial_sidebar_state="collapsed",
)

st.title("Electricidad y Magnetismo")
st.markdown("**Fisica III | ITBA**")

st.markdown("---")

st.header("Laboratorios")

# --- TP1 ---
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
    # Descomentar y reemplazar URL cuando este deployado:
    # st.link_button("Abrir dashboard", "https://tu-app.streamlit.app")
    st.info("Ejecutar localmente: `streamlit run curvas_caracteristicas/dashboard/app.py`")

# --- TPs futuros (descomentar cuando se agreguen) ---

# with st.container(border=True):
#     st.subheader("TP2 - ...")
#     st.markdown("Descripcion del TP2.")
#     st.info("Ejecutar localmente: `streamlit run tp2/dashboard/app.py`")

# with st.container(border=True):
#     st.subheader("TP3 - ...")
#     st.markdown("Descripcion del TP3.")
#     st.info("Ejecutar localmente: `streamlit run tp3/dashboard/app.py`")

st.markdown("---")

st.markdown("""
**Integrantes:** Raggio, Moralejo, Pipet, Olivero, Abramzon

**Jefe de Catedra:** Andres Medus
""")
