#set document(
  title: "Curvas Características I(V)",
  author: ("Raggio, J. I.", "Moralejo, C.", "Pipet, M. M.", "Olivero, M.", "Abramzon, J."),
)

// =============================================
// CONFIGURACION GLOBAL
// =============================================

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2cm, right: 2cm),
  numbering: "1",
  number-align: bottom + center,
  header: context {
    if counter(page).get().first() > 1 [
      #set text(size: 8pt, fill: gray)
      #grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [_Curvas Características -- Física III_],
        [_Raggio, Moralejo, Pipet, Olivero, Abramzon_],
      )
      #line(length: 100%, stroke: 0.4pt + gray)
    ]
  },
)

#set text(
  font: "New Computer Modern",
  size: 11pt,
  lang: "es",
  hyphenate: true,
)

#set par(
  justify: true,
  leading: 0.65em,
  first-line-indent: 1.5em,
  spacing: 1em,
)

#set heading(numbering: "1.1.")
#set math.equation(numbering: "(1)")
#show heading.where(level: 1): it => {
  set text(size: 13pt, weight: "bold")
  set par(first-line-indent: 0em)
  v(1em)
  block(width: 100%)[
    #it
  ]
  v(0.4em)
}
#show heading.where(level: 2): it => {
  set text(size: 11pt, weight: "bold")
  set par(first-line-indent: 0em)
  v(0.8em)
  it
  v(0.3em)
}
#show heading.where(level: 3): it => {
  set text(size: 11pt, weight: "bold", style: "italic")
  set par(first-line-indent: 0em)
  v(0.6em)
  it
  v(0.2em)
}

// Estilo de tablas: lineas horizontales tipo booktabs
#set table(
  stroke: none,
  inset: 6pt,
  align: center,
)
#show table: set text(size: 10pt)

// Estilo de figuras
#show figure.caption: it => {
  set text(size: 9.5pt)
  it
}

// Codigo
#show raw.where(block: true): block.with(
  fill: luma(245),
  inset: 8pt,
  radius: 3pt,
  width: 100%,
)
#show raw.where(block: true): set text(size: 9pt)

#let img-dir = "assets/"

// =============================================
// CARATULA (formato obligatorio de la catedra)
// =============================================

#set page(numbering: none, header: none, footer: none)

#set par(first-line-indent: 0em)

#v(1em)

#align(center)[
  #text(size: 13pt)[TRABAJO PRACTICO N° 1]
  #v(0.3em)
  #text(size: 18pt, weight: "bold")[Curvas Características]
]

#v(2em)

#text(size: 12pt)[
  GRUPO N° 5

  #v(0.5em)

  Integrantes del grupo:

  #v(0.3em)

  #pad(left: 1em)[
    63319 #h(0.5em) Raggio, Juan Ignacio \
    64695 #h(0.5em) Moralejo, Catalina \
    65104 #h(0.5em) Pipet, María Milagros \
    65386 #h(0.5em) Olivero, Mora \
    65675 #h(0.5em) Abramzon, Julieta
  ]

  #v(1.5em)

  Fecha de realización del trabajo práctico: 8/4/2026

  Fecha de entrega del informe: 15/4/2026

  #v(1em)

  #block(
    stroke: 1pt + black,
    inset: 10pt,
    width: 100%,
  )[
    Observaciones: #repeat[.]
    #v(1em)
    #repeat[.]
  ]

  #v(1em)

  Fecha de aprobación: #h(1fr) #line(length: 30%, stroke: 0.5pt + black)

  #v(0.5em)

  Firma del docente: #h(1fr) #line(length: 30%, stroke: 0.5pt + black)
]

#pagebreak()

// =============================================
// INDICE
// =============================================

#set page(
  numbering: "i",
  header: none,
  footer: context {
    set text(size: 8pt, fill: gray)
    align(center)[#counter(page).display("i")]
  },
)
#counter(page).update(1)

#v(2em)
#align(center)[
  #text(size: 14pt, weight: "bold")[Índice]
]
#v(1em)

#outline(title: none, depth: 2, indent: 1.5em)

#pagebreak()

// =============================================
// CONTENIDO
// =============================================

#set page(
  numbering: "1",
  header: context {
    if counter(page).get().first() > 1 [
      #set text(size: 8pt, fill: gray)
      #grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [_Curvas Características -- Física III_],
        [_Raggio, Moralejo, Pipet, Olivero, Abramzon_],
      )
      #line(length: 100%, stroke: 0.4pt + gray)
    ]
  },
  footer: context {
    if counter(page).get().first() > 1 [
      #set text(size: 8pt, fill: gray)
      #line(length: 100%, stroke: 0.4pt + gray)
      #v(0.2em)
      #grid(
        columns: (1fr, 1fr, 1fr),
        align: (left, center, right),
        [_ITBA -- Física III_],
        [#counter(page).display("1")],
        [_Abril 2026_],
      )
    ]
  },
)
#counter(page).update(1)

// =============================================
// TITULO Y AUTORES (estilo paper)
// =============================================

#align(center)[
  #text(size: 16pt, weight: "bold")[
    Curvas Características I(V)
  ]

  #v(0.8em)

  #text(size: 10pt)[
    J. I. Raggio, C. Moralejo, M. M. Pipet, M. Olivero, J. Abramzon
  ]

  #v(0.3em)

  #text(size: 9pt, fill: gray)[
    #super[1] Instituto Tecnológico de Buenos Aires (ITBA) -- Física III \
    Comisión B -- Laboratorio: Miércoles 10:00 \
    8 de abril de 2026
  ]
]

#v(0.5em)
#line(length: 100%, stroke: 0.5pt)
#v(0.3em)

// Abstract
#par(first-line-indent: 0em)[
  #text(weight: "bold", size: 10pt)[Resumen --]
  #text(size: 10pt)[
    Se determinaron las curvas características I(V) de una resistencia de carbón depositado, una lámpara de filamento de tungsteno, un diodo semiconductor de silicio y un diodo LED rojo. A partir de los datos experimentales se analizó la linealidad de cada componente. La resistencia presentó comportamiento óhmico con $R = 325 space Omega$ ($R^2 = 0,"9999"$), mientras que la lámpara, el diodo y el LED exhibieron comportamientos marcadamente no lineales, consistentes con sus respectivos modelos físicos.
  ]
]

#v(0.3em)
#line(length: 100%, stroke: 0.5pt)
#v(0.5em)

// =============================================
// 1. OBJETIVOS
// =============================================

= Objetivos

#par(first-line-indent: 0em)[
  Determinar las curvas características $I(V)$ de distintos elementos de dos terminales y analizar su linealidad. Los elementos analizados son: (a) resistencia de carbón depositado, (b) lámpara de filamento de tungsteno, (c) diodo semiconductor de silicio y (d) diodo semiconductor LED.
]

// =============================================
// 2. MARCO TEORICO
// =============================================

= Marco teórico

La resistencia eléctrica de un componente de dos terminales se define como el cociente entre la diferencia de potencial aplicada y la corriente que circula:

$ R equiv (Delta V) / I $

Un material se denomina _óhmico_ cuando la relación entre corriente y tensión es lineal, es decir, cuando la resistencia $R$ es constante. Para clasificar un componente se traza su _curva característica_:

$ I = f(V) $

Si $I(V)$ es una recta que pasa por el origen, el componente es óhmico y la pendiente $m = 1\/R$ permite determinar su resistencia. Los componentes donde $R$ varía con la tensión o la dirección de la corriente se denominan _no óhmicos_.

El paso de corriente a través de cualquier conductor produce disipación de energía térmica por efecto Joule:

$ Q = I^2 dot R dot t $

Este efecto es particularmente relevante en la lámpara de filamento, donde la potencia disipada eleva la temperatura del tungsteno, modificando su resistividad y generando el comportamiento no lineal observado.

// =============================================
// 3. DISPOSITIVO EXPERIMENTAL
// =============================================

= Dispositivo experimental

Se utilizó una fuente de alimentación de corriente continua, un voltímetro digital dispuesto en paralelo y un amperímetro digital dispuesto en serie. Los componentes analizados fueron: una resistencia de carbón depositado (valor nominal 330 $Omega$), una lámpara de filamento de tungsteno, un diodo de silicio y un diodo LED rojo.

#v(0.5em)

#figure(
  image(img-dir + "image13.png", width: 60%),
  caption: [Montaje experimental: fuente de alimentación, voltímetro y amperímetro.],
) <fig-montaje>

#v(0.5em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  figure(
    image(img-dir + "image17.png", width: 90%),
    caption: [Circuito para resistencia y lámpara.],
  ),
  figure(
    image(img-dir + "image8.png", width: 85%),
    caption: [Circuito para diodo y LED.],
  ),
)

En cada caso se varió la tensión de la fuente registrando los valores de corriente correspondientes, sin sobrepasar los límites máximos de cada componente.

// =============================================
// 4. RESULTADOS
// =============================================

= Resultados experimentales

== Resistencia de carbón depositado

Se realizaron 19 mediciones en intervalos de aproximadamente 0,5 V. Los datos completos se encuentran en el Anexo (Sección 7.2).

#v(0.5em)

#figure(
  image(img-dir + "grafico_resistencia.png", width: 70%),
  caption: [Curva I(V) de la resistencia con ajuste lineal por mínimos cuadrados.],
) <fig-resistencia>

La ecuación del ajuste lineal obtenido es:

$ I = 3","0776 space "mA/V" dot V - 0","19 space "mA" $

Dado que $I\/V = 1\/R = m$, la resistencia experimental resulta:

$ R = 1 / m = 1 / (3","0776 space "mA/V") approx 325 space Omega $

El coeficiente de determinación $R^2 = 0","9999$ confirma la excelente calidad del ajuste lineal.

#pagebreak()

== Lámpara de filamento de tungsteno

Se realizaron 24 mediciones hasta un voltaje máximo de 12 V.

#v(0.5em)

#figure(
  image(img-dir + "grafico_lampara.png", width: 70%),
  caption: [Curva I(V) de la lámpara de filamento de tungsteno.],
) <fig-lampara>

== Diodo de silicio

Se realizaron 19 mediciones entre 0,4 V y 2 V, sin superar 125 mA para proteger el fusible del amperímetro. Se conectó el ánodo al polo positivo y el cátodo al polo negativo.

#v(0.5em)

#figure(
  image(img-dir + "grafico_diodo.png", width: 70%),
  caption: [Curva I(V) del diodo de silicio.],
) <fig-diodo>

#pagebreak()

== Diodo LED (rojo)

Se realizaron 30 mediciones manteniendo la corriente por debajo de 30 mA. Se agregó una resistencia en serie para limitar la corriente y proteger el dispositivo.

#v(0.5em)

#figure(
  image(img-dir + "grafico_led.png", width: 70%),
  caption: [Curva I(V) del diodo LED rojo.],
) <fig-led>

// =============================================
// 5. ANALISIS Y DISCUSION
// =============================================

= Análisis y discusión

== Resistencia

El gráfico de la @fig-resistencia evidencia una relación lineal entre corriente y tensión, consistente con la ley de Ohm. La pendiente $m = 3","0776$ mA/V corresponde a una resistencia de $R approx 325 space Omega$, y la ordenada al origen $b = -0","19$ mA es despreciable frente al rango de medición (0--30,6 mA), confirmando que la recta pasa por el origen dentro de la incertidumbre experimental.

El valor obtenido es consistente con una resistencia comercial de $330 space Omega$ (tolerancia $plus.minus 5%$). El error porcentual respecto al valor nominal es:

$ E = (|R_"exp" - R_"nom"|) / R_"nom" times 100 % = (|325 - 330|) / 330 times 100 % = 1","52 % $

Este error se encuentra dentro de la tolerancia del componente, lo que valida tanto el método de medición como el ajuste realizado.

== Lámpara de filamento

La curva I(V) de la @fig-lampara muestra un comportamiento claramente no lineal: la corriente crece con la tensión pero con pendiente decreciente. A partir de las 24 mediciones experimentales realizadas en el rango de 0,5 V a 12 V, se observó que la resistencia del filamento no es constante sino que aumenta significativamente desde $R approx 14","7 space Omega$ en el primer punto hasta $R approx 85","1 space Omega$ en el último. Este incremento refleja el efecto directo de la temperatura sobre el material conductor, cuyo comportamiento responde a la ecuación:

$ R(T) = R_0 [1 + alpha (T - T_0)] $

Esta variación se explica por el efecto Joule. Al circular corriente eléctrica, el filamento se calienta, provocando que los átomos de su red cristalina vibren con mayor amplitud. Estas vibraciones actúan como obstáculos que reducen la movilidad de los electrones de conducción. Al aumentar los choques, gran parte de la energía cinética de los electrones se transfiere como calor, lo que incrementa progresivamente la resistividad del material.

Es fundamental destacar que la no linealidad observada en la curva no implica una violación de la ley de Ohm. El tungsteno conserva su carácter óhmico en todo momento: a cada temperatura fija, la relación entre corriente y tensión es lineal ($bold(J) = sigma bold(E)$, con $sigma$ independiente del campo eléctrico). Sin embargo, al tratarse de un sistema con acoplamiento eléctrico-térmico ---donde la propia corriente modifica la temperatura y, con ella, la resistividad--- la pendiente del gráfico varía constantemente. En frío, la curva inicia con una pendiente pronunciada (menor resistencia), pero a medida que el filamento se calienta, la resistencia aumenta y la curva disminuye su pendiente. La relación $V = I dot R$ se cumple estrictamente en cada estado térmico estable del material, pero como $R$ depende del punto de operación, la lámpara como dispositivo se clasifica como _no óhmica_.

== Diodo de silicio

La @fig-diodo exhibe la curva exponencial típica de un diodo semiconductor. El diodo consiste en una juntura PN: la unión de un semiconductor tipo _n_ (con exceso de electrones libres por átomos donantes de valencia 5) y uno tipo _p_ (con exceso de huecos por átomos aceptores de valencia 3). En la interfaz se forma una _zona de depleción_, región desprovista de portadores libres donde se establece una barrera de potencial interna de aproximadamente 0,7 V para el silicio.

Por debajo de esta tensión umbral, la corriente es prácticamente nula (zona de corte): el campo eléctrico externo no alcanza a superar la barrera interna de la juntura, y los portadores mayoritarios no pueden cruzarla. A partir de $V approx 0","5$ V se observa el inicio de la conducción, y la corriente crece de forma exponencial conforme la tensión externa reduce progresivamente la barrera de potencial. Este comportamiento está gobernado por la ecuación de Shockley:

$ I = I_s (e^(V \/ n V_T) - 1) $

donde $I_s$ es la corriente de saturación inversa, $n$ el factor de idealidad y $V_T = k T \/ q approx 26$ mV a temperatura ambiente. A diferencia de la lámpara, la no linealidad del diodo es _intrínseca_ al dispositivo: surge de la física de la juntura PN y no de un efecto térmico acoplado. El diodo es un componente marcadamente no óhmico.

== Diodo LED

La @fig-led presenta un comportamiento cualitativamente similar al del diodo de silicio, ya que el LED es fundamentalmente un diodo de juntura PN. Sin embargo, su tensión umbral es más elevada (aproximadamente 1,7--1,8 V en nuestras mediciones), lo cual es consistente con el valor teórico de 1,8 V reportado para LEDs rojos.

La diferencia principal respecto al diodo convencional es el fenómeno de _electroluminiscencia_: cuando los electrones cruzan la juntura y se recombinan con los huecos, la energía liberada se emite como fotones de luz visible en lugar de disiparse como calor. La energía de estos fotones está determinada por el gap del semiconductor ($E_g = q V_"th"$), que a su vez fija la longitud de onda de la luz emitida según $lambda = h c \/ E_g$. Para un LED rojo, esto predice $lambda approx 620$--$700$ nm, consistente con el color observado durante la experiencia.

Al igual que el diodo de silicio, el LED es un componente no óhmico cuya no linealidad es intrínseca a la estructura del semiconductor.

// =============================================
// 6. CONCLUSIONES
// =============================================

= Conclusiones

#par(first-line-indent: 0em)[
  Se determinaron satisfactoriamente las curvas características I(V) de los cuatro componentes. La resistencia de carbón depositado presentó comportamiento óhmico ($R^2 = 0","9999$), con un valor experimental de $325 space Omega$ que difiere en solo un 1,52% del valor nominal de $330 space Omega$. La lámpara de filamento, el diodo de silicio y el diodo LED presentaron comportamientos no lineales, cada uno con características distintivas: crecimiento sublineal en la lámpara (por dependencia térmica de la resistividad), crecimiento exponencial en el diodo (ecuación de Shockley) y crecimiento exponencial con tensión umbral elevada en el LED (relacionada con el gap del semiconductor).
]

// =============================================
// 7. ANEXO
// =============================================

= Anexo

== Cálculo del error

El error porcentual entre el valor experimental y el nominal se calcula como:

$ E = (|R_"exp" - R_"nom"|) / R_"nom" times 100 % $

Para la resistencia:

$ E = (|325 space Omega - 330 space Omega|) / (330 space Omega) times 100 % = 1","52 % $

== Tablas de datos experimentales

#{
  set text(size: 8.5pt)
  set table(inset: 3.5pt)

  grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    figure(
      table(
        columns: 2,
        table.hline(stroke: 1.5pt),
        table.header([*V (V)*], [*I (mA)*]),
        table.hline(stroke: 0.75pt),
        [0.5], [1.5],
        [1.1], [3.0],
        [2.0], [6.0],
        [2.5], [7.5],
        [3.0], [9.0],
        [3.5], [10.6],
        [4.0], [12.1],
        [4.5], [13.7],
        [5.0], [15.2],
        [5.5], [16.7],
        [6.0], [18.3],
        [6.5], [19.8],
        [7.0], [21.4],
        [7.5], [22.9],
        [8.0], [24.4],
        [8.5], [26.0],
        [9.0], [27.5],
        [9.5], [29.0],
        [10.0], [30.6],
        table.hline(stroke: 1.5pt),
      ),
      caption: [Resistencia de carbón depositado.],
    ),
    figure(
      table(
        columns: 2,
        table.hline(stroke: 1.5pt),
        table.header([*V (V)*], [*I (mA)*]),
        table.hline(stroke: 0.75pt),
        [0.5], [34.0],
        [1.0], [41.3],
        [1.5], [47.1],
        [2.0], [53.2],
        [2.5], [59.0],
        [3.01], [64.9],
        [3.5], [70.7],
        [4.0], [75.2],
        [4.5], [81.0],
        [5.0], [85.0],
        [5.5], [90.4],
        [6.0], [94.0],
        [6.65], [100.0],
        [7.0], [102.5],
        [7.5], [107.0],
        [8.0], [110.9],
        [8.5], [115.0],
        [9.0], [118.6],
        [9.4], [121.9],
        [10.02], [126.2],
        [10.46], [129.5],
        [11.0], [133.9],
        [11.6], [137.4],
        [12.0], [140.9],
        table.hline(stroke: 1.5pt),
      ),
      caption: [Lámpara de filamento de tungsteno.],
    ),
  )

  v(1em)

  grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    figure(
      table(
        columns: 2,
        table.hline(stroke: 1.5pt),
        table.header([*V (V)*], [*I (mA)*]),
        table.hline(stroke: 0.75pt),
        [0.40], [0],
        [0.45], [0],
        [0.50], [0.3],
        [0.55], [1.0],
        [0.60], [2.0],
        [0.65], [4.1],
        [0.70], [6.3],
        [0.75], [8.5],
        [0.80], [12.4],
        [0.85], [15.5],
        [0.90], [19.1],
        [0.95], [23.3],
        [1.00], [27.8],
        [1.05], [29.4],
        [1.10], [33.5],
        [1.15], [38.0],
        [1.20], [42.9],
        [1.50], [74.5],
        [2.00], [125.0],
        table.hline(stroke: 1.5pt),
      ),
      caption: [Diodo de silicio.],
    ),
    figure(
      table(
        columns: 2,
        table.hline(stroke: 1.5pt),
        table.header([*V (V)*], [*I (mA)*]),
        table.hline(stroke: 0.75pt),
        [0.69], [0.5],
        [1.21], [1.5],
        [1.55], [2.5],
        [1.71], [3.4],
        [1.78], [4.5],
        [1.81], [5.4],
        [1.84], [6.5],
        [1.87], [7.4],
        [1.89], [8.4],
        [1.92], [9.5],
        [1.93], [10.3],
        [1.96], [11.4],
        [1.98], [12.4],
        [2.00], [13.5],
        [2.01], [14.5],
        [2.03], [15.5],
        [2.05], [16.4],
        [2.06], [17.5],
        [2.08], [18.5],
        [2.10], [19.4],
        [2.11], [20.5],
        [2.13], [21.5],
        [2.15], [22.5],
        [2.16], [23.5],
        [2.18], [24.5],
        [2.20], [25.5],
        [2.21], [26.5],
        [2.23], [27.6],
        [2.23], [28.5],
        [2.26], [29.5],
        table.hline(stroke: 1.5pt),
      ),
      caption: [Diodo LED rojo.],
    ),
  )
}

// =============================================
// 8. EXTRA
// =============================================

#pagebreak()

#set par(first-line-indent: 0em)

= Extra: Implementación computacional de los modelos físicos

En esta sección se presentan los fragmentos centrales del código Python desarrollado para el análisis de las curvas características. Se busca mostrar cómo los modelos físicos estudiados se traducen a implementaciones computacionales, y qué conclusiones pueden extraerse de cada uno.

== Modelos físicos implementados

=== Ley de Ohm: resistencia

```python
def modelo_resistencia(V, R):
    """Ley de Ohm: I = V / R."""
    return V / R
```

Este modelo es el más directo: la relación $I = V / R$ predice una curva lineal. Al ajustarlo a los datos experimentales, el único parámetro libre es $R$. El coeficiente $R^2 approx 1$ confirma el comportamiento óhmico del componente y permite extraer la resistencia con su incertidumbre.

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

La ecuación de Shockley ideal $I = I_s (e^(V \/ n V_T) - 1)$ no contempla la resistencia serie $R_s$ del dispositivo, que produce una caída de tensión adicional $V_"diodo" = V - I R_s$. Esta dependencia implícita se resuelve analíticamente mediante la función $W$ de Lambert, que satisface $W(z) e^(W(z)) = z$.

Los tres parámetros ajustados revelan:
- $I_s$ (corriente de saturación inversa): del orden de $10^(-10)$ A para el diodo de silicio, refleja la concentración de portadores minoritarios.
- $n$ (factor de idealidad): valores cercanos a 2 indican que la recombinación en la zona de depleción domina sobre la difusión ($n = 1$).
- $R_s$ (resistencia serie): modela las resistencias de contacto y del material semiconductor fuera de la juntura.

=== Modelo potencial para la lámpara

```python
def modelo_lampara_potencial(V, a, b):
    """Modelo potencial: I = a * V^b (para V > 0)."""
    return a * np.power(np.abs(V), b)
```

La lámpara incandescente presenta una relación $I = a V^b$ con $b < 1$, lo que refleja que la resistencia aumenta con la tensión. El exponente $b$ está relacionado con la dependencia $R(T)$ del tungsteno: si $R prop T^alpha$, entonces $b = 1/(1 + alpha)$. Para tungsteno, $alpha approx 1","2$, lo que predice $b approx 0","45$, consistente con los valores obtenidos experimentalmente.

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

La resistencia dinámica $r = d V \/ d I$ evaluada punto a punto constituye una huella digital de cada componente:
- _Resistencia óhmica:_ $r$ constante en todo el rango.
- _Diodo y LED:_ $r$ decrece exponencialmente con $V$ en la zona de conducción directa.
- _Lámpara:_ $r$ crece con $V$, reflejando el aumento de temperatura del filamento.

El filtro de Savitzky-Golay suaviza el ruido inherente a la derivación numérica de datos discretos.

== Estimación de la temperatura del filamento

```python
def temperatura_filamento(V, I, R0=14.7, T0=295.0, alpha_exp=1.2):
    """T = T0 * (R / R0)^(1 / alpha_exp)"""
    R = np.where(I > 1e-6, V / I, R0)
    T = T0 * np.power(R / R0, 1.0 / alpha_exp)
    return T, R
```

Conociendo la resistencia en frío $R_0 = 14","7 space Omega$ y el exponente de temperatura del tungsteno $alpha approx 1","2$, se puede invertir la relación $R = R_0 (T / T_0)^alpha$:

$ T = T_0 dot (R / R_0)^(1 / alpha) $

Esto permite verificar que la lámpara alcanza temperaturas del orden de 2000--2500 K, muy por debajo del punto de fusión del tungsteno (3695 K).

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

En régimen estacionario, $P = epsilon sigma A T^4$. Tomando logaritmo: $ln(P) = 4 ln(T) + "cte"$. Una pendiente cercana a 4 en el ajuste $ln(P)$ vs $ln(T)$ confirma que la radiación térmica es el mecanismo dominante de disipación.

== Extracción del factor de idealidad

```python
def factor_idealidad(V, I):
    """ln(I) = ln(I_s) + V / (n * V_T)
    Pendiente = 1 / (n * V_T) -> n = 1 / (pendiente * V_T)"""
    mask = I > 1e-6
    resultado = linregress(V[mask], np.log(I[mask]))
    n = 1.0 / (resultado.slope * V_T)
    I_s = np.exp(resultado.intercept)
    return n, I_s, resultado.rvalue**2
```

Al graficar $ln(I)$ vs $V$, la ecuación de Shockley predice una recta con pendiente $1 / (n V_T)$. Este método gráfico permite extraer $n$ de forma independiente al ajuste no lineal, como validación cruzada.

== Energía del gap del LED

```python
def energia_gap_led(V, I):
    """E_g = q * V_th, lambda = h * c / E_g"""
    n_pts = max(3, len(V) // 3)
    resultado = linregress(V[-n_pts:], I[-n_pts:])
    V_th = -resultado.intercept / resultado.slope
    lam_nm = h * c / (q * V_th) * 1e9
    return {"V_th": V_th, "E_g_eV": V_th, "lambda_nm": lam_nm}
```

La tensión umbral $V_"th"$ del LED se relaciona con la energía del gap: $E_g = q V_"th"$, y la longitud de onda emitida: $lambda = h c \/ E_g$. Para un LED rojo se espera $lambda approx 620$--$750$ nm ($V_"th" approx 1","65$--$2","0$ V). La coincidencia entre el valor calculado y el color observado constituye una verificación experimental directa.

== Simulación Monte Carlo

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

Cuando los modelos son no lineales, la propagación analítica de incertidumbres puede ser imprecisa. El método Monte Carlo genera $N = 10000$ conjuntos de datos perturbados con ruido gaussiano proporcional a la incertidumbre instrumental, reajusta el modelo en cada caso, y obtiene distribuciones empíricas de los parámetros. Los percentiles 2,5% y 97,5% definen una banda de confianza del 95%.

== Conclusiones del desarrollo computacional

+ _Validación de modelos:_ El estadístico $chi^2$ reducido permite evaluar cuantitativamente la adecuación de cada modelo a los datos.

+ _Conexión teoría-experimento:_ Cada parámetro ajustado tiene interpretación física directa ($R$, $n$, $I_s$, $b$).

+ _Propagación rigurosa de incertidumbres:_ La simulación Monte Carlo proporciona intervalos de confianza realistas para modelos no lineales.

+ _Medición indirecta de temperatura:_ La curva I(V) de la lámpara permite estimar la temperatura del filamento y verificar la ley de Stefan-Boltzmann.

+ _Determinación del gap semiconductor:_ A partir de la tensión umbral del LED se estima la energía del gap y la longitud de onda de emisión.

== Nota sobre herramientas utilizadas

Para la elaboración de esta sección se consultó a Claude (Anthropic) como herramienta complementaria de referencia. Se utilizó principalmente para contrastar las expresiones de los modelos físicos (ecuación de Shockley, dependencia $R(T)$ del tungsteno, ley de Stefan-Boltzmann) con las formulaciones presentes en la bibliografía, y para verificar la consistencia dimensional de las ecuaciones implementadas.

== Dashboard interactivo

Los gráficos y modelos de esta sección se encuentran disponibles en un dashboard interactivo que permite explorar los ajustes, variar parámetros y visualizar las bandas de confianza de forma dinámica:

#align(center)[
  #text(font: "Courier New", size: 9pt)[https://curvas-caracteristicas.streamlit.app/]
]

// =============================================
// REFERENCIAS
// =============================================

= Referencias

#set enum(numbering: "[1]")

+ S. M. Sze y K. K. Ng, _Physics of Semiconductor Devices_, 3ra ed., Wiley, 2007.

+ JCGM 101:2008, _Evaluation of measurement data -- Supplement 1 to the "Guide to the expression of uncertainty in measurement" -- Propagation of distributions using a Monte Carlo method_.

+ Anthropic, _Claude_ (modelo de lenguaje), 2024--2026. Herramienta de asistencia complementaria para la verificación de modelos físicos.
