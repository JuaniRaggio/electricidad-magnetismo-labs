"""Ajuste por minimos cuadrados y simulacion Monte Carlo."""

from dataclasses import dataclass
import numpy as np
from scipy.optimize import curve_fit


@dataclass
class ResultadoAjuste:
    """Resultado de un ajuste por minimos cuadrados."""
    parametros: np.ndarray
    incertidumbres: np.ndarray
    chi2: float
    chi2_red: float
    residuos: np.ndarray
    V_modelo: np.ndarray
    I_modelo: np.ndarray


@dataclass
class ResultadoMonteCarlo:
    """Resultado de simulacion Monte Carlo."""
    samples: np.ndarray           # (N, n_params)
    medias: np.ndarray
    stds: np.ndarray
    banda_inferior: np.ndarray    # percentil 2.5
    banda_superior: np.ndarray    # percentil 97.5
    V_modelo: np.ndarray


def ajustar_componente(datos, modelo_info):
    """Ajusta modelo a datos experimentales usando curve_fit.

    Args:
        datos: ComponentData con V, I, delta_I
        modelo_info: dict con 'funcion', 'p0', 'bounds'

    Returns:
        ResultadoAjuste
    """
    funcion = modelo_info["funcion"]
    p0 = modelo_info["p0"]
    bounds = modelo_info["bounds"]

    sigma = datos.delta_I
    sigma = np.where(sigma > 0, sigma, 1e-6)

    popt, pcov = curve_fit(
        funcion, datos.V, datos.I,
        p0=p0, bounds=bounds,
        sigma=sigma, absolute_sigma=True,
        maxfev=50000,
    )

    perr = np.sqrt(np.diag(pcov))
    I_modelo_pts = funcion(datos.V, *popt)
    residuos = datos.I - I_modelo_pts

    chi2 = np.sum((residuos / sigma) ** 2)
    ndof = len(datos.V) - len(popt)
    chi2_red = chi2 / ndof if ndof > 0 else np.inf

    V_modelo = np.linspace(datos.V.min(), datos.V.max(), 500)
    I_modelo = funcion(V_modelo, *popt)

    return ResultadoAjuste(
        parametros=popt,
        incertidumbres=perr,
        chi2=chi2,
        chi2_red=chi2_red,
        residuos=residuos,
        V_modelo=V_modelo,
        I_modelo=I_modelo,
    )


def monte_carlo(datos, modelo_info, N=10000, seed=42):
    """Simulacion Monte Carlo: perturba datos N veces y reajusta.

    Args:
        datos: ComponentData
        modelo_info: dict con 'funcion', 'p0', 'bounds'
        N: numero de iteraciones
        seed: semilla para reproducibilidad

    Returns:
        ResultadoMonteCarlo
    """
    rng = np.random.default_rng(seed)
    funcion = modelo_info["funcion"]
    p0 = modelo_info["p0"]
    bounds = modelo_info["bounds"]

    sigma = datos.delta_I
    sigma = np.where(sigma > 0, sigma, 1e-6)

    V_modelo = np.linspace(datos.V.min(), datos.V.max(), 300)
    samples = []
    curvas = []

    for _ in range(N):
        I_pert = datos.I + rng.normal(0, sigma)
        try:
            popt, _ = curve_fit(
                funcion, datos.V, I_pert,
                p0=p0, bounds=bounds,
                sigma=sigma, absolute_sigma=True,
                maxfev=10000,
            )
            samples.append(popt)
            curvas.append(funcion(V_modelo, *popt))
        except RuntimeError:
            continue

    samples = np.array(samples)
    curvas = np.array(curvas)

    banda_inf = np.percentile(curvas, 2.5, axis=0)
    banda_sup = np.percentile(curvas, 97.5, axis=0)

    return ResultadoMonteCarlo(
        samples=samples,
        medias=np.mean(samples, axis=0),
        stds=np.std(samples, axis=0),
        banda_inferior=banda_inf,
        banda_superior=banda_sup,
        V_modelo=V_modelo,
    )
