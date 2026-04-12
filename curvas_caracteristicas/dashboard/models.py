"""Modelos fisicos para ajuste de curvas I-V."""

import numpy as np
from data import V_T


def modelo_resistencia(V, R):
    """Ley de Ohm: I = V / R."""
    return V / R


def modelo_diodo(V, I_s, n):
    """Ecuacion de Shockley: I = I_s * (exp(V / (n * V_T)) - 1)."""
    exponente = np.clip(V / (n * V_T), -500, 500)
    return I_s * (np.exp(exponente) - 1)


def modelo_lampara_potencial(V, a, b):
    """Modelo potencial: I = a * V^b (para V > 0)."""
    return a * np.power(np.abs(V), b)


def modelo_led(V, I_s, n):
    """Shockley para LED (misma ecuacion, distintos parametros iniciales)."""
    exponente = np.clip(V / (n * V_T), -500, 500)
    return I_s * (np.exp(exponente) - 1)


# Configuracion de modelos por componente
MODELOS = {
    "resistencia": {
        "funcion": modelo_resistencia,
        "nombres_params": ["R"],
        "unidades": ["Ohm"],
        "p0": [330.0],
        "bounds": ([1.0], [10000.0]),
    },
    "diodo": {
        "funcion": modelo_diodo,
        "nombres_params": ["I_s", "n"],
        "unidades": ["A", ""],
        "p0": [1e-12, 1.5],
        "bounds": ([1e-30, 0.5], [1e-3, 5.0]),
    },
    "lampara": {
        "funcion": modelo_lampara_potencial,
        "nombres_params": ["a", "b"],
        "unidades": ["A/V^b", ""],
        "p0": [0.035, 0.5],
        "bounds": ([1e-6, 0.1], [1.0, 2.0]),
    },
    "led": {
        "funcion": modelo_led,
        "nombres_params": ["I_s", "n"],
        "unidades": ["A", ""],
        "p0": [1e-20, 3.0],
        "bounds": ([1e-40, 1.0], [1e-3, 20.0]),
    },
}

# Configuracion de sliders para ajuste interactivo
SLIDER_CONFIG = {
    "resistencia": {
        "R": {"min": 100.0, "max": 600.0, "step": 1.0, "default": 330.0, "formato": "%.1f"},
    },
    "diodo": {
        "I_s": {"min": -30.0, "max": -3.0, "step": 0.1, "default": -12.0, "formato": "%.1f",
                "es_log": True, "label": "log10(I_s)"},
        "n": {"min": 0.5, "max": 5.0, "step": 0.01, "default": 1.5, "formato": "%.2f"},
    },
    "lampara": {
        "a": {"min": 0.001, "max": 0.2, "step": 0.001, "default": 0.035, "formato": "%.4f"},
        "b": {"min": 0.1, "max": 2.0, "step": 0.01, "default": 0.5, "formato": "%.2f"},
    },
    "led": {
        "I_s": {"min": -40.0, "max": -3.0, "step": 0.1, "default": -20.0, "formato": "%.1f",
                "es_log": True, "label": "log10(I_s)"},
        "n": {"min": 1.0, "max": 20.0, "step": 0.1, "default": 3.0, "formato": "%.1f"},
    },
}
