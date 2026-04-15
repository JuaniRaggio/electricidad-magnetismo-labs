#set document(
  title: "TP 1 - Curvas Características - Física III",
  author: ("Juan Ignacio Raggio", "Catalina Moralejo", "María Milagros Pipet", "Mora Olivero", "Julieta Abramzon"),
)

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2cm, right: 2cm),
  numbering: "1",
  number-align: bottom + right,
)

#set text(
  font: "Times New Roman",
  size: 12pt,
  lang: "es",
  hyphenate: true,
)

#set par(
  justify: true,
  leading: 0.65em,
  first-line-indent: 2em,
  spacing: 1.2em,
)

#set heading(numbering: "1.1")
#show heading.where(level: 1): set text(size: 15pt, weight: "bold")
#show heading.where(level: 2): set text(size: 13pt, weight: "bold")

#show heading: it => {
  set par(first-line-indent: 0em)
  v(0.5em)
  it
  v(0.3em)
}

#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
)

#let img-dir = "Tp_ Curvas Características/images/"

// =============================================
// CARATULA (formato obligatorio de la catedra)
// =============================================

#set par(first-line-indent: 0em)

#align(center)[
  #text(size: 13pt)[TRABAJO PRACTICO N° 1]
  #v(0.5em)
  #text(size: 18.5pt)[Curvas Características]
]

#v(2em)

GRUPO N° 5

#v(0.5em)

Integrantes del grupo:

#v(0.5em)

63319 Raggio, Juan Ignacio

64695 Moralejo, Catalina

65104 Pipet, María Milagros

65386 Olivero, Mora

65675 Abramzon, Julieta

#v(2em)

Fecha de realización del trabajo práctico: 8/4/2026

Fecha de entrega del informe: 15/4/2026

#v(1em)

#block(
  stroke: 1pt + black,
  inset: 10pt,
  width: 100%,
)[
  Observaciones:
  #repeat[.]
  #repeat[.]
  #repeat[.]
]

#v(1em)

Fecha de aprobación:

#v(1em)

Firma del docente:

#pagebreak()

// =============================================
// CONTENIDO
// =============================================

#set par(first-line-indent: 2em)

= Objetivos y Resumen

El objetivo de esta práctica es determinar las curvas características I(V) de distintos elementos de dos terminales, con el fin de analizar si tienen comportamiento óhmico o no, a partir de la observación de su linealidad.

Para esto se utilizó una resistencia de carbón depositado, una lámpara de filamento de tungsteno, diodos semiconductores de silicio y diodos semiconductores LED. En cada caso lo que se hizo fue ir variando la tensión de la fuente con suma precaución de no sobrepasar los valores máximos permitidos, registrándose así distintos valores de corriente.

Las mediciones de corriente y diferencia de potencial se realizaron con un amperímetro y un voltímetro respectivamente. A partir de los datos obtenidos se realizaron gráficos para cada uno de los elementos analizados.

= Introducción teórica

En los circuitos eléctricos el comportamiento de los distintos componentes puede analizarse mediante la relación entre la corriente eléctrica que circula por ellos y la diferencia de potencial entre sus terminales. La diferencia de potencial representa la energía por unidad de carga necesaria para mover dichas cargas entre dos puntos, y se mide en volts (V).

Mientras que la corriente describe la rapidez de flujo de carga a través de un material conductor y se mide en amperes (A) equivalente a Coulomb por segundo. La corriente promedio se obtiene dividiendo la cantidad de carga que pasa por un punto entre el intervalo de tiempo considerado. Cuando la corriente varía con el tiempo, se define la corriente instantánea como la variación de carga respecto del tiempo.

Todo material presenta cierta oposición al paso de la corriente eléctrica. A esta propiedad se le denomina resistencia eléctrica, la cual se mide en ohmios ($Omega$) y depende tanto de la resistividad del material como de la geometría del conductor.

Un material óhmico se define como aquel cuya densidad de corriente es proporcional al campo eléctrico. Este exhibe una relación lineal entre el voltaje y la corriente. En estos materiales la resistencia es constante y se define como el cociente entre la diferencia de potencial y la corriente.

#set par(first-line-indent: 0em)
$ R equiv (Delta V) / I #h(4em) [1] $
#set par(first-line-indent: 2em)

Para poder determinar si un material es óhmico se trazan las curvas características según la función:

#set par(first-line-indent: 0em)
$ I = f(V) #h(4em) [2] $
#set par(first-line-indent: 2em)

Si la correspondencia entre la corriente y el voltaje es lineal se dice que el material es óhmico. En este caso la pendiente representa la inversa de la resistencia eléctrica del material. Aquellos materiales o dispositivos donde la resistencia cambia con el voltaje o la dirección de la corriente se denominan no óhmicos.

Independientemente del tipo de material, el paso de la corriente a través de un conductor produce una disipación de calor conocida como efecto Joule. Esta transformación de energía eléctrica en térmica es directamente proporcional a la resistencia del material, al tiempo de circulación y al cuadrado de la intensidad de la corriente.

#set par(first-line-indent: 0em)
$ Q = I^2 dot R dot t #h(4em) [3] $
#set par(first-line-indent: 2em)

= Instrumentos y elementos empleados

Para la realización de este trabajo se utilizó una fuente de alimentación de corriente continua, cables de conexión, un voltímetro dispuesto en paralelo y un amperímetro dispuesto en serie.

Se emplearon además distintos elementos del circuito: una resistencia de carbón depositado, una lámpara de filamento de tungsteno, un diodo de silicio y un diodo LED.

La resistencia (220 $Omega$) es un componente pasivo lineal en el cual la tensión es proporcional a la corriente que circula, cumpliendo la ley de Ohm.

La lámpara de filamento produce luz por incandescencia al elevarse la temperatura del filamento de tungsteno debido al paso de corriente, presentando un comportamiento no lineal.

El diodo de silicio es un dispositivo semiconductor que permite la circulación de corriente en un solo sentido, mientras que el diodo LED, además de esta propiedad, emite luz cuando es atravesado por corriente eléctrica.

Estos elementos permiten analizar tanto comportamientos óhmicos como no óhmicos a partir de la relación entre la corriente y la tensión aplicada.

#v(1em)

#figure(
  image(img-dir + "image13.png", width: 70%),
  caption: [Equipo utilizado para la medición (fuente de alimentación, voltímetro, amperímetro)],
)

#v(1em)

#figure(
  image(img-dir + "image8.png", width: 50%),
  caption: [Circuito Diodo común o LED],
)

#v(1em)

#figure(
  image(img-dir + "image17.png", width: 55%),
  caption: [Circuito Resistencia o Lámpara],
)

#pagebreak()

= Datos obtenidos

== Resistencia de carbón depositado

#set par(first-line-indent: 0em)

Se realizaron 19 mediciones sin un límite de voltaje específico en intervalos de 0,5V aproximadamente. A continuación se presentan los gráficos creados a partir de los datos recolectados.

#v(1em)

#figure(
  image(img-dir + "image16.png", width: 85%),
  caption: [Curva I-V de la resistencia de carbón depositado con ajuste lineal],
)

#v(0.5em)

La ecuación de la recta es:

$ I = 3,0776 "mA/V" dot V - 0,19 "mA" $

Por la ley de Ohm *[1]*, sabemos que la relación que existe entre voltaje, resistencia e intensidad es la siguiente:

$ I / V = 1 / R arrow.double m = 1 / V = 1 / R $

Por lo que, si se reemplaza $m$, se obtiene:

$ R = 1 / m approx 325 space Omega $

#v(0.5em)

#align(center)[
  #table(
    columns: 2,
    align: center,
    table.header([*Tensión (V)*], [*Corriente (mA)*]),
    [0.5], [1.5],
    [1.1], [3],
    [2], [6],
    [2.5], [7.5],
    [3], [9],
    [3.5], [10.6],
    [4], [12.1],
    [4.5], [13.7],
    [5], [15.2],
    [5.5], [16.7],
    [6], [18.3],
    [6.5], [19.8],
    [7], [21.4],
    [7.5], [22.9],
    [8], [24.4],
    [8.5], [26],
    [9], [27.5],
    [9.5], [29],
    [10], [30.6],
  )
]

#pagebreak()

== Lámpara de filamento

Se realizaron 24 mediciones sin superar el límite de voltaje de 12V. Se fue incrementando aproximadamente en 0,5V.

#v(1em)

#figure(
  image(img-dir + "image9.png", width: 85%),
  caption: [Curva I-V de la lámpara de filamento de tungsteno],
)

#v(0.5em)

#align(center)[
  #table(
    columns: 2,
    align: center,
    table.header([*Tensión (V)*], [*Corriente (mA)*]),
    [0.5], [34],
    [1], [41.3],
    [1.5], [47.1],
    [2], [53.2],
    [2.5], [59],
    [3.01], [64.9],
    [3.5], [70.7],
    [4], [75.2],
    [4.5], [81],
    [5], [85],
    [5.5], [90.4],
    [6], [94],
    [6.65], [100],
    [7], [102.5],
    [7.5], [107.0],
    [8], [110.9],
    [8.5], [115],
    [9], [118.6],
    [9.4], [121.9],
    [10.02], [126.2],
    [10.46], [129.5],
    [11], [133.9],
    [11.6], [137.4],
    [12], [140.9],
  )
]

#pagebreak()

== Diodo de Silicio

Se realizaron 19 mediciones comenzando con un voltaje de 0,4V y aumentando hasta 2V. Se tuvo en cuenta no superar el límite de 125mA para no quemar el fusible del amperímetro. A su vez se consideró la polaridad del diodo al conectar los cables, conectando el ánodo al polo positivo y el cátodo al polo negativo. A continuación se presentan los gráficos realizados.

#v(1em)

#figure(
  image(img-dir + "image10.png", width: 85%),
  caption: [Curva I-V del diodo de silicio],
)

#v(0.5em)

#align(center)[
  #table(
    columns: 2,
    align: center,
    table.header([*Tensión (V)*], [*Corriente (mA)*]),
    [0.4], [0],
    [0.45], [0],
    [0.5], [0.3],
    [0.55], [1],
    [0.6], [2],
    [0.65], [4.1],
    [0.7], [6.3],
    [0.75], [8.5],
    [0.8], [12.4],
    [0.85], [15.5],
    [0.9], [19.1],
    [0.95], [23.3],
    [1], [27.8],
    [1.05], [29.4],
    [1.1], [33.5],
    [1.15], [38],
    [1.2], [42.9],
    [1.5], [74.5],
    [2], [125],
  )
]

#pagebreak()

== Diodo LED

Se realizaron 30 mediciones en este caso. Se tuvo en cuenta el hecho de que la corriente de circulación debía mantenerse menor a 30 mA. A su vez se agregó una resistencia en serie que limitó la corriente para evitar que se perjudique el diodo producto de posibles variaciones de tensión.

#v(1em)

#figure(
  image(img-dir + "image12.png", width: 85%),
  caption: [Curva I-V del diodo LED rojo],
)

#v(0.5em)

#align(center)[
  #table(
    columns: 2,
    align: center,
    table.header([*Tensión (V)*], [*Corriente (mA)*]),
    [2.26], [29.5],
    [2.23], [28.5],
    [2.23], [27.6],
    [2.21], [26.5],
    [2.2], [25.5],
    [2.18], [24.5],
    [2.16], [23.5],
    [2.15], [22.5],
    [2.13], [21.5],
    [2.11], [20.5],
    [2.1], [19.4],
    [2.08], [18.5],
    [2.06], [17.5],
    [2.05], [16.4],
    [2.03], [15.5],
    [2.01], [14.5],
    [2], [13.5],
    [1.98], [12.4],
    [1.96], [11.4],
    [1.93], [10.3],
    [1.92], [9.5],
    [1.89], [8.4],
    [1.87], [7.4],
    [1.84], [6.5],
    [1.81], [5.4],
    [1.78], [4.5],
    [1.71], [3.4],
    [1.55], [2.5],
    [1.21], [1.5],
    [0.69], [0.5],
  )
]

#pagebreak()

= Análisis de los resultados

== Resistencia de carbón depositado

El gráfico de intensidad de corriente en función de la tensión para la resistencia de carbón depositado evidencia una relación lineal marcada entre ambas magnitudes. A medida que aumenta la tensión aplicada, la corriente también aumenta de manera proporcional, lo que indica un comportamiento acorde con la Ley de Ohm.

El ajuste lineal obtenido presenta una pendiente aproximada de *3,08 mA/V*, mientras que la ordenada al origen resulta cercana a cero. Esto permite afirmar que el modelo lineal describe adecuadamente los datos experimentales y que, en el rango de tensiones analizado, la resistencia se comporta como un *elemento óhmico*.

La pendiente de la recta representa la conductancia del resistor, por lo que su inversa corresponde al valor de la resistencia. A partir de ella, se obtiene un valor aproximado de:

$ R = 1 / m approx 1 / (3,08 "mA/V") approx 0,325 "k" Omega $

Este resultado indica que la resistencia se mantuvo prácticamente constante a lo largo de todas las mediciones realizadas, lo cual refuerza la conclusión de que el componente presenta comportamiento óhmico. Por lo tanto, las mediciones obtenidas fueron consistentes con lo esperado teóricamente para una resistencia de carbón depositado.

#pagebreak()

= Anexo

== Cálculo del error

$ E = (|R_"pendiente" - R_"nominal"|) / R_"nominal" times 100 = (|325 Omega - 330 Omega|) / (330 Omega) times 100 = 1,52% $

#pagebreak()

// =============================================
// EXTRA: Implementación computacional
// =============================================

#set par(first-line-indent: 0em)

= Extra: Implementación computacional de los modelos físicos

En esta sección se presentan los fragmentos centrales del código Python desarrollado para el análisis de las curvas características. Se busca mostrar cómo los modelos físicos estudiados en la materia se traducen a implementaciones computacionales, y qué conclusiones pueden extraerse de cada uno.

== Modelos físicos implementados

=== Ley de Ohm: resistencia

```python
def modelo_resistencia(V, R):
    """Ley de Ohm: I = V / R."""
    return V / R
```

Este modelo es el más directo: la relación $I = V / R$ predice una curva lineal. Al ajustarlo a los datos experimentales, el único parámetro libre es $R$. El hecho de que el ajuste lineal tenga un coeficiente $R^2 approx 1$ confirma el comportamiento óhmico del componente y permite extraer la resistencia con su incertidumbre.

=== Ecuación de Shockley con resistencia serie (diodo y LED)

```python
from scipy.special import lambertw

def modelo_diodo(V, I_s, n, R_s):
    """Shockley con resistencia serie (solucion analitica via Lambert W).
    I = (n*V_T/R_s) * W(I_s*R_s/(n*V_T) * exp(V/(n*V_T)))
    """
    nVt = n * V_T
    z = I_s * R_s / nVt * np.exp(np.clip(V / nVt, -500, 500))
    W = np.real(lambertw(z))
    return nVt / R_s * W
```

La ecuación de Shockley ideal $I = I_s (e^(V \/ n V_T) - 1)$ no contempla la resistencia serie $R_s$ del dispositivo, que produce una caída de tensión adicional $V_"diodo" = V - I R_s$. Esta dependencia implícita de $I$ en ambos lados de la ecuación se resuelve analíticamente mediante la función $W$ de Lambert, que satisface $W(z) e^(W(z)) = z$.

Los tres parámetros ajustados revelan:
- $I_s$ (corriente de saturación inversa): del orden de $10^(-10)$ A para el diodo de silicio, refleja la concentración de portadores minoritarios.
- $n$ (factor de idealidad): valores cercanos a 2 indican que la recombinación en la zona de deplexión domina sobre la difusión ($n = 1$).
- $R_s$ (resistencia serie): modela las resistencias de contacto y del material semiconductor fuera de la juntura.

El uso de `np.clip` previene desbordamientos numéricos en la exponencial, un detalle necesario cuando se trabaja con rangos amplios de tensión.

=== Modelo potencial para la lámpara

```python
def modelo_lampara_potencial(V, a, b):
    """Modelo potencial: I = a * V^b (para V > 0)."""
    return a * np.power(np.abs(V), b)
```

La lámpara incandescente presenta una relación $I = a V^b$ con $b < 1$, lo que refleja que la resistencia aumenta con la tensión. Físicamente, esto ocurre porque el filamento de tungsteno incrementa su temperatura al recibir más potencia, y la resistividad de los metales crece con la temperatura. El exponente $b$ está relacionado con la dependencia $R(T)$ del tungsteno: si $R prop T^alpha$, entonces $b = 1/(1 + alpha)$. Para tungsteno, $alpha approx 1.2$, lo que predice $b approx 0.45$, consistente con los valores obtenidos experimentalmente.

== Cálculo de resistencia dinámica

```python
from scipy.signal import savgol_filter

def resistencia_dinamica(V, I, window=5, polyorder=2):
    """Calcula r(V) = dV/dI usando derivada numerica suavizada."""
    dI_dV = np.gradient(I, V)
    dI_dV_suave = savgol_filter(dI_dV, window, polyorder)
    r_din = np.where(np.abs(dI_dV_suave) > 1e-12,
                     1.0 / dI_dV_suave, np.inf)
    return np.abs(r_din)
```

La resistencia dinámica $r = d V \/ d I$ evaluada punto a punto constituye una "huella digital" de cada componente:
- *Resistencia óhmica:* $r$ es constante en todo el rango de operación.
- *Diodo y LED:* $r$ decrece exponencialmente con $V$, ya que $d I \/ d V$ crece exponencialmente en la zona de conducción directa.
- *Lámpara:* $r$ crece con $V$, reflejando el aumento de temperatura del filamento.

El filtro de Savitzky-Golay es necesario para suavizar el ruido inherente a la derivación numérica de datos discretos, preservando la forma general de la curva.

== Estimación de la temperatura del filamento

```python
def temperatura_filamento(V, I, R0=14.7, T0=295.0, alpha_exp=1.2):
    """T = T0 * (R / R0)^(1 / alpha_exp)"""
    R = np.where(I > 1e-6, V / I, R0)
    T = T0 * np.power(R / R0, 1.0 / alpha_exp)
    return T, R
```

Conociendo la resistencia en frío $R_0 = V_0 / I_0 = 14.7 space Omega$ (medida al punto de menor tensión) y el exponente de temperatura del tungsteno $alpha approx 1.2$, se puede invertir la relación $R = R_0 (T / T_0)^alpha$ para obtener la temperatura del filamento en cada punto de operación:

$ T = T_0 dot (R / R_0)^(1 / alpha) $

Esto permite verificar que la lámpara alcanza temperaturas del orden de 2000--2500 K en su rango de operación, muy por debajo del punto de fusión del tungsteno (3695 K), lo cual es consistente con una lámpara funcionando en condiciones normales.

== Verificación de la ley de Stefan-Boltzmann

```python
def verificacion_stefan_boltzmann(V, I, T):
    """Verifica P ~ T^4. Ajusta log(P) vs log(T)."""
    P = V * I
    mask = (P > 1e-6) & (T > T_amb + 50)
    log_P = np.log(P[mask])
    log_T = np.log(T[mask])
    resultado = linregress(log_T, log_P)
    return resultado.slope, resultado.intercept, resultado.rvalue**2
```

En régimen estacionario, la potencia disipada por el filamento se radia al entorno según la ley de Stefan-Boltzmann: $P = epsilon sigma A T^4$. Tomando logaritmo en ambos lados: $ln(P) = 4 ln(T) + "cte"$. Si el ajuste lineal de $ln(P)$ vs $ln(T)$ produce una pendiente cercana a 4, se confirma que el mecanismo dominante de disipación es la radiación térmica. Desviaciones de este valor pueden atribuirse a pérdidas por conducción a través de los contactos o a la dependencia de la emisividad con la temperatura.

== Extracción del factor de idealidad

```python
def factor_idealidad(V, I, V_min=None, V_max=None):
    """ln(I) = ln(I_s) + V / (n * V_T)
    Pendiente = 1 / (n * V_T) -> n = 1 / (pendiente * V_T)"""
    mask = I > 1e-6
    V_fit = V[mask]
    ln_I = np.log(I[mask])
    resultado = linregress(V_fit, ln_I)
    n = 1.0 / (resultado.slope * V_T)
    I_s = np.exp(resultado.intercept)
    return n, I_s, resultado.rvalue**2, (V_fit, ln_I, resultado)
```

Al graficar $ln(I)$ vs $V$, la ecuación de Shockley predice una recta cuya pendiente es $1 / (n V_T)$. Este método gráfico permite extraer el factor de idealidad $n$ de forma independiente al ajuste no lineal, y comparar ambos resultados como validación cruzada. La ordenada al origen proporciona $ln(I_s)$, lo que permite estimar la corriente de saturación.

== Energía del gap del LED

```python
def energia_gap_led(V, I, metodo="tangente"):
    """E_g = q * V_th, lambda = h * c / E_g"""
    n_pts = max(3, len(V) // 3)
    V_lin = V[-n_pts:]
    I_lin = I[-n_pts:]
    resultado = linregress(V_lin, I_lin)
    V_th = -resultado.intercept / resultado.slope
    E_g = q * V_th
    lam = h * c / E_g
    lam_nm = lam * 1e9
    return {"V_th": V_th, "E_g_eV": V_th, "lambda_nm": lam_nm}
```

La tensión umbral $V_"th"$ del LED está directamente relacionada con la energía del gap del semiconductor: $E_g = q V_"th"$. A partir de esta energía se puede calcular la longitud de onda del fotón emitido $lambda = h c \/ E_g$. Para un LED rojo, se espera $lambda approx 620-750$ nm, lo que corresponde a $V_"th" approx 1.65-2.0$ V. La coincidencia entre el valor medido y el color observado del LED constituye una verificación experimental directa de la relación entre la estructura de bandas del semiconductor y la emisión de luz.

== Simulación Monte Carlo para propagación de incertidumbres

```python
def monte_carlo(datos, modelo_info, N=10000, seed=42):
    """Perturba datos N veces y reajusta para obtener
    distribuciones de parametros."""
    rng = np.random.default_rng(seed)
    sigma = datos.delta_I
    samples, curvas = [], []
    for _ in range(N):
        I_pert = datos.I + rng.normal(0, sigma)
        try:
            popt, _ = curve_fit(funcion, datos.V, I_pert,
                                p0=p0, bounds=bounds,
                                sigma=sigma, absolute_sigma=True)
            samples.append(popt)
            curvas.append(funcion(V_modelo, *popt))
        except RuntimeError:
            continue
    banda_inf = np.percentile(curvas, 2.5, axis=0)
    banda_sup = np.percentile(curvas, 97.5, axis=0)
```

Cuando los modelos son no lineales (como Shockley con Lambert W o la ley potencial), la propagación analítica de incertidumbres puede ser imprecisa o algebraicamente inviable. El método Monte Carlo ofrece una alternativa: se generan $N = 10000$ conjuntos de datos perturbados con ruido gaussiano proporcional a la incertidumbre del instrumento ($sigma$), se reajusta el modelo en cada caso, y se obtienen distribuciones empíricas de los parámetros. Los percentiles 2.5% y 97.5% de las curvas resultantes definen una banda de confianza del 95%. Este enfoque es especialmente válido para el diodo y el LED, donde la alta no linealidad del modelo hace que las incertidumbres de los parámetros no sean simétricas.

== Conclusiones del desarrollo computacional

El código implementado permite extraer conclusiones físicas que trascienden la simple visualización de datos:

+ *Validación de modelos:* El ajuste por mínimos cuadrados con el estadístico $chi^2$ reducido permite evaluar cuantitativamente si el modelo físico propuesto describe adecuadamente los datos, o si se requieren correcciones (como la resistencia serie $R_s$ en Shockley).

+ *Conexión teoría-experimento:* Cada parámetro ajustado tiene interpretación física directa. La resistencia $R$ confirma la ley de Ohm, el factor de idealidad $n$ revela el mecanismo de transporte dominante, y el exponente $b$ de la lámpara vincula la curva $I$-$V$ con propiedades del material del filamento.

+ *Propagación rigurosa de incertidumbres:* La simulación Monte Carlo proporciona intervalos de confianza realistas para modelos no lineales, superando las limitaciones de la propagación linealizada.

+ *Medición indirecta de temperatura:* Sin usar un termómetro, la curva $I$-$V$ de la lámpara permite estimar la temperatura del filamento y verificar la ley de Stefan-Boltzmann, demostrando cómo una medición eléctrica sencilla contiene información termodinámica.

+ *Determinación del gap semiconductor:* A partir de la tensión umbral del LED se estima la energía del gap y la longitud de onda de emisión, conectando el comportamiento eléctrico del dispositivo con sus propiedades ópticas y la física del estado sólido.

== Nota sobre herramientas utilizadas

Para la elaboración de esta sección se consultó a Claude (Anthropic) como herramienta complementaria de referencia. Se utilizó principalmente para contrastar las expresiones de los modelos físicos (ecuación de Shockley, dependencia $R(T)$ del tungsteno, ley de Stefan-Boltzmann) con las formulaciones presentes en la bibliografía, y para verificar la consistencia dimensional de las ecuaciones implementadas.

== Referencias

+ S. M. Sze y K. K. Ng, _Physics of Semiconductor Devices_, 3ra ed., Wiley, 2007. Referencia para la ecuación de Shockley, el factor de idealidad $n$, la corriente de saturación $I_s$ y la relación $E_g = q V_"th"$ en diodos y LEDs.

+ JCGM 101:2008, _Evaluation of measurement data -- Supplement 1 to the "Guide to the expression of uncertainty in measurement" -- Propagation of distributions using a Monte Carlo method_. Norma internacional que fundamenta el uso de simulación Monte Carlo para la propagación de incertidumbres cuando los modelos son no lineales.

+ Anthropic, _Claude_ (modelo de lenguaje), 2024--2026. Utilizado como herramienta de asistencia complementaria para la verificación de modelos físicos.
