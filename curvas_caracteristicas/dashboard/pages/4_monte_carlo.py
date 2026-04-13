"""Pagina 4: Simulacion Monte Carlo."""

import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

import streamlit as st
import plotly.graph_objects as go
import numpy as np

from data import obtener_todos
from models import MODELOS
from fitting import ajustar_componente, monte_carlo

st.title("Simulacion Monte Carlo")
st.markdown("Propagacion de incertidumbres experimentales mediante perturbacion gaussiana de los datos.")

datos = obtener_todos()

# --- Controles ---
col1, col2 = st.columns(2)
with col1:
    componente = st.selectbox(
        "Componente",
        options=list(datos.keys()),
        format_func=lambda x: datos[x].nombre,
    )
with col2:
    N_mc = st.select_slider("Iteraciones MC", options=[100, 500, 1000, 5000, 10000], value=1000)

comp = datos[componente]
modelo_info = MODELOS[componente]

# --- Ejecucion ---
ejecutar = st.button("Ejecutar Monte Carlo", type="primary")

if ejecutar:
    with st.spinner(f"Ejecutando {N_mc} iteraciones..."):
        resultado_mc = monte_carlo(comp, modelo_info, N=N_mc)
        resultado_fit = ajustar_componente(comp, modelo_info)

    st.success(f"Completado: {len(resultado_mc.samples)} ajustes exitosos de {N_mc}")

    # --- Grafico bandas de confianza ---
    st.subheader("Bandas de confianza (95%)")
    fig = go.Figure()

    # Banda 95%
    fig.add_trace(go.Scatter(
        x=np.concatenate([resultado_mc.V_modelo, resultado_mc.V_modelo[::-1]]),
        y=np.concatenate([resultado_mc.banda_superior * 1e3, resultado_mc.banda_inferior[::-1] * 1e3]),
        fill="toself",
        fillcolor=f"rgba({int(comp.color[1:3],16)},{int(comp.color[3:5],16)},{int(comp.color[5:7],16)},0.2)",
        line=dict(color="rgba(0,0,0,0)"),
        name="IC 95%",
    ))

    # Curva mejor ajuste
    fig.add_trace(go.Scatter(
        x=resultado_fit.V_modelo,
        y=resultado_fit.I_modelo * 1e3,
        mode="lines",
        name="Mejor ajuste",
        line=dict(color="black", width=2),
    ))

    # Datos
    fig.add_trace(go.Scatter(
        x=comp.V, y=comp.I * 1e3,
        mode="markers",
        name="Datos",
        marker=dict(color=comp.color, size=8),
        error_y=dict(type="data", array=comp.delta_I * 1e3, visible=True),
    ))

    fig.update_layout(
        xaxis_title="V [V]",
        yaxis_title="I [mA]",
        template="plotly_white",
        height=500,
    )
    st.plotly_chart(fig, use_container_width=True)

    # --- Histogramas de parametros ---
    st.subheader("Distribucion de parametros")
    nombres = modelo_info["nombres_params"]
    cols = st.columns(len(nombres))

    for i, nombre_p in enumerate(nombres):
        with cols[i]:
            muestra = resultado_mc.samples[:, i]
            fig_h = go.Figure()
            fig_h.add_trace(go.Histogram(
                x=muestra,
                nbinsx=50,
                marker_color=comp.color,
                opacity=0.7,
            ))
            fig_h.add_vline(x=resultado_mc.medias[i], line_dash="dash", line_color="red")
            fig_h.update_layout(
                title=f"{nombre_p}",
                xaxis_title=f"{nombre_p} [{modelo_info['unidades'][i]}]",
                yaxis_title="Frecuencia",
                template="plotly_white",
                height=350,
            )
            st.plotly_chart(fig_h, use_container_width=True)

    # --- Corner plot ---
    if len(nombres) >= 2:
        st.subheader("Corner plot")
        import matplotlib.pyplot as plt
        import corner
        fig_corner = corner.corner(
            resultado_mc.samples,
            labels=nombres,
            quantiles=[0.16, 0.5, 0.84],
            show_titles=True,
            title_kwargs={"fontsize": 12},
        )
        st.pyplot(fig_corner)

    # --- Tabla resumen ---
    st.subheader("Resumen estadistico")
    import pandas as pd
    resumen = []
    for i, nombre_p in enumerate(nombres):
        resumen.append({
            "Parametro": nombre_p,
            "Media MC": f"{resultado_mc.medias[i]:.4e}",
            "Std MC": f"{resultado_mc.stds[i]:.4e}",
            "Std curve_fit": f"{ajustar_componente(comp, modelo_info).incertidumbres[i]:.4e}",
        })
    st.dataframe(pd.DataFrame(resumen), use_container_width=True, hide_index=True)

else:
    st.info("Presiona el boton para ejecutar la simulacion Monte Carlo.")
