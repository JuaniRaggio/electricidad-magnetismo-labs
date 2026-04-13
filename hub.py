"""Hub Central - Laboratorios de Electricidad y Magnetismo | Fisica III ITBA."""

import streamlit as st

st.set_page_config(
    page_title="Fisica III - Labs",
    layout="wide",
)

if "current_tp" not in st.session_state:
    st.session_state.current_tp = None

if st.session_state.current_tp is None:
    # --- Hub: sin sidebar ---
    pg = st.navigation(
        [st.Page("pages/inicio.py", title="Hub")],
        position="hidden",
    )

else:  # curvas caracteristicas (agregar mas elif cuando haya mas TPs)
    # --- Curvas Caracteristicas: con sidebar ---
    pg = st.navigation([
        st.Page("curvas_caracteristicas/dashboard/pages/0_resumen.py", title="Resumen", default=True),
        st.Page("curvas_caracteristicas/dashboard/pages/1_curvas_iv.py", title="Curvas I-V"),
        st.Page("curvas_caracteristicas/dashboard/pages/2_ajuste_interactivo.py", title="Ajuste Interactivo"),
        st.Page("curvas_caracteristicas/dashboard/pages/3_resistencia_dinamica.py", title="Resistencia Dinamica"),
        st.Page("curvas_caracteristicas/dashboard/pages/4_monte_carlo.py", title="Monte Carlo"),
        st.Page("curvas_caracteristicas/dashboard/pages/5_temperatura_filamento.py", title="Temperatura Filamento"),
        st.Page("curvas_caracteristicas/dashboard/pages/6_factor_idealidad.py", title="Factor de Idealidad"),
        st.Page("curvas_caracteristicas/dashboard/pages/7_energia_gap.py", title="Energia Gap LED"),
    ])

    with st.sidebar:
        if st.button("Volver al Hub"):
            st.session_state.current_tp = None
            st.rerun()
        st.markdown("---")
        st.markdown("""
        **Integrantes:**
        Raggio, Moralejo, Pipet, Olivero, Abramzon

        **Jefe de Catedra:** Andres Medus
        """)

pg.run()
