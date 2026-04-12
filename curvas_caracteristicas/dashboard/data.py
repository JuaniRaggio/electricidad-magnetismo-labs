"""Datos experimentales de curvas I-V para TP1 Fisica III."""

from dataclasses import dataclass
import numpy as np


# --- Constantes fisicas ---
k_B = 1.380649e-23      # Boltzmann [J/K]
q = 1.602176634e-19      # Carga elemental [C]
T_amb = 295.0             # Temperatura ambiente [K]
V_T = k_B * T_amb / q    # Tension termica [V]
h = 6.62607015e-34       # Planck [J*s]
c = 2.99792458e8         # Velocidad de la luz [m/s]
T_FUSION_W = 3695.0      # Temperatura de fusion del tungsteno [K]
R0_LAMPARA = 14.7        # Resistencia en frio de la lampara [Ohm] (V=0.5V / I=34mA)


@dataclass
class ComponentData:
    """Datos experimentales de un componente."""
    nombre: str
    V: np.ndarray          # Tension [V]
    I: np.ndarray          # Corriente [A]
    delta_V: np.ndarray    # Incertidumbre en V
    delta_I: np.ndarray    # Incertidumbre en I
    color: str

    @property
    def n_puntos(self):
        return len(self.V)


def _incertidumbre_multimetro(valores, porcentaje=0.01, digitos=2, resolucion=0.01):
    """Incertidumbre de multimetro digital: +/- (porcentaje * lectura + digitos * resolucion)."""
    return porcentaje * np.abs(valores) + digitos * resolucion


def obtener_todos() -> dict[str, ComponentData]:
    """Retorna diccionario con datos de los 4 componentes."""

    # --- Resistencia ---
    V_res = np.array([0.5, 1.1, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5,
                      6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0])
    I_res = np.array([1.5, 3.0, 6.0, 7.5, 9.0, 10.6, 12.1, 13.7, 15.2, 16.7,
                      18.3, 19.8, 21.4, 22.9, 24.4, 26.0, 27.5, 29.0, 30.6]) * 1e-3  # mA -> A

    # --- Diodo ---
    V_dio = np.array([0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85,
                      0.9, 0.95, 1.0, 1.05, 1.1, 1.15, 1.2, 1.5, 2.0])
    I_dio = np.array([0, 0, 0.3, 1, 2, 4.1, 6.3, 8.5, 12.4, 15.5,
                      19.1, 23.3, 27.8, 29.4, 33.5, 38, 42.9, 74.5, 125]) * 1e-3

    # --- Lampara ---
    V_lam = np.array([0.5, 1, 1.5, 2, 2.5, 3.01, 3.5, 4, 4.5, 5, 5.5, 6,
                      6.65, 7, 7.5, 8, 8.5, 9, 9.4, 10.02, 10.46, 11, 11.6, 12])
    I_lam = np.array([34, 41.3, 47.1, 53.2, 59, 64.9, 70.7, 75.2, 81, 85, 90.4, 94,
                      100, 102.5, 107.0, 110.9, 115, 118.6, 121.9, 126.233, 129.5, 133.9,
                      137.4, 140.9]) * 1e-3

    # --- LED ---
    V_led = np.array([0.69, 1.21, 1.55, 1.71, 1.78, 1.81, 1.84, 1.87, 1.89, 1.92,
                      1.93, 1.96, 1.98, 2.0, 2.01, 2.03, 2.05, 2.06, 2.08, 2.1,
                      2.11, 2.13, 2.15, 2.16, 2.18, 2.2, 2.21, 2.23, 2.23, 2.26])
    I_led = np.array([0.5, 1.5, 2.5, 3.4, 4.5, 5.4, 6.5, 7.4, 8.4, 9.5,
                      10.3, 11.4, 12.4, 13.5, 14.5, 15.5, 16.4, 17.5, 18.5, 19.4,
                      20.5, 21.5, 22.5, 23.5, 24.5, 25.5, 26.5, 27.6, 28.5, 29.5]) * 1e-3

    # Incertidumbres
    # Tension: +/- (1% lectura + 2 digitos * 0.01V)
    # Corriente: +/- (1% lectura + 2 digitos * 0.01mA) -> convertido a A
    datos = {
        "resistencia": ComponentData(
            nombre="Resistencia",
            V=V_res,
            I=I_res,
            delta_V=_incertidumbre_multimetro(V_res, resolucion=0.01),
            delta_I=_incertidumbre_multimetro(I_res, resolucion=0.01e-3),
            color="#636EFA",
        ),
        "diodo": ComponentData(
            nombre="Diodo",
            V=V_dio,
            I=I_dio,
            delta_V=_incertidumbre_multimetro(V_dio, resolucion=0.01),
            delta_I=_incertidumbre_multimetro(I_dio, resolucion=0.01e-3),
            color="#EF553B",
        ),
        "lampara": ComponentData(
            nombre="Lampara",
            V=V_lam,
            I=I_lam,
            delta_V=_incertidumbre_multimetro(V_lam, resolucion=0.01),
            delta_I=_incertidumbre_multimetro(I_lam, resolucion=0.01e-3),
            color="#00CC96",
        ),
        "led": ComponentData(
            nombre="LED",
            V=V_led,
            I=I_led,
            delta_V=_incertidumbre_multimetro(V_led, resolucion=0.01),
            delta_I=_incertidumbre_multimetro(I_led, resolucion=0.01e-3),
            color="#AB63FA",
        ),
    }
    return datos
