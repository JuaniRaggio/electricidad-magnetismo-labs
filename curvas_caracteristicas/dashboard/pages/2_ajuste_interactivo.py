"""Pagina 2: Ajuste interactivo con sliders y auto-fit."""

import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

import streamlit as st
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import numpy as np

from data import obtener_todos
from models import MODELOS, SLIDER_CONFIG
from fitting import ajustar_componente

st.title("Ajuste Interactivo de Modelos")

datos = obtener_todos()

# --- Seleccion de componente ---
componente = st.selectbox(
    "Componente",
    options=list(datos.keys()),
    format_func=lambda x: datos[x].nombre,
)

comp = datos[componente]
modelo_info = MODELOS[componente]
slider_cfg = SLIDER_CONFIG[componente]

# --- Auto-fit ---
auto_fit = st.checkbox("Auto-fit (minimos cuadrados)", value=True)

resultado_auto = None
if auto_fit:
    try:
        resultado_auto = ajustar_componente(comp, modelo_info)
    except Exception as e:
        st.error(f"Error en ajuste: {e}")

# --- Sliders ---
st.sidebar.header("Parametros del modelo")
params_manual = {}

for nombre_param, cfg in slider_cfg.items():
    if auto_fit and resultado_auto is not None:
        idx = modelo_info["nombres_params"].index(nombre_param)
        valor_auto = resultado_auto.parametros[idx]
        if cfg.get("es_log", False):
            valor_default = float(np.log10(max(valor_auto, 1e-40)))
        else:
            valor_default = float(valor_auto)
    else:
        valor_default = cfg["default"]

    valor_default = max(cfg["min"], min(cfg["max"], valor_default))
    label = cfg.get("label", nombre_param)

    valor = st.sidebar.slider(
        label,
        min_value=cfg["min"],
        max_value=cfg["max"],
        value=valor_default,
        step=cfg["step"],
        format=cfg["formato"],
        disabled=auto_fit,
    )

    if cfg.get("es_log", False):
        params_manual[nombre_param] = 10**valor
    else:
        params_manual[nombre_param] = valor

# Usar parametros del auto-fit o del slider
if auto_fit and resultado_auto is not None:
    params_activos = resultado_auto.parametros
else:
    params_activos = np.array([params_manual[n] for n in modelo_info["nombres_params"]])

# --- Generar curva modelo ---
V_modelo = np.linspace(comp.V.min(), comp.V.max(), 500)
I_modelo = modelo_info["funcion"](V_modelo, *params_activos)
I_modelo_pts = modelo_info["funcion"](comp.V, *params_activos)
residuos = comp.I - I_modelo_pts

# --- Grafico con subplots ---
fig = make_subplots(
    rows=2, cols=1,
    row_heights=[0.7, 0.3],
    shared_xaxes=True,
    vertical_spacing=0.08,
    subplot_titles=["Datos vs Modelo", "Residuos"],
)

# Datos
fig.add_trace(go.Scatter(
    x=comp.V, y=comp.I * 1e3,
    mode="markers",
    name="Datos",
    marker=dict(color=comp.color, size=8),
    error_y=dict(type="data", array=comp.delta_I * 1e3, visible=True),
), row=1, col=1)

# Modelo
fig.add_trace(go.Scatter(
    x=V_modelo, y=I_modelo * 1e3,
    mode="lines",
    name="Modelo",
    line=dict(color="black", width=2),
), row=1, col=1)

# Residuos
fig.add_trace(go.Scatter(
    x=comp.V, y=residuos * 1e3,
    mode="markers",
    name="Residuos",
    marker=dict(color=comp.color, size=6),
), row=2, col=1)

fig.add_hline(y=0, line_dash="dash", line_color="gray", row=2, col=1)

fig.update_layout(
    height=700,
    template="plotly_white",
    showlegend=True,
)
fig.update_yaxes(title_text="I [mA]", row=1, col=1)
fig.update_yaxes(title_text="Residuo [mA]", row=2, col=1)
fig.update_xaxes(title_text="V [V]", row=2, col=1)

st.plotly_chart(fig, use_container_width=True)

# --- Metricas del ajuste ---
st.subheader("Parametros del ajuste")
col1, col2, col3 = st.columns(3)

for i, nombre_param in enumerate(modelo_info["nombres_params"]):
    unidad = modelo_info["unidades"][i]
    valor = params_activos[i]
    if auto_fit and resultado_auto is not None:
        incert = resultado_auto.incertidumbres[i]
        col1.metric(f"{nombre_param}", f"{valor:.4e} {unidad}", delta=f"+/- {incert:.2e}")
    else:
        col1.metric(f"{nombre_param}", f"{valor:.4e} {unidad}")

if auto_fit and resultado_auto is not None:
    sigma = np.where(comp.delta_I > 0, comp.delta_I, 1e-6)
    chi2 = np.sum((residuos / sigma) ** 2)
    ndof = len(comp.V) - len(params_activos)
    chi2_red = chi2 / ndof if ndof > 0 else float("inf")
    col2.metric("Chi2 reducido", f"{chi2_red:.3f}")
    col3.metric("Grados de libertad", f"{ndof}")
