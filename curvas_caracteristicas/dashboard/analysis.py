"""Analisis avanzado: resistencia dinamica, temperatura, factor de idealidad, gap."""

import numpy as np
from scipy.signal import savgol_filter
from scipy.stats import linregress
from data import k_B, q, V_T, h, c, T_amb, R0_LAMPARA, T_FUSION_W


def resistencia_dinamica(V, I, window=5, polyorder=2):
    """Calcula resistencia dinamica r(V) = dV/dI.

    Usa savgol_filter para suavizar la derivada numerica.
    """
    if window % 2 == 0:
        window += 1
    window = min(window, len(V) - 1)
    if window < polyorder + 1:
        window = polyorder + 2
        if window % 2 == 0:
            window += 1

    dI_dV = np.gradient(I, V)
    dI_dV_suave = savgol_filter(dI_dV, window, polyorder)

    r_din = np.where(np.abs(dI_dV_suave) > 1e-12, 1.0 / dI_dV_suave, np.inf)
    return np.abs(r_din)


def temperatura_filamento(V, I, R0=R0_LAMPARA, T0=T_amb, alpha_exp=1.2):
    """Calcula temperatura del filamento a partir de R(V).

    T = T0 * (R / R0)^(1 / alpha_exp)
    Para tungsteno, alpha_exp ~ 1.2
    """
    R = np.where(I > 1e-6, V / I, R0)
    T = T0 * np.power(R / R0, 1.0 / alpha_exp)
    return T, R


def verificacion_stefan_boltzmann(V, I, T):
    """Verifica ley de Stefan-Boltzmann: P ~ T^4.

    Ajusta log(P) vs log(T), pendiente esperada ~ 4.
    """
    P = V * I
    mask = (P > 1e-6) & (T > T_amb + 50)
    if np.sum(mask) < 3:
        return None, None, None

    log_P = np.log(P[mask])
    log_T = np.log(T[mask])

    resultado = linregress(log_T, log_P)
    return resultado.slope, resultado.intercept, resultado.rvalue**2


def factor_idealidad(V, I, V_min=None, V_max=None):
    """Extrae factor de idealidad n del grafico semilog ln(I) vs V.

    En la zona de conduccion: ln(I) = ln(I_s) + V / (n * V_T)
    Pendiente = 1 / (n * V_T) -> n = 1 / (pendiente * V_T)
    """
    mask = I > 1e-6
    if V_min is not None:
        mask &= V >= V_min
    if V_max is not None:
        mask &= V <= V_max

    if np.sum(mask) < 3:
        return None, None, None, None

    V_fit = V[mask]
    ln_I = np.log(I[mask])

    resultado = linregress(V_fit, ln_I)
    pendiente = resultado.slope
    n = 1.0 / (pendiente * V_T) if pendiente > 0 else np.inf
    I_s = np.exp(resultado.intercept)

    return n, I_s, resultado.rvalue**2, (V_fit, ln_I, resultado)


def energia_gap_led(V, I, metodo="tangente"):
    """Estima energia del gap del LED a partir de V_umbral.

    E_g = q * V_th
    lambda = h * c / E_g

    Metodos:
        'tangente': ajuste lineal en zona de alta corriente, interseccion con eje V
        'derivada': punto de maxima derivada dI/dV
    """
    if metodo == "tangente":
        # Usar los ultimos 30% de puntos (zona lineal alta corriente)
        n_pts = max(3, len(V) // 3)
        V_lin = V[-n_pts:]
        I_lin = I[-n_pts:]
        resultado = linregress(V_lin, I_lin)
        V_th = -resultado.intercept / resultado.slope if resultado.slope > 0 else 0
        info = {"pendiente": resultado.slope, "intercepto": resultado.intercept,
                "V_lin": V_lin, "I_lin": I_lin}
    elif metodo == "derivada":
        dI_dV = np.gradient(I, V)
        idx_max = np.argmax(dI_dV)
        V_th = V[idx_max]
        info = {"dI_dV": dI_dV, "idx_max": idx_max}
    else:
        raise ValueError(f"Metodo no reconocido: {metodo}")

    E_g = q * V_th                    # [J]
    E_g_eV = V_th                     # [eV] (numericamente igual a V_th)
    lam = h * c / E_g if E_g > 0 else np.inf  # [m]
    lam_nm = lam * 1e9                # [nm]

    return {
        "V_th": V_th,
        "E_g_J": E_g,
        "E_g_eV": E_g_eV,
        "lambda_m": lam,
        "lambda_nm": lam_nm,
        "metodo": metodo,
        "info": info,
    }
