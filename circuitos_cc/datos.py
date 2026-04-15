def ohm_law(circ):
    return circ[1]/(circ[0] * 1000)

r1 = [
  6.1, # mA
  1.49, # V/omh
] # => Rojo-Rojo-Marron-Dorado => teorico = 220 ohm, practico = 218 ohm, tolerancia = 5%

r2 = [
  9.1, # mA
  1.48, # V
] # => Naranja-Naranja-Marron-Dorado => teorico = 330 ohm, practico = 325 ohm, tolerancia = 5%

r3 = [
  2.1, # mA
  1.49, # V
] # => Marron-Verde-Marron-Dorado => teorico = 150 ohm, practico = 148 ohm, tolerancia = 5%

r_10Megohms = [] # => teorico = 10 Mohms, practico = 9.72 Mohms

r1_r2_r3_paralelo = [
  21.3, # mA
  1.46, # V
]

r1_r2_r3_serie = [
  2.1, # mA
  1.49, # V
]

print("Resistencia 1 (220 nominal, 218 medido)", ohm_law(r1))
print("Resistencia 2", ohm_law(r2))
print("Resistencia 3", ohm_law(r3))
print("R1, R2, R3, paralelo", ohm_law(r1_r2_r3_paralelo))
print("R1, R2, R3, serie", ohm_law(r1_r2_r3_serie))

r_10Megohms = []

paralelo = []

serie = []

# Por que hay que invertir la fuente?
# Hay valor de resis a partir del cual es mejor el largo o el corto?
# Por que esta esta diferencia entre "corto" y "largo"? Cuales son los valores limites

