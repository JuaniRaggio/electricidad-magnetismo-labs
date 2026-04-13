"""Pagina 5: Temperatura del filamento de la lampara."""

import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

import streamlit as st
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import numpy as np

from data import obtener_todos, T_amb, R0_LAMPARA, T_FUSION_W
from analysis import temperatura_filamento, verificacion_stefan_boltzmann

st.title("Temperatura del Filamento")
st.markdown("Estimacion de T(V) y T(P) a partir de la variacion de resistencia con temperatura.")

datos = obtener_todos()
comp = datos["lampara"]

# --- Controles ---
col1, col2 = st.columns(2)
with col1:
    R0 = st.number_input("R0 (resistencia en frio) [Ohm]", value=R0_LAMPARA, step=0.1, format="%.1f")
with col2:
    alpha_exp = st.slider("Exponente alpha (tungsteno ~ 1.2)", 0.5, 2.0, 1.2, step=0.05)

# --- Calculo ---
T, R = temperatura_filamento(comp.V, comp.I, R0=R0, T0=T_amb, alpha_exp=alpha_exp)
P = comp.V * comp.I

# --- Graficos ---
fig = make_subplots(
    rows=1, cols=2,
    subplot_titles=["T vs V", "T vs P"],
)

# T vs V
fig.add_trace(go.Scatter(
    x=comp.V, y=T,
    mode="markers+lines",
    name="T(V)",
    marker=dict(color="#00CC96", size=8),
    line=dict(color="#00CC96"),
), row=1, col=1)

fig.add_hline(y=T_FUSION_W, line_dash="dash", line_color="red",
              annotation_text=f"Fusion W ({T_FUSION_W} K)", row=1, col=1)

# T vs P
fig.add_trace(go.Scatter(
    x=P * 1e3, y=T,
    mode="markers+lines",
    name="T(P)",
    marker=dict(color="#FFA15A", size=8),
    line=dict(color="#FFA15A"),
), row=1, col=2)

fig.add_hline(y=T_FUSION_W, line_dash="dash", line_color="red", row=1, col=2)

fig.update_xaxes(title_text="V [V]", row=1, col=1)
fig.update_xaxes(title_text="P [mW]", row=1, col=2)
fig.update_yaxes(title_text="T [K]", row=1, col=1)
fig.update_yaxes(title_text="T [K]", row=1, col=2)
fig.update_layout(height=500, template="plotly_white", showlegend=False)

st.plotly_chart(fig, use_container_width=True)

# --- Metricas ---
col_m1, col_m2, col_m3 = st.columns(3)
col_m1.metric("T maxima", f"{np.max(T):.0f} K")
col_m2.metric("R maxima", f"{np.max(R):.1f} Ohm")
col_m3.metric("P maxima", f"{np.max(P)*1e3:.1f} mW")

# --- Verificacion Stefan-Boltzmann ---
st.subheader("Verificacion de Stefan-Boltzmann")
st.markdown("$P \\propto T^n$ con $n \\approx 4$ (Stefan-Boltzmann)")

pendiente, intercepto, r2 = verificacion_stefan_boltzmann(comp.V, comp.I, T)

if pendiente is not None:
    col_sb1, col_sb2 = st.columns(2)
    col_sb1.metric("Exponente n (esperado ~4)", f"{pendiente:.2f}")
    col_sb2.metric("R^2", f"{r2:.4f}")

    # Grafico log-log
    mask = (P > 1e-6) & (T > T_amb + 50)
    fig_sb = go.Figure()
    fig_sb.add_trace(go.Scatter(
        x=np.log(T[mask]),
        y=np.log(P[mask]),
        mode="markers",
        name="Datos",
        marker=dict(color="#00CC96", size=8),
    ))

    x_fit = np.linspace(np.log(T[mask]).min(), np.log(T[mask]).max(), 100)
    fig_sb.add_trace(go.Scatter(
        x=x_fit,
        y=pendiente * x_fit + intercepto,
        mode="lines",
        name=f"Ajuste: n={pendiente:.2f}",
        line=dict(color="black", width=2),
    ))

    fig_sb.update_layout(
        xaxis_title="ln(T) [K]",
        yaxis_title="ln(P) [W]",
        template="plotly_white",
        height=400,
    )
    st.plotly_chart(fig_sb, use_container_width=True)
else:
    st.warning("No hay suficientes datos para verificar Stefan-Boltzmann.")

# --- Tabla R(V) ---
st.subheader("Datos: R(V) y T(V)")
import pandas as pd
df = pd.DataFrame({
    "V [V]": comp.V,
    "I [mA]": comp.I * 1e3,
    "R [Ohm]": R,
    "T [K]": T,
    "P [mW]": P * 1e3,
})
st.dataframe(df, use_container_width=True, hide_index=True)
