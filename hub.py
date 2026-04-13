"""Hub Central - Laboratorios de Electricidad y Magnetismo | Fisica III ITBA."""

import streamlit as st

st.set_page_config(
    page_title="Fisica III - Labs",
    layout="wide",
    initial_sidebar_state="expanded",
)

# --- Navegacion con secciones ---
pg = st.navigation({
    "Inicio": [
        st.Page("pages/inicio.py", title="Hub", default=True),
    ],
    "TP1 - Curvas Caracteristicas": [
        st.Page("curvas_caracteristicas/dashboard/pages/0_resumen.py", title="Resumen"),
        st.Page("curvas_caracteristicas/dashboard/pages/1_curvas_iv.py", title="Curvas I-V"),
        st.Page("curvas_caracteristicas/dashboard/pages/2_ajuste_interactivo.py", title="Ajuste Interactivo"),
        st.Page("curvas_caracteristicas/dashboard/pages/3_resistencia_dinamica.py", title="Resistencia Dinamica"),
        st.Page("curvas_caracteristicas/dashboard/pages/4_monte_carlo.py", title="Monte Carlo"),
        st.Page("curvas_caracteristicas/dashboard/pages/5_temperatura_filamento.py", title="Temperatura Filamento"),
        st.Page("curvas_caracteristicas/dashboard/pages/6_factor_idealidad.py", title="Factor de Idealidad"),
        st.Page("curvas_caracteristicas/dashboard/pages/7_energia_gap.py", title="Energia Gap LED"),
    ],
    # "TP2 - ...": [
    #     st.Page("tp2/dashboard/pages/...", title="..."),
    # ],
})

# --- Sidebar comun ---
with st.sidebar:
    st.markdown("---")
    st.markdown("""
    **Integrantes:**
    Raggio, Moralejo, Pipet, Olivero, Abramzon

    **Jefe de Catedra:** Andres Medus

    **Fisica III | ITBA**
    """)

pg.run()
