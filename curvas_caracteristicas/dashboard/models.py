"""Modelos fisicos para ajuste de curvas I-V."""

import numpy as np
from data import V_T


def modelo_resistencia(V, R):
    """Ley de Ohm: I = V / R."""
    return V / R


def modelo_diodo(V, I_s, n, R_s):
    """Shockley con resistencia serie (resuelto iterativamente).

    V_j = V - I * R_s
    I = I_s * (exp(V_j / (n * V_T)) - 1)
    """
    I = np.zeros_like(V, dtype=float)
    for _ in range(100):
        V_j = V - I * R_s
        exponente = np.clip(V_j / (n * V_T), -500, 500)
        I_new = I_s * (np.exp(exponente) - 1)
        I = 0.7 * I + 0.3 * np.clip(I_new, 0, 10)
    return I


def modelo_lampara_potencial(V, a, b):
    """Modelo potencial: I = a * V^b (para V > 0)."""
    return a * np.power(np.abs(V), b)


def modelo_led(V, I_s, n, R_s):
    """Shockley con resistencia serie para LED."""
    I = np.zeros_like(V, dtype=float)
    for _ in range(100):
        V_j = V - I * R_s
        exponente = np.clip(V_j / (n * V_T), -500, 500)
        I_new = I_s * (np.exp(exponente) - 1)
        I = 0.7 * I + 0.3 * np.clip(I_new, 0, 10)
    return I


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
        "nombres_params": ["I_s", "n", "R_s"],
        "unidades": ["A", "", "Ohm"],
        "p0": [1e-10, 1.8, 5.0],
        "bounds": ([1e-30, 1.0, 0.1], [1e-3, 3.0, 50.0]),
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
        "nombres_params": ["I_s", "n", "R_s"],
        "unidades": ["A", "", "Ohm"],
        "p0": [1e-15, 2.0, 10.0],
        "bounds": ([1e-40, 1.0, 0.1], [1e-3, 10.0, 200.0]),
    },
}

# Configuracion de sliders para ajuste interactivo
SLIDER_CONFIG = {
    "resistencia": {
        "R": {"min": 100.0, "max": 600.0, "step": 1.0, "default": 330.0, "formato": "%.1f"},
    },
    "diodo": {
        "I_s": {"min": -30.0, "max": -3.0, "step": 0.1, "default": -10.0, "formato": "%.1f",
                "es_log": True, "label": "log10(I_s)"},
        "n": {"min": 1.0, "max": 3.0, "step": 0.01, "default": 1.8, "formato": "%.2f"},
        "R_s": {"min": 0.1, "max": 50.0, "step": 0.1, "default": 5.0, "formato": "%.1f"},
    },
    "lampara": {
        "a": {"min": 0.001, "max": 0.2, "step": 0.001, "default": 0.035, "formato": "%.4f"},
        "b": {"min": 0.1, "max": 2.0, "step": 0.01, "default": 0.5, "formato": "%.2f"},
    },
    "led": {
        "I_s": {"min": -40.0, "max": -3.0, "step": 0.1, "default": -15.0, "formato": "%.1f",
                "es_log": True, "label": "log10(I_s)"},
        "n": {"min": 1.0, "max": 10.0, "step": 0.1, "default": 2.0, "formato": "%.1f"},
        "R_s": {"min": 0.1, "max": 200.0, "step": 0.5, "default": 10.0, "formato": "%.1f"},
    },
}
