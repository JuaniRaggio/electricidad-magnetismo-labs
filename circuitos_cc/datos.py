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

print("=" * 60)
print("PRIMERA PARTE: Resistencias individuales (Ley de Ohm)")
print("=" * 60)

R1_ohm = ohm_law(r1["V"], r1["I_mA"])
R2_ohm = ohm_law(r2["V"], r2["I_mA"])
R3_ohm = ohm_law(r3["V"], r3["I_mA"])

print(f"R1 (220 nominal, 218 medido): {R1_ohm:.1f} ohm")
print(f"R2 (330 nominal, 325 medido): {R2_ohm:.1f} ohm")
print(f"R3 (150 nominal, 148 medido): {R3_ohm:.1f} ohm")

print()
print("Errores porcentuales R calculada (Ohm) vs nominal:")
print(f"  R1: {abs(R1_ohm - r1['teorico']) / r1['teorico'] * 100:.2f}% (tolerancia {r1['tolerancia']}%)")
print(f"  R2: {abs(R2_ohm - r2['teorico']) / r2['teorico'] * 100:.2f}% (tolerancia {r2['tolerancia']}%)")
print(f"  R3: {abs(R3_ohm - r3['teorico']) / r3['teorico'] * 100:.2f}% (tolerancia {r3['tolerancia']}%)")

print()
print("Errores porcentuales R calculada (Ohm) vs multimetro:")
print(f"  R1: {abs(R1_ohm - r1['multimetro']) / r1['multimetro'] * 100:.2f}%")
print(f"  R2: {abs(R2_ohm - r2['multimetro']) / r2['multimetro'] * 100:.2f}%")
print(f"  R3: {abs(R3_ohm - r3['multimetro']) / r3['multimetro'] * 100:.2f}%")

print()
print("Errores porcentuales multimetro vs nominal:")
print(f"  R1: {abs(r1['multimetro'] - r1['teorico']) / r1['teorico'] * 100:.2f}%")
print(f"  R2: {abs(r2['multimetro'] - r2['teorico']) / r2['teorico'] * 100:.2f}%")
print(f"  R3: {abs(r3['multimetro'] - r3['teorico']) / r3['teorico'] * 100:.2f}%")

print()
print("-" * 60)
print("Paralelo y Serie")
print("-" * 60)

R_par_medido = ohm_law(r1_r2_r3_paralelo["V"], r1_r2_r3_paralelo["I_mA"])
R_serie_medido = ohm_law(r1_r2_r3_serie["V"], r1_r2_r3_serie["I_mA"])

R_par_teorico = 1 / (1/r1["teorico"] + 1/r2["teorico"] + 1/r3["teorico"])
R_serie_teorico = r1["teorico"] + r2["teorico"] + r3["teorico"]

R_par_multi = 1 / (1/r1["multimetro"] + 1/r2["multimetro"] + 1/r3["multimetro"])
R_serie_multi = r1["multimetro"] + r2["multimetro"] + r3["multimetro"]

R_par_calc = 1 / (1/R1_ohm + 1/R2_ohm + 1/R3_ohm)
R_serie_calc = R1_ohm + R2_ohm + R3_ohm

print(f"Paralelo medido (V/I):       {R_par_medido:.1f} ohm")
print(f"Paralelo teorico (nominal):  {R_par_teorico:.1f} ohm")
print(f"Paralelo teorico (multim):   {R_par_multi:.1f} ohm")
print(f"Paralelo teorico (calc Ohm): {R_par_calc:.1f} ohm")
print(f"  Error medido vs nominal:   {abs(R_par_medido - R_par_teorico) / R_par_teorico * 100:.2f}%")

print()
print(f"Serie medido (V/I):          {R_serie_medido:.1f} ohm")
print(f"Serie teorico (nominal):     {R_serie_teorico:.1f} ohm")
print(f"Serie teorico (multim):      {R_serie_multi:.1f} ohm")
print(f"Serie teorico (calc Ohm):    {R_serie_calc:.1f} ohm")
print(f"  Error medido vs nominal:   {abs(R_serie_medido - R_serie_teorico) / R_serie_teorico * 100:.2f}%")

print()
print("-" * 60)
print("Resistencia 10 MOhm - Circuito corto vs largo")
print("-" * 60)

R_cc = cc_10Megohms["V"] / (cc_10Megohms["I_muA"] * 1e-6)
R_cl = cl_10Megohms["V"] / (cl_10Megohms["I_muA"] * 1e-6)

print(f"Circuito corto: R = {cc_10Megohms['V']} V / {cc_10Megohms['I_muA']} uA = {R_cc/1e6:.2f} MOhm")
print(f"Circuito largo: R = {cl_10Megohms['V']} V / {cl_10Megohms['I_muA']} uA = {R_cl/1e6:.2f} MOhm")
print(f"Nominal: {r_10M['teorico']/1e6:.1f} MOhm, Multimetro: {r_10M['multimetro']/1e6:.2f} MOhm")
print(f"  Error cc vs nominal:   {abs(R_cc - r_10M['teorico']) / r_10M['teorico'] * 100:.2f}%")
print(f"  Error cl vs nominal:   {abs(R_cl - r_10M['teorico']) / r_10M['teorico'] * 100:.2f}%")
print(f"  Error cc vs multimetro: {abs(R_cc - r_10M['multimetro']) / r_10M['multimetro'] * 100:.2f}%")
print(f"  Error cl vs multimetro: {abs(R_cl - r_10M['multimetro']) / r_10M['multimetro'] * 100:.2f}%")

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

V_fuente_1 = 9.22
V_fuente_2 = 2.66

print()
print("=" * 60)
print("SEGUNDA PARTE: Circuito 1 (dos fuentes)")
print(f"Fuente 1: 9V nominal, {V_fuente_1}V medido")
print(f"Fuente 2: 1.5V nominal, {V_fuente_2}V medido")
print("=" * 60)

for nombre, circ in [("Circuito 1", circuito_1), ("Circuito fuente invertida", circuito_fuente_invertida)]:
    print()
    print(f"--- {nombre} ---")
    for rname in ["r1", "r2", "r3"]:
        R_calc = ohm_law(circ[rname]["V"], circ[rname]["I_mA"])
        R_nom = {"r1": r1["teorico"], "r2": r2["teorico"], "r3": r3["teorico"]}[rname]
        R_multi = {"r1": r1["multimetro"], "r2": r2["multimetro"], "r3": r3["multimetro"]}[rname]
        print(f"  {rname}: V={circ[rname]['V']}V, I={circ[rname]['I_mA']}mA, R={R_calc:.1f} ohm (nominal {R_nom}, multim {R_multi})")

    # Kirchhoff - Ley de nodos (KCL): I_R1 = I_R2 + I_R3
    I1 = circ["r1"]["I_mA"]
    I2 = circ["r2"]["I_mA"]
    I3 = circ["r3"]["I_mA"]
    print(f"  KCL: I_R1 = {I1} mA, I_R2 + I_R3 = {I2 + I3:.1f} mA, diff = {abs(I1 - (I2 + I3)):.1f} mA")

    # Kirchhoff - Ley de mallas (KVL)
    V1 = circ["r1"]["V"]
    V2 = circ["r2"]["V"]
    V3 = circ["r3"]["V"]
    print(f"  KVL malla ext: V_R1 + V_R2 = {V1 + V2:.2f} V (vs fuente 1: {V_fuente_1} V, diff = {abs(V_fuente_1 - (V1 + V2)):.2f} V)")
    print(f"  KVL: V_R2 - V_R3 = {V2 - V3:.2f} V (vs fuente 2: {V_fuente_2} V, diff = {abs(V_fuente_2 - (V2 - V3)):.2f} V)")

    # Potencia disipada
    print(f"  Potencia:")
    for rname in ["r1", "r2", "r3"]:
        P = circ[rname]["V"] * circ[rname]["I_mA"]  # mW
        print(f"    P_{rname} = {P:.2f} mW")

# Por que hay que invertir la fuente?
# Hay valor de resis a partir del cual es mejor el largo o el corto?
# Por que esta esta diferencia entre "corto" y "largo"? Cuales son los valores limites
