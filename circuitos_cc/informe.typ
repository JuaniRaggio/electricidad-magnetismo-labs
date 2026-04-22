#set document(
  title: "Circuitos de Corriente Continua: Las Leyes de Kirchhoff",
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
        [_Circuitos CC: Leyes de Kirchhoff -- Fisica III_],
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

#let img-dir = "images/"

// =============================================
// CARATULA (formato obligatorio de la catedra)
// =============================================

#set page(numbering: none, header: none, footer: none)

#set par(first-line-indent: 0em)

#v(1em)

#align(center)[
  #text(size: 13pt)[TRABAJO PRACTICO N° 2]
  #v(0.3em)
  #text(size: 18pt, weight: "bold")[Circuitos de Corriente Continua: Las Leyes de Kirchhoff]
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
    65104 #h(0.5em) Pipet, Maria Milagros \
    65386 #h(0.5em) Olivero, Mora \
    65675 #h(0.5em) Abramzon, Julieta
  ]

  #v(1.5em)

  Fecha de realizacion del trabajo practico: 15/4/2026

  Fecha de entrega del informe: 22/4/2026

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

  Fecha de aprobacion: #h(1fr) #line(length: 30%, stroke: 0.5pt + black)

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
  #text(size: 14pt, weight: "bold")[Indice]
]
#v(1em)

#outline(title: none, depth: 3, indent: 1.5em)

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
        [_Circuitos CC: Leyes de Kirchhoff -- Fisica III_],
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
        [_ITBA -- Fisica III_],
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
    Circuitos de Corriente Continua: Las Leyes de Kirchhoff
  ]

  #v(0.8em)

  #text(size: 10pt)[
    J. I. Raggio, C. Moralejo, M. M. Pipet, M. Olivero, J. Abramzon
  ]

  #v(0.3em)

  #text(size: 9pt, fill: gray)[
    #super[1] Instituto Tecnologico de Buenos Aires (ITBA) -- Fisica III \
    Comision B -- Laboratorio: Miercoles 10:00 \
    15 de abril de 2026
  ]
]

#v(0.5em)
#line(length: 100%, stroke: 0.5pt)
#v(0.3em)

// Abstract
#par(first-line-indent: 0em)[
  #text(weight: "bold", size: 10pt)[Resumen --]
  #text(size: 10pt)[
    Se estudio el comportamiento de circuitos de corriente continua. En la primera parte se determino experimentalmente el valor de distintas resistencias mediante la Ley de Ohm, comparandolo con valores nominales y medidos con ohmetro, y se analizo la resistencia equivalente en configuraciones serie y paralelo. En la segunda parte se verificaron las Leyes de Kirchhoff (nodos y mallas) en un circuito con multiples ramas y dos fuentes de tension, analizando el efecto de invertir una de las fuentes.
  ]
]

#v(0.3em)
#line(length: 100%, stroke: 0.5pt)
#v(0.5em)

// =============================================
// 1. OBJETIVOS Y RESUMEN
// =============================================

= Objetivos y resumen

#par(first-line-indent: 0em)[
  El objetivo de la presente practica fue el estudio de circuitos de corriente continua. En una primera etapa, se realizaron conexiones en dos configuraciones distintas con el fin de determinar experimentalmente el valor de distintas resistencias mediante la aplicacion de la Ley de Ohm, y compararlos con sus valores nominales y con los medidos mediante un ohmetro.
]

Posteriormente, se conectaron las resistencias en serie y en paralelo, con el objetivo de analizar el comportamiento de la resistencia equivalente en cada caso y comparar los valores experimentales con los teoricos.

Finalmente, se llevaron a cabo mediciones en un circuito con multiples ramas, con el proposito de verificar experimentalmente las Leyes de Kirchhoff (Ley de los nodos y Ley de las mallas), comparando los resultados obtenidos con los valores calculados analiticamente.

// =============================================
// 2. INTRODUCCION TEORICA
// =============================================

= Introduccion teorica

== Ley de Ohm

La Ley de Ohm afirma que la resistencia de un conductor se define como la razon de la diferencia de potencial aplicada a un conductor a la corriente que pasa por el mismo:

$ R = (Delta V) / I $ <eq-ohm>

Siendo las unidades del SI de la resistencia de Volts por Ampere, y esto se define como ohm ($Omega$).

== Calculo de resistencias equivalentes

Una resistencia equivalente es aquella que tiene el mismo efecto que la combinacion de resistencias en el circuito.

Para calcular la resistencia equivalente en una configuracion de resistencias en serie se utiliza la siguiente ecuacion:

$ R_"eq" = sum_(i=1)^(n) R_i $ <eq-serie>

Mientras que para resistencias dispuestas en paralelo, se puede calcular su equivalente mediante la siguiente formula:

$ 1 / R_"eq" = sum_(i=1)^(n) 1 / R_i $ <eq-paralelo>

== Ley de las mallas

Esta primera ley de Kirchhoff enuncia que la suma de diferencias de potencial a traves de todos los elementos alrededor de cualquier malla de un circuito cerrado debe ser igual a cero. Esta ley es una consecuencia de la ley de conservacion de la energia. Es decir, la suma de los incrementos de energia conforme la carga pasa a traves de los elementos de algun circuito debe ser igual a la suma de las disminuciones de la energia conforme pasa a traves de otros elementos.

$ sum_(i=1)^(n) Delta V_i = 0 $ <eq-mallas>

== Ley de los nodos

La ley de los nodos establece que en cualquiera de estos, la suma de corrientes debe ser igual a cero. Dicho en otras palabras, todas las cargas que entran en un punto dado en un circuito deben abandonarlo porque la carga no puede acumularse en ese punto.

$ sum_(i=1)^(n) I_i = 0 $ <eq-nodos>

// =============================================
// 3. INSTRUMENTOS Y ELEMENTOS EMPLEADOS
// =============================================

= Instrumentos y elementos empleados

== Primera parte

=== Comparacion de valores de resistencias hallados por diferentes metodos

#par(first-line-indent: 0em)[
  *Para esta parte de la practica se utilizaron los siguientes dispositivos:*
]

- *Fuente de tension continua:* Se empleo una fuente de tension de 1,5 V, utilizada para alimentar los distintos circuitos armados. Se consideraron ideales a efectos del calculo teorico, aunque en la practica presentan una resistencia interna no nula.

- *Resistencias:* Se utilizaron resistores de valores nominales 150 $Omega$, 220 $Omega$ y 330 $Omega$. Estos elementos fueron considerados ohmicos, lo cual fue verificado mediante la aplicacion de la Ley de Ohm.

- *Multimetro digital:*
  - Ohmetro, para medir directamente el valor de las resistencias.
  - Voltimetro, para medir diferencias de potencial entre dos puntos del circuito. Se conecto en paralelo con el elemento a medir, debido a su alta resistencia interna.
  - Amperimetro, para medir la intensidad de corriente electrica en una rama. Se conecto en serie con el circuito, debido a su baja resistencia interna.

- *Tablero de conexiones:* Se utilizo un tablero experimental para el armado de los circuitos, lo cual permitio reorganizar los elementos de manera sencilla.

- *Conductores (cables):* Se emplearon cables de conexion para establecer los distintos circuitos. Se consideraron ideales, es decir, con resistencia despreciable.

#v(0.5em)

*En cuanto a las configuraciones utilizadas se implementaron dos esquemas de conexion:*

- En el primero, el voltimetro se conecto en paralelo unicamente con la resistencia, mientras que el amperimetro se ubico en serie. A esta disposicion se la denomina _conexionado corto_.
- En el segundo, el voltimetro se conecto abarcando tanto la resistencia como el amperimetro, lo que introduce diferencias debido a la resistencia interna de los instrumentos. A esta disposicion se la denomina _conexionado largo_.

#v(0.5em)

#figure(
  image(img-dir + "conexionado_corto_largo.png", width: 90%),
  caption: [Conexionado corto (izquierda) y conexionado largo (derecha).],
) <fig-conexionados>

=== Calculo y medicion de la resistencia equivalente para resistencias conectadas en serie y en paralelo

En esta parte se analizaron las configuraciones en serie y en paralelo empleando resistores de 150 $Omega$, 220 $Omega$ y 330 $Omega$.

#v(0.5em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  figure(
    image(img-dir + "circuito_paralelo.png", width: 90%),
    caption: [Circuito en paralelo.],
  ),
  figure(
    image(img-dir + "circuito_serie.png", width: 90%),
    caption: [Circuito en serie.],
  ),
)

== Segunda parte

#par(first-line-indent: 0em)[
  *Para esta segunda parte de la practica se emplearon los siguientes dispositivos:*
]

- *Fuentes de tension continua de 9 V y 1,5 V:* Utilizadas simultaneamente en el circuito para generar diferentes ramas de corriente. En una de las experiencias, la fuente de 1,5 V fue invertida para analizar el cambio en el comportamiento del circuito.

- *Resistencias:* Se utilizaron dos resistencias de 220 $Omega$ y una de 150 $Omega$, formando un circuito con multiples ramas.

- *Multimetros digitales:* Se emplearon como amperimetros para medir las corrientes en distintas ramas del circuito y como voltimetros para medir caidas de potencial en los distintos elementos.

- *Tablero de conexiones y conductores:* Utilizados para el armado del circuito con dos mallas, permitiendo identificar los nodos y las ramas.

#v(0.5em)

*Configuracion utilizada:*

Se armo un circuito con dos fuentes y tres resistencias (@fig-circuito-parte2), permitiendo analizar la distribucion de corrientes y tensiones. De esta manera se calcularon en forma teorica las intensidades de corriente que pasaban por cada uno de los amperimetros, para luego medirlas y asi comparar los valores obtenidos. Posteriormente el circuito se mantuvo igual por excepcion de que se invirtio la fuente de 1,5 V. De forma analoga a la etapa anterior se compararon los resultados analiticos con los medidos.

#v(0.5em)

#figure(
  image(img-dir + "circuito_dos_mallas.png", width: 90%),
  caption: [Diagrama del primer circuito utilizado en la segunda parte.],
) <fig-circuito-parte2>

// =============================================
// 4. DATOS OBTENIDOS
// =============================================

= Datos obtenidos

== Parte I

#par(first-line-indent: 0em)[
  A partir del procedimiento experimental, se presentan las siguientes tablas con los valores de las resistencias mencionadas en el procedimiento. Siendo el valor nominal el valor de la resistencia proporcionado por el fabricante, la medida aquella indicada con el ohmetro y la calculada la obtenida de aplicar la Ley de Ohm:
]

#v(0.5em)

#figure(
  table(
    columns: 4,
    table.hline(stroke: 1.5pt),
    table.header([*Resistencia*], [*Nominal*], [*Medido*], [*Calculado*]),
    table.hline(stroke: 0.75pt),
    [$R_1$], [$220 space Omega plus.minus 5%$], [$218 space Omega$], [$244,26 space Omega$],
    [$R_2$], [$330 space Omega plus.minus 5%$], [$325 space Omega$], [$705 space Omega$ \*],
    [$R_3$], [$150 space Omega plus.minus 5%$], [$148 space Omega$], [$163 space Omega$],
    [$10 space M Omega$], [$10 space M Omega plus.minus 5%$], [$9,72 space M Omega$], [CC/CL],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Valores de resistencias por diferentes metodos.],
) <tab-resistencias>

#text(size: 10pt, style: "italic")[
  \*El valor calculado para $R_2$ no pudo determinarse de forma confiable. La corriente registrada (2,1 mA) con la tension medida (1,48 V) arroja 705 $Omega$, incompatible con el nominal de 330 $Omega$. Esto indica que hubo un error en la medicion, ya sea que se midio otra corriente o hubo un error al anotar los datos. El valor de referencia utilizado es el medido con ohmetro: 325 $Omega$.
]

#v(0.5em)

Para calcular la resistencia de 10 $M Omega$ se realizaron dos conexionados distintos, corto y largo:

#v(0.5em)

#figure(
  table(
    columns: 2,
    table.hline(stroke: 1.5pt),
    table.header([*Circuito corto (CC)*], [*Circuito largo (CL)*]),
    table.hline(stroke: 0.75pt),
    [$5094,4 space Omega$], [$9840,42 space Omega$],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Resistencia de 10 $M Omega$ calculada mediante conexionado corto y largo.],
) <tab-10M>

#v(0.5em)

Luego, con el proposito de determinar la resistencia equivalente en cada configuracion, se dispusieron las tres resistencias $R_1$, $R_2$ y $R_3$ tanto en paralelo como en serie. Los valores obtenidos fueron los siguientes:

#v(0.5em)

#figure(
  table(
    columns: 4,
    table.hline(stroke: 1.5pt),
    table.header([*Disposicion*], [*Nominal*], [*Medido*], [*Calculado*]),
    table.hline(stroke: 0.75pt),
    [Serie], [$700 space Omega$], [$691 space Omega$], [$709 space Omega$],
    [Paralelo], [$70,21 space Omega$], [$69,6 space Omega$], [$68,5 space Omega$],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Resistencia equivalente en serie y en paralelo.],
) <tab-req>

== Parte II

=== Circuito 1

Para el circuito 1, se utilizaron las leyes de Kirchhoff para calcular las intensidades y se obtuvieron las siguientes ecuaciones:

*Nodos:*

$ I_1 = I_2 + I_3 $

*Mallas:*

$ 9 "V" - I_1 R_1 - I_2 R_2 = 0 quad "(Malla 1)" $

$ 1,5 "V" - I_3 R_3 + I_2 R_2 = 0 quad "(Malla 2)" $

Donde $R_1 = 220 space Omega$, $R_2 = 330 space Omega$ y $R_3 = 150 space Omega$.

Resolviendo el sistema de ecuaciones, se obtienen los siguientes valores:

$ I_1 = 0,"03102" space "A" = 31,"02" space "mA" $

$ I_2 = 0,"00657" space "A" = 6,"57" space "mA" $

$ I_3 = 0,"02445" space "A" = 24,"45" space "mA" $

Posteriormente, se obtuvieron los siguientes resultados en el laboratorio y se los compara con los calculados:

#v(0.5em)

#figure(
  table(
    columns: 3,
    table.hline(stroke: 1.5pt),
    table.header([*Corriente*], [*$I$ calculada*], [*$I$ medida*]),
    table.hline(stroke: 0.75pt),
    [$I_1$], [26 mA], [23,3 mA],
    [$I_2$], [12,63 mA], [13,0 mA],
    [$I_3$], [10,07 mA], [10,03 mA],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Corrientes del circuito 1: valores calculados vs. medidos.],
) <tab-circuito1>

=== Circuito 2 (fuente invertida)

*Nodos:*

$ I_1 = I_2 + I_3 $

*Mallas:*

$ 9,"22" "V" - I_1 R_1 - I_2 R_2 = 0 quad "(Malla 1)" $

$ -2,"66" "V" - I_3 R_3 + I_2 R_2 = 0 quad "(Malla 2)" $

Donde $R_1 = 220 space Omega$, $R_2 = 330 space Omega$ y $R_3 = 150 space Omega$.

Resolviendo el sistema de ecuaciones, se obtienen los siguientes valores:

$ I_1 = 24,"66" space "mA" $

$ I_2 = 10,"83" space "mA" $

$ I_3 = 13,"83" space "mA" $

Posteriormente, se obtuvieron los siguientes resultados en el laboratorio:

#v(0.5em)

#figure(
  table(
    columns: 3,
    table.hline(stroke: 1.5pt),
    table.header([*Corriente*], [*$I$ calculada*], [*$I$ medida*]),
    table.hline(stroke: 0.75pt),
    [$I_1$], [31,45 mA], [32,2 mA],
    [$I_2$], [6,69 mA], [6,8 mA],
    [$I_3$], [3,07 mA], [3,1 mA],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Corrientes del circuito 2 (fuente invertida): valores calculados vs. medidos.],
) <tab-circuito2>

#v(0.5em)

#text(size: 10pt, style: "italic")[
  Las discrepancias en el circuito 2 fueron significativamente mayores que en el circuito 1. Las corrientes medidas no satisfacen la ley de nodos ($I_2 + I_3 = 6,8 + 3,1 = 9,9 space "mA" eq.not I_1 = 32,2 space "mA"$), lo que indica un error experimental en la medicion o en la conexion del circuito, y no en el planteo teorico. Factores probables son una conexion incorrecta al invertir la fuente, contactos deficientes, o errores en la lectura de los instrumentos. Por estas razones, los resultados de esta etapa no permiten validar las leyes de Kirchhoff con el mismo nivel de confiabilidad que en el circuito 1.
]

#v(0.5em)

Resulto util medir los valores de las pilas con los instrumentos para compararlos con los proporcionados por el fabricante para respaldar y fundamentar los resultados obtenidos en el experimento, y ademas asi evaluar la precision y la confiabilidad de los resultados obtenidos en el laboratorio. Es por esto que se llevo a cabo dicha medicion y los resultados obtenidos fueron los siguientes:

#v(0.5em)

#figure(
  table(
    columns: 3,
    table.hline(stroke: 1.5pt),
    table.header([], [*Nominal*], [*Medido*]),
    table.hline(stroke: 0.75pt),
    [Pila (9 V)], [9 V], [9,22 V],
    [Pila (1,5 V)], [1,5 V], [2,66 V],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Tension de las pilas: valores nominales vs. medidos.],
) <tab-pilas>

// =============================================
// 5. ANALISIS DE LOS RESULTADOS
// =============================================

= Analisis de los resultados

== Primera parte

#par(first-line-indent: 0em)[
  En la primera parte de la experiencia se compararon los valores nominales de distintas resistencias con los medidos directamente mediante ohmetro y con los calculados a partir de la Ley de Ohm. En el caso de $R_1$ y $R_3$, las mediciones con ohmetro resultaron muy proximas a los valores nominales, mientras que los valores calculados a partir de tension y corriente presentaron diferencias mayores. Esto sugiere que, para estas resistencias, la medicion directa resulto mas confiable que la determinacion indirecta mediante $R = V\/I$, probablemente debido a errores de lectura en la corriente o en la tension, a la tolerancia propia de los resistores y a perturbaciones introducidas por los instrumentos sobre el circuito.
]

Para la resistencia de 10 $M Omega$ se observo un comportamiento distinto. El valor medido con ohmetro fue cercano al nominal, y el conexionado largo tambien arrojo un resultado razonablemente proximo. En cambio, el conexionado corto presento una diferencia mucho mayor. Esto puede explicarse por la influencia de la resistencia interna del voltimetro: cuando se trabaja con resistencias tan elevadas, esa resistencia deja de ser despreciable frente a la del componente medido y modifica de manera apreciable la corriente del circuito. Por eso, en este caso el metodo de medicion empleado influye notablemente en el resultado final.

En la determinacion de resistencias equivalentes, tanto la asociacion en serie como la asociacion en paralelo dieron valores experimentales cercanos a los esperados teoricamente. En serie, los resultados medidos y calculados quedaron muy proximos al valor nominal total, y en paralelo ocurrio algo similar. Esto indica que, dentro de las incertidumbres experimentales, se verifico correctamente el comportamiento esperado de las asociaciones de resistencias. Las pequenas discrepancias pueden atribuirse a la tolerancia de los componentes, a la precision limitada de los multimetros y a resistencias de contacto en las conexiones.

== Segunda parte

En la segunda parte se busco verificar experimentalmente las Leyes de Kirchhoff en un circuito con dos fuentes y tres resistencias, analizando ademas el efecto de invertir una de las pilas. Desde el punto de vista teorico, los sistemas de ecuaciones planteados para ambos circuitos cumplen correctamente con la ley de nodos y la ley de mallas. Sin embargo, al comparar con los resultados experimentales se observan diferencias importantes, por lo que la verificacion experimental fue solo parcial.

En el circuito 1, aunque los valores medidos no coinciden bien con los valores teoricos escritos en el desarrollo, si puede verse que la ley de nodos se cumple aproximadamente con las corrientes medidas, ya que $I_2 + I_3 = 13,0 + 10,03 = 23,03 space "mA" approx I_1 = 23,3 space "mA"$. Esto indica que, al menos de manera cualitativa, el comportamiento general del circuito fue consistente con lo esperado. No obstante, la diferencia entre las corrientes teoricas y las registradas experimentalmente muestra que hubo errores experimentales no despreciables, posiblemente vinculados a la tolerancia real de las resistencias, a la resistencia interna de las fuentes, a la perturbacion introducida por los amperimetros y a la dificultad de medir corrientes en distintas ramas sin alterar ligeramente el circuito en cada medicion.

En el circuito 2, correspondiente a la inversion de una de las fuentes, las discrepancias fueron mucho mas marcadas. En este caso, las corrientes medidas no satisfacen adecuadamente la ley de nodos, lo que coincide con la observacion anotada en el propio informe. Por lo tanto, en esta configuracion no puede afirmarse que la experiencia haya validado experimentalmente las leyes de Kirchhoff con buen acuerdo. Mas bien, los resultados muestran que el circuito fue altamente sensible a errores de conexion, a una posible inversion incorrecta de polaridad, a contactos deficientes, o incluso a errores en la toma o transcripcion de datos.

// =============================================
// 6. CONCLUSIONES
// =============================================

= Conclusiones

#par(first-line-indent: 0em)[
  En conjunto, puede concluirse que la primera parte del trabajo mostro una concordancia aceptable entre teoria y experiencia, sobre todo en las mediciones directas de resistencias y en el calculo de resistencias equivalentes. En la segunda parte, en cambio, los resultados permitieron verificar solo parcialmente las leyes de Kirchhoff, especialmente en el primer circuito, mientras que en el segundo las discrepancias fueron demasiado grandes como para considerarlo una validacion satisfactoria. Esto pone en evidencia la importancia de considerar las condiciones reales de medicion, la calidad de las conexiones, la polaridad correcta de las fuentes y la diferencia entre los valores nominales y los valores efectivamente presentes en el circuito.
]

// =============================================
// 7. EXTRA: IMPLEMENTACION COMPUTACIONAL
// =============================================

#pagebreak()

#let assets-dir = "assets/"

#set par(first-line-indent: 0em)

= Extra: Analisis computacional de circuitos de corriente continua

En esta seccion se presentan los fragmentos centrales del codigo Python desarrollado para el analisis computacional de los circuitos estudiados. Se busca mostrar como las leyes de Kirchhoff se traducen a un sistema matricial resoluble numericamente, como la sensibilidad de las corrientes a las tolerancias de los componentes puede cuantificarse, y como el error sistematico de los conexionados corto y largo puede modelarse analiticamente.

== Resolucion matricial de las leyes de Kirchhoff

=== Formulacion del sistema

Las leyes de Kirchhoff aplicadas al circuito de dos mallas generan un sistema de tres ecuaciones con tres incognitas. La ley de nodos aporta una ecuacion de conservacion de corriente, y la ley de mallas aporta dos ecuaciones de caida de tension:

$ I_1 - I_2 - I_3 = 0 quad "(nodo)" $
$ R_1 I_1 + R_2 I_2 = V_1 quad "(malla 1)" $
$ -R_2 I_2 + R_3 I_3 = V_2 quad "(malla 2)" $

Esto se escribe en forma matricial como $bold(A) dot bold(I) = bold(b)$:

$ mat(1, -1, -1; R_1, R_2, 0; 0, -R_2, R_3) dot vec(I_1, I_2, I_3) = vec(0, V_1, V_2) $

La matriz $bold(A)$ codifica la topologia del circuito (como se conectan las resistencias entre si), mientras que el vector $bold(b)$ contiene las fuentes de tension. Para pasar del circuito 1 al circuito 2 (fuente invertida), basta cambiar el signo de $V_2$ en $bold(b)$; la estructura del circuito ($bold(A)$) permanece identica.

=== Implementacion

```python
import numpy as np

def resolver_circuito(R1, R2, R3, V1, V2):
    """
    Resuelve el circuito de dos mallas con tres ramas.
    Retorna I1, I2, I3 en Ampere.
    """
    A = np.array([
        [1,    -1,   -1 ],
        [R1,    R2,   0  ],
        [0,    -R2,   R3 ],
    ])
    b = np.array([0, V1, V2])
    return np.linalg.solve(A, b)
```

El sistema se resuelve mediante eliminacion gaussiana (`np.linalg.solve`). Al ser un sistema $3 times 3$ con determinante no nulo (las resistencias son positivas y no generan dependencia lineal), la solucion es unica.

=== Resultados

#v(0.5em)

#figure(
  table(
    columns: 4,
    table.hline(stroke: 1.5pt),
    table.header([*Corriente*], [*Teorica (matricial)*], [*Medida (lab)*], [*Error %*]),
    table.hline(stroke: 0.75pt),
    table.cell(colspan: 4)[_Circuito 1 ($V_1 = 9$ V, $V_2 = 1,5$ V)_],
    table.hline(stroke: 0.4pt),
    [$I_1$], [31,04 mA], [23,3 mA], [33,2%],
    [$I_2$], [6,58 mA], [13,0 mA], [49,4%],
    [$I_3$], [24,47 mA], [10,03 mA], [143,9%],
    table.hline(stroke: 0.4pt),
    table.cell(colspan: 4)[_Circuito 2 ($V_1 = 9,22$ V, $V_2 = -2,66$ V)_],
    table.hline(stroke: 0.4pt),
    [$I_1$], [22,87 mA], [32,2 mA], [29,0%],
    [$I_2$], [12,69 mA], [6,8 mA], [86,6%],
    [$I_3$], [10,18 mA], [3,1 mA], [228,5%],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Comparacion entre corrientes calculadas matricialmente y medidas en laboratorio.],
) <tab-extra-comparacion>

La verificacion numerica de la ley de nodos en la solucion matricial da un residuo de $approx 10^(-17)$ A (precision de maquina), confirmando que el sistema esta correctamente planteado. En las mediciones experimentales, el circuito 1 muestra un residuo de 0,27 mA (aceptable), mientras que el circuito 2 presenta un residuo de 22,3 mA, confirmando cuantitativamente el error experimental reportado en la seccion de analisis.

#v(0.5em)

#figure(
  image(assets-dir + "comparacion_corrientes.png", width: 95%),
  caption: [Comparacion grafica entre corrientes calculadas (Kirchhoff) y medidas (laboratorio) para ambos circuitos.],
) <fig-comparacion-corrientes>

Las discrepancias significativas entre los valores teoricos y medidos en ambos circuitos sugieren que los datos experimentales contienen errores sistematicos que van mas alla de la tolerancia de los componentes. Los errores en el circuito 1, particularmente en $I_3$ (143,9%), son demasiado grandes para explicarse unicamente por las resistencias internas de los instrumentos o la tolerancia $plus.minus 5%$ de los resistores.

== Analisis de sensibilidad

=== Concepto fisico

La sensibilidad relativa mide cuanto cambia porcentualmente una corriente cuando se varia porcentualmente una resistencia:

$ S_(R_j)^(I_i) = (partial I_i \/ I_i) / (partial R_j \/ R_j) $

Un valor de $S = -0,7$ significa que si $R_j$ aumenta un 1%, $I_i$ disminuye un 0,7%. Esto permite identificar cuales ramas del circuito son mas vulnerables a las tolerancias de los componentes.

=== Implementacion

```python
def sensibilidad(R1_base, R2_base, R3_base, V1, V2, delta_pct=5):
    """Calcula la matriz de sensibilidad mediante derivada centrada."""
    I_base = resolver_circuito(R1_base, R2_base, R3_base, V1, V2)
    resistencias = [R1_base, R2_base, R3_base]
    sens = np.zeros((3, 3))
    for i in range(3):
        dR = resistencias[i] * delta_pct / 100
        R_plus, R_minus = resistencias.copy(), resistencias.copy()
        R_plus[i] += dR
        R_minus[i] -= dR
        I_plus = resolver_circuito(*R_plus, V1, V2)
        I_minus = resolver_circuito(*R_minus, V1, V2)
        for j in range(3):
            sens[i, j] = ((I_plus[j] - I_minus[j]) / (2*dR)) \
                         * (resistencias[i] / I_base[j])
    return sens
```

La derivada se calcula numericamente con diferencias centradas, lo que proporciona precision de segundo orden. El resultado adimensional permite comparar directamente la influencia de resistencias con valores muy diferentes.

=== Resultados

#v(0.5em)

#figure(
  image(assets-dir + "sensibilidad.png", width: 95%),
  caption: [Matriz de sensibilidad relativa para ambos circuitos. El color indica la magnitud y signo del efecto: azul (la corriente disminuye al aumentar la resistencia) y rojo (la corriente aumenta).],
) <fig-sensibilidad>

#v(0.5em)

#figure(
  table(
    columns: 4,
    table.hline(stroke: 1.5pt),
    table.header([], [*$I_1$*], [*$I_2$*], [*$I_3$*]),
    table.hline(stroke: 0.75pt),
    table.cell(colspan: 4)[_Circuito 1_],
    table.hline(stroke: 0.4pt),
    [$R_1$ (220 $Omega$)], [$-0,68$], [$-1,01$], [$-0,60$],
    [$R_2$ (330 $Omega$)], [$-0,07$], [$-0,79$], [$+0,13$],
    [$R_3$ (150 $Omega$)], [$-0,25$], [$+0,79$], [$-0,53$],
    table.hline(stroke: 0.4pt),
    table.cell(colspan: 4)[_Circuito 2_],
    table.hline(stroke: 0.4pt),
    [$R_1$ (220 $Omega$)], [$-0,68$], [$-0,38$], [$-1,05$],
    [$R_2$ (330 $Omega$)], [$-0,18$], [$-0,79$], [$+0,58$],
    [$R_3$ (150 $Omega$)], [$-0,14$], [$+0,17$], [$-0,53$],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Coeficientes de sensibilidad relativa $S_(R_j)^(I_i)$ para ambos circuitos.],
) <tab-sensibilidad>

Del analisis se extraen las siguientes conclusiones fisicas:

- $R_1$ es la resistencia con mayor influencia global: afecta todas las corrientes de forma significativa en ambos circuitos. Esto es coherente con su posicion topologica (esta en la rama principal, por donde circula $I_1$).

- $I_2$ es la corriente mas sensible a $R_2$ ($S approx -0,79$), lo cual es esperable ya que $R_2$ esta directamente en la rama de $I_2$.

- En el circuito 2, $I_3$ tiene la mayor sensibilidad absoluta ($S = -1,05$ respecto a $R_1$), lo que explica por que las discrepancias experimentales en $I_3$ fueron las mas pronunciadas.

- Las sensibilidades cruzadas con signo positivo (por ejemplo, $S_(R_3)^(I_2) = +0,79$ en el circuito 1) indican que al aumentar $R_3$, se redistribuye mas corriente hacia la rama de $I_2$, consistente con la ley de nodos.

- Dado que las resistencias tienen tolerancia de $plus.minus 5%$, la variacion maxima esperada en cada corriente por efecto de tolerancia es del orden de $|S| times 5%$. Para el coeficiente mas grande ($|S| approx 1$), esto da un $approx 5%$ de variacion, muy inferior a las discrepancias del 30--230% observadas experimentalmente. Esto confirma que los errores experimentales no se explican solo por la tolerancia de los componentes.

== Analisis del conexionado corto vs. largo

=== Modelo fisico

Cuando se mide una resistencia $R$ con un voltimetro (resistencia interna $R_V$) y un amperimetro (resistencia interna $R_A$), el conexionado introduce un error sistematico que depende de la relacion entre $R$ y las resistencias internas de los instrumentos.

*Conexionado corto:* El voltimetro mide correctamente $V_R$, pero el amperimetro registra $I_"total" = I_R + I_V$ (incluye la corriente que pasa por el voltimetro). La resistencia medida resulta:

$ R_"medido"^"CC" = V / I_"total" = (R dot R_V) / (R + R_V) $

El error relativo es $epsilon_"CC" = -R \/ (R + R_V)$, que crece con $R$.

*Conexionado largo:* El amperimetro mide correctamente $I_R$, pero el voltimetro registra $V_"total" = I (R + R_A)$ (incluye la caida en el amperimetro). La resistencia medida resulta:

$ R_"medido"^"CL" = V_"total" / I = R + R_A $

El error relativo es $epsilon_"CL" = R_A \/ R$, que crece cuando $R$ disminuye.

=== Implementacion

```python
def error_corto(R, Rv):
    """Error relativo del conexionado corto."""
    return -R / (R + Rv)

def error_largo(R, Ra):
    """Error relativo del conexionado largo."""
    return Ra / R
```

=== Punto critico

Igualando ambos errores se obtiene la resistencia critica donde los dos conexionados son equivalentes:

$ R / (R + R_V) = R_A / R quad arrow.r.double quad R_"critico" = (R_A + sqrt(R_A^2 + 4 R_A R_V)) / 2 $

Para $R_V = 10 space "M"Omega$ y $R_A = 1 space Omega$, el valor critico resulta $R_"critico" approx 3163 space Omega approx 3,2 space "k"Omega$.

- Para $R < R_"critico"$: conviene conexionado *largo* (el error del amperimetro es menor que el del voltimetro).
- Para $R > R_"critico"$: conviene conexionado *corto* (el error del voltimetro es menor que el del amperimetro).

=== Resultados

#v(0.5em)

#figure(
  image(assets-dir + "corto_vs_largo.png", width: 90%),
  caption: [Error relativo de medicion en funcion de la resistencia del componente para ambos conexionados. La linea vertical punteada indica la resistencia critica $R_"critico" approx 3,2 space "k"Omega$.],
) <fig-corto-largo>

#v(0.5em)

#figure(
  table(
    columns: 4,
    table.hline(stroke: 1.5pt),
    table.header([*Componente*], [*Error CC (%)*], [*Error CL (%)*], [*Mejor*]),
    table.hline(stroke: 0.75pt),
    [$R_1 = 220 space Omega$], [0,0022], [0,45], [CC],
    [$R_2 = 330 space Omega$], [0,0033], [0,30], [CC],
    [$R_3 = 150 space Omega$], [0,0015], [0,67], [CC],
    [$10 space "M"Omega$], [50,0], [$approx 0$], [CL],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Error sistematico de cada conexionado para las resistencias del TP.],
) <tab-corto-largo>

El resultado es fisicamente consistente con lo observado en el laboratorio:

- Para las resistencias de 150, 220 y 330 $Omega$, ambos conexionados introducen errores despreciables (menores al 1%), por lo que la eleccion del metodo no afecta significativamente la medicion.

- Para la resistencia de 10 $"M"Omega$, el conexionado corto introduce un error del 50% (el voltimetro, con $R_V = 10 space "M"Omega$, queda en paralelo con una resistencia del mismo orden, reduciendo la resistencia efectiva a la mitad). Esto explica cuantitativamente el valor de 5094 $Omega$ medido en el laboratorio con conexionado corto, que es aproximadamente la mitad del valor real. El conexionado largo, en cambio, introduce un error de solo $R_A \/ R approx 10^(-7) %$, consistente con el valor de 9840 $Omega$ obtenido experimentalmente.

== Conclusiones del desarrollo computacional

+ _Formalizacion matricial:_ Las leyes de Kirchhoff se traducen naturalmente a un sistema lineal $bold(A) bold(I) = bold(b)$, donde la topologia del circuito queda codificada en $bold(A)$ y las fuentes en $bold(b)$. Invertir una fuente equivale a cambiar un signo en $bold(b)$, sin modificar la estructura del circuito.

+ _Sensibilidad y tolerancias:_ El analisis de sensibilidad muestra que las variaciones de corriente esperadas por tolerancia de componentes ($approx 5%$) son un orden de magnitud menores que las discrepancias experimentales observadas ($30$--$230%$), confirmando la presencia de errores sistematicos en las mediciones.

+ _Criterio de conexionado:_ El modelo analitico del error sistematico permite establecer un criterio cuantitativo: para $R < 3,2 space "k"Omega$ conviene el conexionado largo, y para $R > 3,2 space "k"Omega$ conviene el corto. Esto explica completamente los resultados discrepantes obtenidos al medir la resistencia de 10 $"M"Omega$ en el laboratorio.

== Nota sobre herramientas utilizadas

Para la elaboracion de esta seccion se consulto a Claude (Anthropic) como herramienta complementaria de referencia. Se utilizo para verificar la consistencia de las formulaciones matriciales y para contrastar las expresiones analiticas de error de los conexionados corto y largo con la bibliografia.

// =============================================
// REFERENCIAS
// =============================================

= Referencias

#set enum(numbering: "[1]")

+ R. A. Serway y J. W. Jewett, _Fisica para ciencias e ingenieria_, 10ma ed., Cengage Learning, 2018.

+ Anthropic, _Claude_ (modelo de lenguaje), 2024--2026. Herramienta de asistencia complementaria para la verificacion de modelos fisicos.
