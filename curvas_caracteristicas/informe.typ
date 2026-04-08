#set document(
  title: "TP 1 - Fisica III",
  author: ("Juan Ignacio Raggio", "Catalina Moralejo", "Milagros Maria Pipet", "", ""),
)

// Comision + Horario

#set page(
  paper: "a4",
  margin: (
    top: 2.5cm,
    bottom: 2.5cm,
    left: 2cm,
    right: 2cm,
  ),
  numbering: "1",
  number-align: bottom + right,

  header: [
    #set text(size: 9pt, fill: gray)
    #grid(
      columns: (1fr, 1fr),
      align: (left, right),
      [Raggio, Moralejo, Pipet, Olivero, Abramzon],
      [#datetime.today().display("[day]/[month]/[year]")]
    )
    #line(length: 100%, stroke: 0.5pt + gray)
  ],

  footer: context [
    #set text(size: 9pt, fill: gray)
    #line(length: 100%, stroke: 0.5pt + gray)
    #v(0.2em)
    #align(center)[
      Page #counter(page).display() of #counter(page).final().first()
    ]
  ]
)

#set text(
  font: "New Computer Modern",
  size: 11pt,
  lang: "en",
  hyphenate: true,
)

#set par(
  justify: true,
  leading: 0.65em,
  first-line-indent: 0em,
  spacing: 1.2em,
)

#set heading(numbering: "1.1")
#show heading.where(level: 1): set text(size: 16pt, weight: "bold")
#show heading.where(level: 2): set text(size: 14pt, weight: "bold")
#show heading.where(level: 3): set text(size: 12pt, weight: "bold")

#show heading: it => {
  v(0.5em)
  it
  v(0.3em)
}

#set list(indent: 1em, marker: ([•], [◦], [▪]))
#set enum(indent: 1em, numbering: "1.a.")

#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
)

#show link: underline

// Helper functions
#let note(content) = {
  block(
    fill: rgb("#E3F2FD"),
    stroke: rgb("#1976D2") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#1976D2"))[Note:] #content
  ]
}

#let important(content) = {
  block(
    fill: rgb("#FFF3E0"),
    stroke: rgb("#F57C00") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#F57C00"))[Important:] #content
  ]
}

#let tip(content) = {
  block(
    fill: rgb("#E8F5E9"),
    stroke: rgb("#388E3C") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#388E3C"))[Tip:] #content
  ]
}

#let warning(content) = {
  block(
    fill: rgb("#FFEBEE"),
    stroke: rgb("#D32F2F") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#D32F2F"))[Warning:] #content
  ]
}

// Cover page
#align(center)[
  #v(2em)
  #image("../assets/ITBAgua.png", width: 40%)
  #v(1em)
  #text(size: 24pt, weight: "bold")[Fisica III - Electricidad y Magnetismo]
  #v(0.5em)
  #text(size: 20pt, weight: "bold")[1er Trabajo Practico]
  #v(0.5em)
  #text(size: 18pt)[Curvas Caracteristicas] \
  #text(size: 14pt, fill: gray)[Comision B - Laboratorio: Miercoles 10am]
  #v(1em)
  #text(size: 12pt)[
    *Authors:* \
    Juan Ignacio Raggio \
    Catalina Moralejo \
    Milagros Maria Pipet \
    Mora Olivero \
    Julieta Abramzon\
  ]
  #v(0.5em)
  #text(size: 12pt, fill: gray)[
    Primer Cuatrimetre 2026 \
    08/04/2026
  ]
  #v(2em)
]

#line(length: 100%, stroke: 1pt)
#v(1em)

#pagebreak()

// Table of contents
#outline(
  title: [Table of Contents],
  indent: auto,
  depth: 3
)

#pagebreak()

= Introduction


== Datos

=== Resistencias

#align(center)[#table(columns: 2)[Tension][Corriente][0.5V][1.5mA][1.1V][3mA][2V][6mA][2.5V][7.5mA][3V][9mA][3.5V][10.6mA][4V][12.1mA][4.5V][13.7mA][5V][15.2mA][5.5V][16.7mA][6V][18.3mA][6.5V][19.8mA][7V][21.4mA][7.5V][22.9mA][8V][24.4mA][8.5V][26mA][9V][27.5mA][9.5V][29mA][10V][30.6mA]]


=== Diodo

// Anoto pipet

#align(center)[#table(columns: 2)[Tension (V)][Corriente (mA)][0.4][0][0.45][0][0.5][0.3][0.55][1][0.6][2][0.65][4.1][0.7][6.3][0.75][8.5][0.8][12.4][0.85][15.5][0.9][19.1][0.95][23.3][1][27.8][1.05][29.4][1.1][33.5][1.15][38][1.2][42.9][1.5][74.5][2][125]]


=== Lampara

#align(center)[#table(columns:2)[Tension (V)][Corriente (mA)][0.5][34][1][41.3][1.5][47.1][2][53.2][2.5][59][3.01][64.9][3.5][70.7][4][75.2][4.5][81][5][85][5.5][90.4][6][94][6.65][100][7][102.5][7.5][107.0][8][110.9][8.5][115][9][118.6][9.4][121.9][10.02][126.233][10.46][129.5][11][133.9][11.6][137.4][12][140.9]]


=== Led (rojo)

#align(center)[#table(columns: 2)[Tension (V)][Corriente mA][2.26][29.5][2.23][28.5][2.23][27.6][2.21][26.5][2.2][25.5][2.18][24.5][2.16][23.5][2.15][22.5][2.13][21.5][2.11][20.5][2.1][19.4][2.08][18.5][2.06][17.5][2.05][16.4][2.03][15.5][2.01][14.5][2][13.5][1.98][12.4][1.96][11.4][1.93][10.3][1.92][9.5][1.89][8.4][1.87][7.4][1.84][6.5][1.81][5.4][1.78][4.5][1.71][3.4][1.55][2.5][1.21][1.5][0.69][0.5]]

#pagebreak()

= Analisis adicional

En esta seccion se proponen analisis complementarios que van mas alla del tratamiento convencional de las curvas caracteristicas.

== Simulacion Monte Carlo de incertidumbres

Cada medicion de tension y corriente posee una incertidumbre asociada al instrumento de medicion. En lugar de propagar errores de forma analitica, se puede emplear un metodo de Monte Carlo: generar miles de conjuntos de datos perturbados dentro del rango de incertidumbre, realizar el ajuste correspondiente sobre cada uno, y obtener distribuciones estadisticas de los parametros resultantes (resistencia $R$, corriente de saturacion $I_s$, factor de idealidad $n$). Esto permite obtener intervalos de confianza mas robustos, especialmente cuando los modelos son no lineales.

== Modelo predictivo con red neuronal

Se propone entrenar una red neuronal sencilla que reciba como entrada el tipo de componente y la tension aplicada, y prediga la corriente resultante. El objetivo es que la red aprenda la fisica subyacente de los cuatro componentes simultaneamente. Una vez entrenada, se puede evaluar su capacidad de interpolacion (valores intermedios no medidos) y extrapolacion (valores fuera del rango medido), comparando sus predicciones con los modelos teoricos conocidos.

== Resistencia dinamica como huella digital

La resistencia dinamica $r = d V \/ d I$ evaluada en cada punto de operacion constituye una firma caracteristica de cada componente. Para la resistencia ohmica, $r$ es constante; para el diodo y el LED, $r$ decrece exponencialmente con la tension; para la lampara, $r$ crece debido al aumento de temperatura del filamento. Graficar $r(V)$ para los cuatro componentes en un mismo plot permite una comparacion visual directa de sus comportamientos.

== Clasificador automatico de componentes

A partir de un conjunto de datos $(V, I)$ de un componente desconocido, se puede construir un clasificador que determine automaticamente si se trata de una resistencia, un diodo, un LED o una lampara. Las features de clasificacion incluyen: grado de linealidad (coeficiente $R^2$ del ajuste lineal), presencia de tension umbral, concavidad de la curva, y rango de variacion de la resistencia dinamica.

== Generacion de datos sinteticos por interpolacion

Mediante ajuste de splines cubicas a cada curva experimental, se pueden generar conjuntos de datos sinteticos con mayor densidad de puntos. Esto permite comparar las curvas medidas con los modelos teoricos a una resolucion superior a la del muestreo original, facilitando la identificacion de desviaciones sistematicas.

== Analisis de histeresis termica en la lampara

Si las mediciones de la lampara se realizaron variando la tension tanto en sentido creciente como decreciente, es posible analizar la presencia de histeresis termica: la inercia del filamento al calentarse y enfriarse produce curvas $I(V)$ distintas segun el sentido de barrido. Este efecto evidencia la dependencia temporal de la resistencia con la temperatura.


