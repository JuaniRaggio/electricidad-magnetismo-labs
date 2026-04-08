import matplotlib.pyplot as plt
import numpy as np


def graficar_resistencia(tension_V, corriente_mA, guardar='./grafico.png'):
    tension = np.array(tension_V)
    corriente = np.array(corriente_mA)

    coef = np.polyfit(corriente, tension, 1)
    ajuste = np.poly1d(coef)

    plt.figure(figsize=(8, 5))
    plt.plot(corriente, tension, 'o', label='Datos medidos')
    plt.plot(corriente, ajuste(corriente), '-', label=f'Ajuste lineal (R = {coef[0]:.1f} ohm)')
    plt.xlabel('Corriente (mA)')
    plt.ylabel('Tension (V)')
    plt.title('Tension vs Corriente - Resistencia')
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    plt.savefig(guardar, dpi=150)


def graficar_lampara(tension_V, corriente_mA, guardar='./grafico_lampara.png'):
    plt.figure(figsize=(8, 5))
    plt.plot(tension_V, corriente_mA, 'o-', label='Datos medidos')
    plt.xlabel('Tension (V)')
    plt.ylabel('Corriente (mA)')
    plt.title('Curva I-V de la Lampara')
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    plt.savefig(guardar, dpi=150)


def graficar_led(tension_V, corriente_mA, guardar='./grafico_led.png'):
    plt.figure(figsize=(8, 5))
    plt.plot(tension_V, corriente_mA, 'o-', label='Datos medidos')
    plt.xlabel('Tension (V)')
    plt.ylabel('Corriente (mA)')
    plt.title('Curva I-V del LED')
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    plt.savefig(guardar, dpi=150)


def graficar_diodo(tension_V, corriente_mA, guardar='./grafico_diodo.png'):
    plt.figure(figsize=(8, 5))
    plt.plot(tension_V, corriente_mA, 'o-', label='Datos medidos')
    plt.xlabel('Tension (V)')
    plt.ylabel('Corriente (mA)')
    plt.title('Curva I-V del Diodo')
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    plt.savefig(guardar, dpi=150)


if __name__ == '__main__':
    graficar_resistencia(
        tension_V=[0.5, 1.1, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5,
                   6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0],
        corriente_mA=[1.5, 3.0, 6.0, 7.5, 9.0, 10.6, 12.1, 13.7, 15.2, 16.7,
                      18.3, 19.8, 21.4, 22.9, 24.4, 26.0, 27.5, 29.0, 30.6],
    )

    graficar_diodo(
        tension_V=[0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85,
                   0.9, 0.95, 1.0, 1.05, 1.1, 1.15, 1.2, 1.5, 2.0],
        corriente_mA=[0, 0, 0.3, 1, 2, 4.1, 6.3, 8.5, 12.4, 15.5,
                      19.1, 23.3, 27.8, 29.4, 33.5, 38, 42.9, 74.5, 125],
    )

    graficar_lampara(
        tension_V=[0.5, 1, 1.5, 2, 2.5, 3.01, 3.5, 4, 4.5, 5, 5.5, 6,
                   6.65, 7, 7.5, 8, 8.5, 9, 9.4, 10.02, 10.46, 11, 11.6, 12],
        corriente_mA=[34, 41.3, 47.1, 53.2, 59, 64.9, 70.7, 75.2, 81, 85, 90.4, 94,
                      100, 102.5, 107.0, 110.9, 115, 118.6, 121.9, 126.233, 129.5, 133.9, 137.4, 140.9],
    )

    graficar_led(
        tension_V=[0.69, 1.21, 1.55, 1.71, 1.78, 1.81, 1.84, 1.87, 1.89, 1.92,
                   1.93, 1.96, 1.98, 2.0, 2.01, 2.03, 2.05, 2.06, 2.08, 2.1,
                   2.11, 2.13, 2.15, 2.16, 2.18, 2.2, 2.21, 2.23, 2.23, 2.26],
        corriente_mA=[0.5, 1.5, 2.5, 3.4, 4.5, 5.4, 6.5, 7.4, 8.4, 9.5,
                      10.3, 11.4, 12.4, 13.5, 14.5, 15.5, 16.4, 17.5, 18.5, 19.4,
                      20.5, 21.5, 22.5, 23.5, 24.5, 25.5, 26.5, 27.6, 28.5, 29.5],
    )

    plt.show()
