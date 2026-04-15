def ohm_law(comp):
    """R = V / I, con I en mA -> convertir a A dividiendo por 1000."""
    return comp["V"] / (comp["I_mA"] / 1000)


# Rojo-Rojo-Marron-Dorado | teorico = 220 ohm, multimetro = 218 ohm, tol = 5%
r1 = {"I_mA": 6.1, "V": 1.49}

# Naranja-Naranja-Marron-Dorado | teorico = 330 ohm, multimetro = 325 ohm, tol = 5%
r2 = {"I_mA": 2.1, "V": 1.48}

# Marron-Verde-Marron-Dorado | teorico = 150 ohm, multimetro = 148 ohm, tol = 5%
r3 = {"I_mA": 9.1, "V": 1.49}

r_10M = {"teorico": 10e6, "multimetro": 9.72e6}

r1_r2_r3_paralelo = {"I_mA": 21.3, "V": 1.46}
r1_r2_r3_serie    = {"I_mA": 2.1,  "V": 1.49}


print(f"R1 (220 nominal, 218 medido): {ohm_law(r1):.1f} ohm")
print(f"R2 (330 nominal, 325 medido): {ohm_law(r2):.1f} ohm")
print(f"R3 (150 nominal, 148 medido): {ohm_law(r3):.1f} ohm")
print(f"Paralelo (teorico ~70):       {ohm_law(r1_r2_r3_paralelo):.1f} ohm")
print(f"Serie (teorico 700):          {ohm_law(r1_r2_r3_serie):.1f} ohm")

# Por que hay que invertir la fuente?
# Hay valor de resis a partir del cual es mejor el largo o el corto?
# Por que esta esta diferencia entre "corto" y "largo"? Cuales son los valores limites
