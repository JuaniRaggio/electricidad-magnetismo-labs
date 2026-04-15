#set document(
  title: "Circuitos de Corriente Continua",
  author: ("Raggio, J. I.", "Moralejo, C.", "Pipet, M. M.", "Olivero, M.", "Abramzon, J."),
)

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
      columns: (1fr, 1fr, 1fr),
      align: (left, center, right),
      [Juan Ignacio Raggio],
      [],
      [#datetime.today().display("[day]/[month]/[year]")]
    )
    #line(length: 100%, stroke: 0.5pt + gray)
  ],

  footer: context [
    #set text(size: 9pt, fill: gray)
    #line(length: 100%, stroke: 0.5pt + gray)
    #v(0.2em)
    #align(center)[
      Pagina #counter(page).display() / #counter(page).final().first()
    ]
  ]
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

#set list(indent: 1em, marker: ("•", "◦", "▪"))
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
// ====================================
// CARATULA (formato obligatorio de la catedra)
// ====================================

#set page(numbering: none, header: none, footer: none)

#v(1em)

#align(center)[
  #text(size: 13pt)[TRABAJO PRACTICO N° 2]
  #v(0.3em)
  #text(size: 18pt, weight: "bold")[Circuitos de Corriente Continua]
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

// ====================================
// CONTENIDO
// ====================================

#set page(
  numbering: "1",
  header: [
    #set text(size: 9pt, fill: gray)
    #grid(
      columns: (1fr, 1fr),
      align: (left, right),
      [_Circuitos CC -- Fisica III_],
      [_Raggio, Moralejo, Pipet, Olivero, Abramzon_],
    )
    #line(length: 100%, stroke: 0.5pt + gray)
  ],
  footer: context [
    #set text(size: 9pt, fill: gray)
    #line(length: 100%, stroke: 0.5pt + gray)
    #v(0.2em)
    #grid(
      columns: (1fr, 1fr, 1fr),
      align: (left, center, right),
      [_ITBA -- Fisica III_],
      [#counter(page).display("1")],
      [_Abril 2026_],
    )
  ],
)
#counter(page).update(1)

#v(0.5em)



```py
r1 = [

] # => Rojo-Rojo-Marron-Dorado => teorico = 220 ohm, practico = 218 ohm, tolerancia = 5%

r2 = [] # => Naranja-Naranja-Marron-Dorado => teorico = 330 ohm, practico = 325 ohm, tolerancia = 5%

r3 = [] # => Marron-Verde-Marron-Dorado => teorico = 150 ohm, practico = 148 ohm, tolerancia = 5%

r_10Megohms = [] # => teorico = 10 Mohms, practico = 9.72 Mohms

paralelo = []

serie = []
```
// Por que hay que invertir la fuente?
// Hay valor de resis a partir del cual es mejor el largo o el corto?
// Por que esta esta diferencia entre "corto" y "largo"? Cuales son los valores limites
