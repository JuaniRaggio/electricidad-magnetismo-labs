#set document(
  title: "Desarrollo Computacional: Modelos y Dashboard Interactivo",
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
        [_Desarrollo Computacional -- Fisica III_],
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

#set table(
  stroke: none,
  inset: 6pt,
  align: center,
)
#show table: set text(size: 10pt)

#show figure.caption: it => {
  set text(size: 9.5pt)
  it
}

#show raw.where(block: true): block.with(
  fill: luma(245),
  inset: 8pt,
  radius: 3pt,
  width: 100%,
)
#show raw.where(block: true): set text(size: 9pt)

// =============================================
// PORTADA
// =============================================

#align(center)[
  #text(size: 16pt, weight: "bold")[
    Desarrollo Computacional: Modelos y Dashboard Interactivo
  ]

  #v(0.5em)

  #text(size: 12pt)[
    TP1 -- Curvas Caracteristicas I(V)
  ]

  #v(1em)

  #text(size: 10pt)[
    J. I. Raggio, C. Moralejo, M. M. Pipet, M. Olivero, J. Abramzon
  ]

  #v(0.3em)

  #text(size: 9pt, fill: gray)[
    Instituto Tecnologico de Buenos Aires (ITBA) -- Fisica III \
    Comision B -- Abril 2026
  ]
]

#v(0.5em)
#line(length: 100%, stroke: 0.5pt)
#v(0.3em)

#par(first-line-indent: 0em)[
  #text(weight: "bold", size: 10pt)[Resumen --]
  #text(size: 10pt)[
    Este documento complementa el informe principal del TP1, detallando el desarrollo computacional realizado para analizar las curvas caracteristicas I(V). Se describen los modelos fisicos implementados, los analisis complementarios (resistencia dinamica, temperatura del filamento, factor de idealidad, energia del gap), la simulacion Monte Carlo para propagacion de incertidumbres y la arquitectura del dashboard interactivo desplegado en Streamlit.
  ]
]

#v(0.3em)
#line(length: 100%, stroke: 0.5pt)
#v(0.5em)

// =============================================
// 1. INTRODUCCION
// =============================================

= Introduccion

#par(first-line-indent: 0em)[
  El informe principal del TP1 presenta las curvas caracteristicas I(V) de cuatro componentes (resistencia, lampara, diodo, LED) con un analisis predominantemente cualitativo. En esta seccion complementaria se busca ir mas alla: traducir cada modelo fisico a una implementacion computacional, ajustar parametros cuantitativamente y propagar incertidumbres de forma rigurosa.
]

Las herramientas utilizadas son:

- *Python 3.14* como lenguaje base.
- *NumPy* para calculo numerico vectorizado.
- *SciPy* para optimizacion (`curve_fit`), funciones especiales (`lambertw`), filtros (`savgol_filter`) y regresion (`linregress`).
- *Matplotlib* para graficos estaticos.
- *Streamlit* y *Plotly* para el dashboard interactivo.

El documento se organiza en tres bloques: (i) los modelos fisicos y su implementacion, (ii) los analisis complementarios derivados de los ajustes y (iii) la simulacion Monte Carlo y el dashboard interactivo.

// =============================================
// 2. MODELOS FISICOS IMPLEMENTADOS
// =============================================

= Modelos fisicos implementados

== Ley de Ohm (resistencia)

El modelo mas directo es la ley de Ohm:

$ I = V / R $ <eq-ohm>

donde $R$ es el unico parametro libre. El ajuste lineal por minimos cuadrados se reduce a estimar la pendiente $m = 1 \/ R$ de la recta $I(V)$. La bondad del ajuste se cuantifica con el coeficiente de determinacion:

$ R^2 = 1 - (S S_"res") / (S S_"tot") = 1 - (sum (I_i - hat(I)_i)^2) / (sum (I_i - overline(I))^2) $ <eq-r2>

Un valor $R^2 approx 1$ confirma comportamiento ohmico. Para nuestros datos experimentales se obtuvo $R = 325 space Omega$ con $R^2 = 0","9999$, consistente con el valor nominal de $330 space Omega$ (error del 1,52%).

== Ecuacion de Shockley con resistencia serie (diodo y LED)

=== Modelo ideal

La corriente a traves de una juntura PN en polarizacion directa sigue la ecuacion de Shockley:

$ I = I_s (e^(V \/ (n V_T)) - 1) $ <eq-shockley-ideal>

donde $I_s$ es la corriente de saturacion inversa, $n$ el factor de idealidad y $V_T = k_B T \/ q approx 25","4$ mV la tension termica a temperatura ambiente.

=== Inclusion de la resistencia serie

Un diodo real presenta una resistencia serie $R_s$ que agrupa las resistencias de contacto y del semiconductor fuera de la juntura. La tension sobre la juntura es $V_j = V - I R_s$, y la ecuacion se convierte en:

$ I = I_s (e^((V - I R_s) \/ (n V_T)) - 1) $ <eq-shockley-rs>

El problema es que $I$ aparece en ambos miembros. Para corrientes en directa donde $e^(...) >> 1$, se puede despreciar el $-1$ y manipular algebraicamente la ecuacion hasta obtener una expresion de la forma $z e^z = (...)$. La solucion analitica involucra la funcion $W$ de Lambert, definida implicitamente por:

$ W(z) e^(W(z)) = z $ <eq-lambert-def>

La corriente explicita resulta:

$ I = (n V_T) / R_s dot W lr((I_s R_s) / (n V_T) dot e^(V \/ (n V_T))) $ <eq-shockley-lambert>

Esta expresion permite evaluar $I(V)$ directamente y utilizarla en un ajuste por minimos cuadrados no lineal (`curve_fit` de SciPy), con la funcion `lambertw` de `scipy.special`.

=== Significado fisico de los parametros

Los tres parametros ajustados tienen interpretacion directa:

- *$I_s$ (corriente de saturacion inversa):* del orden de $10^(-10)$ A para silicio. Refleja la concentracion de portadores minoritarios en la juntura. Cuanto menor $I_s$, mayor la calidad del diodo.

- *$n$ (factor de idealidad):* valores entre 1 y 2. Si $n approx 1$, domina la difusion de portadores (caso ideal); si $n approx 2$, domina la recombinacion en la zona de deplecion. En la practica, $n$ se situa entre ambos extremos.

- *$R_s$ (resistencia serie):* en ohmios. A corrientes altas, $I R_s$ es significativo y la curva se aparta de la exponencial pura, adoptando un crecimiento casi lineal.

== Modelo potencial (lampara de filamento)

La lampara incandescente no puede modelarse con un simple $I = V \/ R$ porque su resistividad depende de la temperatura. Para tungsteno, la resistividad sigue una ley de potencias:

$ R(T) = R_0 lr((T) / (T_0))^alpha $ <eq-R-T>

con $alpha approx 1","2$. En equilibrio termico, la potencia electrica disipada ($P = V^2 \/ R$) se irradia como calor. Combinando estas relaciones se llega a un modelo de la forma:

$ I = a dot V^b $ <eq-potencial>

donde $b = 1 \/ (1 + alpha)$. Para tungsteno con $alpha = 1","2$, se predice $b_"teorico" = 1 \/ 2","2 approx 0","45$. El exponente $b < 1$ refleja que la corriente crece mas lento que linealmente, evidenciando el aumento de resistencia con la temperatura.

Del exponente ajustado se puede estimar el coeficiente de temperatura:

$ alpha_"est" = 1 / b - 1 $ <eq-alpha-est>

lo que proporciona una verificacion experimental independiente del valor tabulado para tungsteno.

// =============================================
// 3. ANALISIS COMPLEMENTARIOS
// =============================================

= Analisis complementarios

== Resistencia dinamica

La resistencia _dinamica_ o _diferencial_ se define como:

$ r(V) = (d V) / (d I) $ <eq-r-din>

A diferencia de la resistencia estatica $R = V \/ I$, que es un promedio global, $r$ mide la respuesta local del componente: cuanto cambia la tension ante un incremento infinitesimal de corriente.

Computacionalmente, la derivada se estima con `np.gradient` sobre los datos discretos. Sin embargo, la derivacion numerica amplifica el ruido de medicion. Para suavizar la senal se aplica el filtro de Savitzky-Golay, que ajusta un polinomio local (de grado 2) a una ventana deslizante de puntos y evalua la funcion (o su derivada) en el centro de la ventana. Esto preserva los rasgos de la curva original sin introducir el desfasaje de un filtro de media movil convencional.

La resistencia dinamica tiene un comportamiento distintivo para cada componente:

- *Resistencia ohmica:* $r$ es constante e igual a $R$ en todo el rango.
- *Lampara:* $r$ crece con $V$, reflejando el aumento de la resistividad con la temperatura.
- *Diodo y LED:* $r$ decrece con $V$ en la zona de conduccion directa; un pequeno aumento de tension produce un gran incremento de corriente.

== Temperatura del filamento

Conociendo la resistencia en frio $R_0 = 14","7 space Omega$ (calculada como $V_0 \/ I_0$ en el primer punto de medicion, donde la potencia disipada es minima) y el exponente $alpha = 1","2$, se invierte la @eq-R-T:

$ T = T_0 dot lr((R) / (R_0))^(1 \/ alpha) $ <eq-T-inv>

donde $R = V \/ I$ se calcula para cada punto experimental. Las temperaturas resultantes oscilan entre $T_"amb"$ y aproximadamente 2000--2500 K, muy por debajo del punto de fusion del tungsteno (3695 K).

== Verificacion de la ley de Stefan-Boltzmann

En regimen estacionario, la potencia electrica disipada iguala la potencia radiada:

$ P = epsilon sigma A T^4 $ <eq-stefan>

donde $epsilon$ es la emisividad, $sigma$ la constante de Stefan-Boltzmann y $A$ el area del filamento. Tomando logaritmo:

$ ln(P) = 4 ln(T) + "cte" $ <eq-stefan-log>

Un ajuste lineal de $ln(P)$ vs $ln(T)$ con pendiente cercana a 4 confirma que la radiacion termica es el mecanismo dominante de disipacion de energia en la lampara. Desviaciones respecto a 4 pueden atribuirse a conduccion termica por los soportes, conveccion del gas interno, o dependencia de $epsilon$ con la temperatura.

== Factor de idealidad (metodo grafico)

Partiendo de la ecuacion de Shockley ideal (sin $R_s$, despreciando el $-1$):

$ ln(I) = ln(I_s) + V / (n V_T) $ <eq-lnI>

Se obtiene una recta al graficar $ln(I)$ vs $V$ en la zona de conduccion. La pendiente vale $1 \/ (n V_T)$, de donde:

$ n = 1 / ("pendiente" dot V_T) $ <eq-n-graf>

Este metodo es independiente del ajuste no lineal completo y sirve como validacion cruzada. Solo es valido en la zona donde $I >> I_s$ (se puede despreciar el $-1$) y $I R_s << V$ (la caida en la resistencia serie es despreciable).

== Energia del gap del LED

La tension umbral $V_"th"$ del LED se relaciona con la energia del gap del semiconductor:

$ E_g = q dot V_"th" $ <eq-gap>

y la longitud de onda de la luz emitida:

$ lambda = (h c) / E_g $ <eq-lambda>

Se implementaron dos metodos para determinar $V_"th"$:

- *Metodo de la tangente:* se ajusta una recta a los puntos de alta corriente (ultimo tercio de los datos) y se extrapola hasta $I = 0$. La interseccion con el eje de tension da $V_"th"$.

- *Metodo de la derivada:* se busca el punto de maxima $d I \/ d V$, que corresponde a la transicion entre la zona de corte y la zona de conduccion.

Para un LED rojo se espera $lambda approx 620$--$750$ nm. La coincidencia entre el valor calculado y el color observado durante la experiencia constituye una verificacion experimental directa.

// =============================================
// 4. SIMULACION MONTE CARLO
// =============================================

= Simulacion Monte Carlo

== Motivacion

Para modelos lineales (como la ley de Ohm), la propagacion analitica de incertidumbres es directa: las incertidumbres de los parametros se obtienen de la matriz de covarianza del ajuste. Para modelos no lineales (Shockley, potencial), los parametros dependen de forma compleja de los datos, y la propagacion por derivadas parciales puede subestimar o sobreestimar las incertidumbres reales.

== Metodo

La simulacion Monte Carlo aborda este problema de forma empirica:

+ Se parte del conjunto de datos originales $\{V_i, I_i\}$ y sus incertidumbres $sigma_i$.
+ Se generan $N = 10000$ conjuntos de datos perturbados: $I_i^((k)) = I_i + epsilon_i^((k))$, donde $epsilon_i^((k)) tilde cal(N)(0, sigma_i)$.
+ Para cada conjunto perturbado, se reajusta el modelo y se almacenan los parametros optimos $theta^((k))$.
+ Las distribuciones resultantes $\{theta^((k))\}_(k=1)^N$ representan la incertidumbre de cada parametro.
+ Los percentiles 2,5% y 97,5% definen un intervalo de confianza del 95%.

En pseudocodigo:

```
para k = 1 hasta N:
    I_perturbada = I_original + ruido_gaussiano(0, sigma)
    parametros[k] = ajustar_modelo(V, I_perturbada)

media = promedio(parametros)
intervalo_95 = [percentil(parametros, 2.5), percentil(parametros, 97.5)]
```

== Salida

Ademas de las distribuciones de parametros, se construyen _bandas de confianza_ sobre la curva I(V): para cada conjunto de parametros $theta^((k))$ se evalua $I^((k))(V)$ sobre una grilla fina de tension, y los percentiles 2,5% y 97,5% de las curvas definen la envolvente. Esta banda visualiza graficamente la incertidumbre del modelo.

== Ventajas sobre la propagacion clasica

- No requiere calcular derivadas parciales del modelo.
- Captura correlaciones entre parametros de forma natural.
- Es exacta en el limite $N arrow infinity$ (la propagacion clasica es una aproximacion de primer orden).
- Permite detectar distribuciones no gaussianas de parametros (asimetrias, bimodalidad).

// =============================================
// 5. DASHBOARD INTERACTIVO
// =============================================

= Dashboard interactivo

Los modelos, ajustes y analisis descritos se integraron en un dashboard interactivo desarrollado con Streamlit y Plotly, disponible en:

#align(center)[
  #text(font: "Courier New", size: 9pt)[https://curvas-caracteristicas.streamlit.app/]
]

El dashboard permite explorar los resultados de forma dinamica, modificar parametros y visualizar su efecto en tiempo real. A continuacion se describe cada seccion.

== Pagina principal

Presenta metricas resumen de los cuatro componentes (resistencia $R$, factores de idealidad $n$, exponente $b$) y tablas expandibles con los datos experimentales crudos, incluyendo incertidumbres de medicion.

== Explorador de curvas I-V

Permite seleccionar multiples componentes simultaneamente y visualizar sus curvas I(V) con barras de error. Se puede alternar entre escala lineal y logaritmica para inspeccionar distintas regiones de las curvas.

== Ajuste interactivo

Ofrece dos modos de operacion:

- *Auto-fit:* ejecuta `curve_fit` y muestra los parametros optimos, residuos, $R^2$ y $chi^2$ reducido.
- *Sliders manuales:* el usuario modifica cada parametro con deslizadores y observa en tiempo real como cambia la curva modelada respecto a los datos. Esto desarrolla intuicion sobre la sensibilidad del modelo a cada parametro.

Se muestran ademas las incertidumbres de los parametros ajustados y los residuos $I_"exp" - I_"modelo"$.

== Resistencia dinamica

Calcula y grafica $r(V) = d V \/ d I$ para cada componente. Un deslizador permite modificar el ancho de la ventana del filtro Savitzky-Golay y observar el compromiso entre suavizado y resolucion. Se puede activar escala logaritmica para comparar ordenes de magnitud entre componentes.

== Monte Carlo

El usuario configura el numero de iteraciones $N$ (de 100 a 10000) y ejecuta la simulacion. Los resultados incluyen:

- Bandas de confianza al 95% superpuestas a los datos.
- Histogramas de la distribucion de cada parametro.
- Corner plot (para modelos con multiples parametros) que muestra correlaciones.

== Temperatura del filamento

Especifica para la lampara. Permite configurar $R_0$ (resistencia en frio) y $alpha$ (exponente de temperatura) con deslizadores, y muestra:

- Grafico $R(V)$: evidencia el aumento de resistencia.
- Grafico $T(V)$: temperatura estimada del filamento.
- Verificacion de Stefan-Boltzmann: ajuste $ln(P)$ vs $ln(T)$ con pendiente esperada $approx 4$.

== Factor de idealidad

Para el diodo y el LED, grafica $ln(I)$ vs $V$ y permite seleccionar el rango de tension sobre el cual calcular la pendiente. Muestra el factor $n$ extraido graficamente y lo compara con el obtenido del ajuste no lineal completo.

== Energia del gap

Especifica para el LED. Implementa los metodos de la tangente y de la derivada para determinar $V_"th"$, y calcula $E_g$ y $lambda$. Compara el resultado con el valor de referencia para LEDs rojos.

// =============================================
// 6. ARQUITECTURA DEL CODIGO
// =============================================

= Arquitectura del codigo

El codigo del dashboard esta organizado en cuatro modulos con responsabilidades bien definidas:

#v(0.5em)

#figure(
  align(center)[
    #block(
      stroke: 0.5pt + gray,
      inset: 12pt,
      radius: 4pt,
    )[
      #set text(size: 9.5pt, font: "Courier New")
      #align(left)[
        ```
        dashboard/
          app.py             Pagina principal (Streamlit)
          data.py            Datos experimentales y constantes
          models.py          Modelos fisicos y config. de ajuste
          fitting.py         Ajuste (curve_fit) y Monte Carlo
          analysis.py        Analisis: r_din, T, Stefan-Boltzmann,
                             factor de idealidad, gap
          pages/
            1_curvas_iv.py         Explorador de curvas
            2_ajuste_interactivo.py  Ajuste con sliders
            3_resistencia_dinamica.py
            4_monte_carlo.py
            5_temperatura_filamento.py
            6_factor_idealidad.py
            7_energia_gap.py
        ```
      ]
    ]
  ],
  caption: [Estructura de archivos del dashboard.],
)

#v(0.5em)

La separacion de responsabilidades sigue este flujo:

+ *`data.py`* define los datos experimentales como arreglos NumPy, las constantes fisicas ($k_B$, $q$, $V_T$, $h$, $c$) y la funcion de incertidumbre del multimetro. Expone una funcion `obtener_todos()` que devuelve un diccionario con los datos de los cuatro componentes encapsulados en dataclasses `ComponentData`.

+ *`models.py`* implementa las funciones de los modelos fisicos (`modelo_resistencia`, `modelo_diodo`, `modelo_lampara_potencial`, `modelo_led`) y un diccionario `MODELOS` que asocia cada componente con su funcion, valores iniciales (`p0`) y cotas (`bounds`) para el ajuste.

+ *`fitting.py`* contiene la logica de ajuste (`ajustar_componente`) y la simulacion Monte Carlo (`monte_carlo`). Ambas funciones reciben datos y configuracion de modelo, y devuelven dataclasses tipadas (`ResultadoAjuste`, `ResultadoMonteCarlo`).

+ *`analysis.py`* agrupa los analisis derivados: resistencia dinamica, temperatura del filamento, verificacion de Stefan-Boltzmann, factor de idealidad y energia del gap.

Las paginas de Streamlit (`pages/`) son la capa de presentacion: importan funciones de los modulos, construyen la interfaz con widgets y grafican con Plotly.

// =============================================
// 7. CONCLUSIONES
// =============================================

= Conclusiones

El desarrollo computacional aporta valor al analisis experimental en varios niveles:

+ *Cuantificacion de parametros:* cada modelo produce parametros con significado fisico directo ($R$, $n$, $I_s$, $R_s$, $a$, $b$) y sus respectivas incertidumbres. El estadistico $chi^2$ reducido permite evaluar la adecuacion de cada modelo a los datos.

+ *Consistencia interna:* el exponente $b$ de la lampara permite estimar $alpha$ del tungsteno de forma independiente; el factor de idealidad $n$ se extrae tanto del ajuste no lineal como del metodo grafico semilogaritmico; la longitud de onda calculada del LED coincide con el color observado.

+ *Propagacion rigurosa de incertidumbres:* la simulacion Monte Carlo proporciona intervalos de confianza que no dependen de aproximaciones lineales, especialmente relevante para los modelos no lineales del diodo y del LED.

+ *Mediciones indirectas:* la curva I(V) de la lampara, combinada con la dependencia $R(T)$ del tungsteno, permite estimar la temperatura del filamento y verificar que la radiacion termica domina la disipacion de energia (ley de Stefan-Boltzmann).

+ *Accesibilidad:* el dashboard interactivo permite explorar todos estos resultados sin ejecutar codigo, facilitando la comprension y la presentacion del trabajo.
