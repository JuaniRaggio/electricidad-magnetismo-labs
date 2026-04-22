"""
Analisis complementario: Resolucion matricial de Kirchhoff y sensibilidad.

No incluido en el informe. Se deja como referencia en el repositorio.

1. Resolucion matricial de los circuitos (nodos + mallas)
2. Analisis de sensibilidad: como cambian las corrientes al variar cada resistencia
"""

import numpy as np


def resolver_circuito(R1, R2, R3, V1, V2):
    """
    Resuelve el circuito de dos mallas con tres ramas.

    Sistema de ecuaciones:
        Nodo:    I1 - I2 - I3 = 0
        Malla 1: R1*I1 + R2*I2 = V1
        Malla 2: -R2*I2 + R3*I3 = V2

    Retorna I1, I2, I3 en Ampere.
    """
    A = np.array([
        [1,    -1,   -1 ],
        [R1,    R2,   0  ],
        [0,    -R2,   R3 ],
    ])
    b = np.array([0, V1, V2])
    return np.linalg.solve(A, b)


def sensibilidad(R1_base, R2_base, R3_base, V1, V2, delta_pct=5):
    """
    Varia cada resistencia +-delta_pct% y calcula el cambio en cada corriente.
    Retorna matriz de sensibilidad (3x3): fila = resistencia variada, col = corriente afectada.
    Sensibilidad relativa: (dI/I) / (dR/R)
    """
    I_base = resolver_circuito(R1_base, R2_base, R3_base, V1, V2)
    resistencias = [R1_base, R2_base, R3_base]
    sens = np.zeros((3, 3))

    for i in range(3):
        dR = resistencias[i] * delta_pct / 100

        R_plus = resistencias.copy()
        R_plus[i] += dR
        I_plus = resolver_circuito(*R_plus, V1, V2)

        R_minus = resistencias.copy()
        R_minus[i] -= dR
        I_minus = resolver_circuito(*R_minus, V1, V2)

        for j in range(3):
            if abs(I_base[j]) > 1e-12:
                sens[i, j] = ((I_plus[j] - I_minus[j]) / (2 * dR)) * (resistencias[i] / I_base[j])

    return sens, I_base


if __name__ == "__main__":
    # Valores medidos con ohmetro
    R1, R2, R3 = 218, 325, 148

    # Circuito 1: fuente normal (tensiones medidas, signo por convencion de malla)
    V1_c1, V2_c1 = 9.22, -2.66
    I_c1 = resolver_circuito(R1, R2, R3, V1_c1, V2_c1)

    # Circuito 2: fuente invertida (V2=1.5 nominal, confirmado por KVL con datos medidos)
    V1_c2, V2_c2 = 9.22, -1.5
    I_c2 = resolver_circuito(R1, R2, R3, V1_c2, V2_c2)

    # Valores medidos en laboratorio
    I_med_c1 = np.array([23.3, 13.0, 10.03]) * 1e-3
    I_med_c2 = np.array([32.2, 6.8, 25.4]) * 1e-3

    print("=" * 60)
    print("RESOLUCION MATRICIAL DE KIRCHHOFF")
    print("=" * 60)
    print(f"Resistencias usadas (ohmetro): R1={R1}, R2={R2}, R3={R3}")

    for nombre, I_calc, I_med in [
        ("Circuito 1 (normal)", I_c1, I_med_c1),
        ("Circuito 2 (invertida)", I_c2, I_med_c2),
    ]:
        print(f"\n{nombre}:")
        print(f"  {'Corriente':>10} {'Calculada':>12} {'Medida':>12} {'Error %':>10}")
        for i in range(3):
            err = abs(I_calc[i] - I_med[i]) / abs(I_med[i]) * 100
            print(f"  {'I' + str(i+1):>10} {I_calc[i]*1e3:>10.2f} mA {I_med[i]*1e3:>10.2f} mA {err:>8.1f} %")

        residuo = I_calc[0] - I_calc[1] - I_calc[2]
        print(f"  Verificacion nodos (I1 - I2 - I3): {residuo:.2e} A")

        residuo_med = I_med[0] - I_med[1] - I_med[2]
        print(f"  Verificacion nodos medidos: {residuo_med*1e3:.2f} mA")

    # Sensibilidad
    print("\n" + "=" * 60)
    print("ANALISIS DE SENSIBILIDAD")
    print("=" * 60)

    for titulo, V1, V2 in [
        ("Circuito 1 (V1=9, V2=1.5)", V1_c1, V2_c1),
        ("Circuito 2 (V1=9.22, V2=-2.66)", V1_c2, V2_c2),
    ]:
        sens, I_base = sensibilidad(R1, R2, R3, V1, V2)
        print(f"\n{titulo} - Sensibilidad relativa (dI/I)/(dR/R):")
        print(f"  {'':>15} {'I1':>8} {'I2':>8} {'I3':>8}")
        for i, nombre in enumerate([f"R1 ({R1})", f"R2 ({R2})", f"R3 ({R3})"]):
            print(f"  {nombre:>15} {sens[i,0]:>8.3f} {sens[i,1]:>8.3f} {sens[i,2]:>8.3f}")
