def ohm_law(V, I_mA):
    return V / (I_mA / 1000)


r1 = {
    "I_mA": 6.1, "V": 1.49,
    "codigo": "Rojo-Rojo-Marron-Dorado",
    "teorico": 220, "multimetro": 218, "tolerancia": 5,
}

r2 = {
    "I_mA": 2.1, "V": 1.48,
    "codigo": "Naranja-Naranja-Marron-Dorado",
    "teorico": 330, "multimetro": 325, "tolerancia": 5,
}

r3 = {
    "I_mA": 9.1, "V": 1.49,
    "codigo": "Marron-Verde-Marron-Dorado",
    "teorico": 150, "multimetro": 148, "tolerancia": 5,
}

r_10M = {"teorico": 10e6, "multimetro": 9.72e6}

r1_r2_r3_paralelo = {"I_mA": 21.3, "V": 1.46}
r1_r2_r3_serie    = {"I_mA": 2.1,  "V": 1.49}

# 9 ohms

# No sirve para la corriente, medimos el doble porque
# justamente tenes dos resistencias iguales, entonces
cc_10Megohms = {
        "I_muA": 1.8, "V": 9.17
}

# Este sirve para la corriente, no para el Voltaje
cl_10Megohms = {
        "I_muA": 0.94, "V": 9.25
}

print(f"R1 (220 nominal, 218 medido): {ohm_law(r1["V"], r1["I_mA"]):.1f} ohm")
print(f"R2 (330 nominal, 325 medido): {ohm_law(r2["V"], r2["I_mA"]):.1f} ohm")
print(f"R3 (150 nominal, 148 medido): {ohm_law(r3["V"], r3["I_mA"]):.1f} ohm")
print(f"Paralelo (teorico ~70):       {ohm_law(r1_r2_r3_paralelo["V"], r1_r2_r3_paralelo["I_mA"]):.1f} ohm")
print(f"Serie (teorico 700):          {ohm_law(r1_r2_r3_serie["V"], r1_r2_r3_serie["I_mA"]):.1f} ohm")

# === Segunda Parte ===

# 6.8 mA
# 19.8 mA
# 4.1 mA

# caida de tension de la fuente, nominal: 9, medido: 9.22 V
# caida de tension de la fuente, nominal: 1.5, medido: 2.66

circuito_1 = {
        "r1" : {
            "I_mA" : 23.3, "V": 5.7
            },
        "r2" : {
            "I_mA" : 13.0, "V" : 4.17
            },
        "r3" : {
            "I_mA" : 10.3, "V" : 1.51
            },
        }

circuito_fuente_invertida = {
        "r1" : {
            "I_mA" : 32.2 , "V": 6.92
            },
        "r2" : {
            "I_mA" : 6.8, "V" : 2.21
            },
        "r3" : {
            "I_mA" : 3.1, # 25.4
            "V" : 0.46 # 3.71
            }
        }

print(f"Segunda parte, r1:", ohm_law(circuito_1["r1"]["I_mA"], circuito_1["r1"]["I_mA"]))


# Por que hay que invertir la fuente?
# Hay valor de resis a partir del cual es mejor el largo o el corto?
# Por que esta esta diferencia entre "corto" y "largo"? Cuales son los valores limites
