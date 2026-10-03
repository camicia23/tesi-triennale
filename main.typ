#import "@preview/polylux:0.4.0": *
#import "@preview/sns-polylux-template:0.2.1": *
#import "@preview/physica:0.9.8": ket, bra, braket, ketbra, mel



#let blu-unipi = rgb("#003c71")

#let unipi-colormap = (
  rgb("#003C71"), // 1. Blu Unipi (Pantone 541 C esatto)
  rgb("#00325F"), // 2. Sfumatura
  rgb("#00284D"), // 3. Sfumatura
  rgb("#001F3B"), // 4. Sfumatura
  rgb("#001529"), // 5. Sfumatura
  rgb("#000B17")  // 6. Blu scurissimo per le zone d'ombra
)

#let colore-esempio = rgb("6D466B")
#let colore-definizione = rgb("E26D5C")

#let colore_fatto = blu-unipi

// 723D46
// E26D5C



#set text(lang: "en")
#show: sns-polylux-template.with(
  aspect-ratio    : "16-9",
  colormap        : unipi-colormap,
  title           : text(size: 45pt)[Quantum metrology enhancement through quantum processing #v(-50pt)],
  subtitle        : [],
  event           : [28 settembre 2026],
  short-title     : [Quantum Metrology],
  short-event     : [UniPi — 28/09/2026],
  logo-1          : image("pics/logo_unipi_bianco_conscritta.png"),
  logo-2          : image("pics/logo_unipi_blu.jpg"),
  authors         : (
    {
      set text(top-edge: 0pt, bottom-edge: 0pt)
      grid(gutter: 1.3em, columns: (1fr, 1.2fr),
        align(right,[*Candidato:*]),
        align(left, [Samuele Artico]),
        align(right, [*Relatore:*]),
        align(left, [Prof. Vittorio Giovannetti]),)
    },
  )
)


// 1. Definiamo la funzione (da mettere all'inizio del documento)
#let riquadro(
  titolo: "Titolo", 
  colore-principale: blu-unipi.lighten(0%), // Colore di bordo e intestazione
  colore-sfondo: blu-unipi.lighten(90%),     // Colore della parte inferiore
  contenuto
) = {
  block(
    stroke: 2pt + colore-principale,
    radius: 5pt,
    clip: true, // Fondamentale: taglia gli spigoli degli sfondi interni
    width: 100%,
    stack(
      // Blocco superiore (Intestazione)
      block(width: 100%, fill: colore-principale, inset: 8pt)[
        #text(fill: white, weight: "bold", titolo)
      ],
      // Blocco inferiore (Contenuto)
      block(width: 100%, fill: colore-sfondo, inset: 12pt)[
        #contenuto
      ]
    )
  )
}

#let riquadro_esempio(
  titolo: "Titolo", 
  contenuto
) = riquadro(
  titolo: titolo,
  colore-principale: colore-esempio,
  colore-sfondo: colore-esempio.lighten(90%),
  contenuto)

#let riquadro_definizione(
  titolo: "Titolo", 
  contenuto
) = riquadro(
  titolo: titolo,
  colore-principale: colore-definizione,
  colore-sfondo: colore-definizione.lighten(90%),
  contenuto)

#let riquadro_fatto(
  titolo: "Titolo", 
  contenuto
) = riquadro(
  titolo: titolo,
  colore-principale: colore_fatto,
  colore-sfondo: colore_fatto.lighten(90%),
  contenuto)







////////////////////////////////////
// Inizio della presentazione
////////////////////////////////////


#title-slide()


// #toc-slide( title: [Table of Contents] )



#counter("logical-slide").update(1)

// Slide 1
#slide(
  title: [Quantum Metrology],
  new-sec: true,
)[
  #grid(
    columns: (1fr, 1.05fr),
    gutter: 1em,
    [
      #v(1pt)
      #block[
      Per stimare $theta$ con $N$ risorse:
      - Classicamente, $Delta theta  ~ 1/sqrt(N)$ \ (Standard Quantum Limit)
      - Con entanglement arrivo a $Delta theta  ~ 1/N$ (Heisenberg Limit)
      ]

      #riquadro_esempio(titolo: "Esempio con stato GHZ")[
      Evolvendo $ket("GHZ") = (ket(0)^(times.o N) + i ket(1)^(times.o N))/sqrt(2)$ con \ $hat(U)(theta) = exp(-i theta hat(J)_z)$ e misurando con \ $hat(P)_x = times.o.big_(i=1)^N hat(sigma)_x^((i)) $ si ottiene $Delta theta ~ 1/(N sqrt(nu)) $  #text(size:14pt)[ $space$ \ ($nu$ numero di misurazioni indipendenti)]
      ]
    ],
    // Riquadro Esempi in alto a destra
    [
      #riquadro_esempio(titolo: "Esempio con stato squeezed")[
        Evolvendo uno stato squeezed (polarizzato lungo $z$ e compresso con Two-Axis Twisting lungo $x$) con l'evolutore  $hat(U)(theta) = exp(-i theta hat(J)_y)$ e misurando $hat(J)_x$ si arriva a $Delta theta ~ 1/(N sqrt(nu))$
        #v(6pt)
      ]
      #align(right)[
          #image("pics/squeezed_state_abbellito.jpg", width: 60%)
        ]
      
    ],

  )
]




// Slide 2
#slide(
  title: [QFI e località],
  new-sec: true,
)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
      #riquadro_definizione(
        titolo: "Quantum Fisher Information"
      )[
        Per uno stato misto $hat(rho) = sum_n p_n ketbra(n, n)$:

        $ F_Q (theta) = 2 sum_(n,m | p_n + p_m != 0) abs( mel(n, partial_theta hat(rho), m))^2 / (p_n + p_m) $


        Per stati puri $ket(psi) = e^(-i theta hat(H)) ket(psi_0)$:
        
        $ F_Q (theta) = 4 "Var"(hat(H))_psi = 4 (chevron.l hat(H)^2 chevron.r_psi - chevron.l hat(H) chevron.r_psi^2) $
        
      
      ]

      
    ],
    [

      #riquadro_fatto(
        titolo: "Quantum Cramér-Rao Bound")[
          #v(3pt)
          #align(center)[#text(size:23pt)[$Delta^2 theta >= 1/(nu F_Q)$]]
          #v(8pt)
        ]
      #align(center)[
        Problema: \
      _Il bound è saturabile solo per stime locali!_ \
      // Problema di località: la teoria si basa sull'assunzione di conoscere una stima $theta_0$ del parametro.
      $ arrow.b $
      Per l'esempio con GHZ, $chevron.l P_x chevron.r prop - sin(N theta)$ (invertibile solo vicino a 0)
      ]
    ],    
    )
]


#empty-slide()[
  Quindi per problemi di stima globale?
]



// Slide 3
#slide(
  title: [AC sensing e QSS],
  new-sec: true,
)[
  #riquadro_definizione(
    titolo: "Problema: AC sensing"
  )[Rileva un campo oscillante $B(t) = B_0 cos(omega t)$ con frequenza $omega in [omega_min, omega_max]$ e ampiezza $B_0 >= B_min $ ignote.]

  #grid(
    columns: (1fr, 1fr, 0.6fr),
    gutter: 1em,
    [
      Allen et al. (2025) propongono un protocollo di Quantum Search Sensing: integra Grover con un protocollo di sensing per stimare $omega$ senza conoscenze preliminari.
    ],
    [
      #image("pics/bins.png", width: 90%)
      #v(1em)
      #image("pics/risonanza_frequenze.png", width: 90%)
      
    ],
    [
      #image("pics/Grover_visual.png", width: 90%)
    ]
  )

  

  
]




// Slide 4
#slide(
  title: [Efficienza del QSS],
  new-sec: true,
)[
  #grid(
    columns: (1.2fr, 1fr),
    gutter: 1em,
    [
      #riquadro_fatto(
        titolo: "Limite senza elaborazione quantistica"
      )[
        #align(center)[
          Senza elaborazione quantistica, un algoritmo di AC sensing richiede almeno \
          #v(0.2em)
          $tau = Omega(1 / (n_s B_min) lr(ceil.l (Delta omega) / (n_s B_min) ceil.r))$]
          #v(0.5em)
      ]
      #riquadro_fatto(
        titolo: "Limite di Grover-Heisenberg"
      )[
        #align(center)[
          Ogni algoritmo di AC sensing richiede almeno \
          #v(0.2em)
          $tau = Omega(1 / (n_s B_min) sqrt(lr(ceil.l (Delta omega) / (n_s B_min) ceil.r)))$]
          #v(0.5em)
      ]
    ],
    [
      #image("pics/confronto_limiti.png")
    ]

  )
  
]






// Slide 5
#slide(
  title: [Estensione ad altri problemi],
  new-sec: true,
)[

  #riquadro_definizione(
    titolo: "Problema: pattern matching"
  )[
      Classificare dati registrati di onde gravitazionali in serie temporali rumorose, confrontandoli con $N$ (fino a $10^6 - 10^7$) template di modelli teorici, ciascuno con $M$ punti.
  ]

  #grid(
    columns: (1.3fr, 1fr),
    gutter: 1em,
  [
  #riquadro_fatto(titolo: "Pattern matching quantistico")[
    Sharma (2024) propone un protocollo che sfrutta Grover e porta il costo computazionale $ O(N M log M) space -> space O(sqrt(N) ( M log M + log N )) $
  ]
  ],[
  #image("pics/simulazione.png")
  ])
]





// // Slide 5
// #slide(
//   title: [Estensione ad altri problemi ((g)old)],
//   new-sec: true,
// )[
//   L'elaborazione quantistica è utile anche per altri problemi di sensing. \
//   // Sharma nel 2024 propone un protocollo per classificare efficientemente segnali di onde gravitazionali, confrontandoli tramite Grover con un database di segnali teorici. \
//   Sharma nel 2024 propone un protocollo per classificare efficientemente segnali di onde gravitazionali, confrontandoli tramite Grover con un database di segnali teorici. \

//   #riquadro_fatto(
//         titolo: "Miglioramento asintotico con l'approccio di Sharma"
//       )[
//         #align(center)[
//           #v(10pt)
//           // L'approccio di Sharma porta la soluzione del problema \ da un costo di $O(N dot M log M)$ a un costo di $O(sqrt(N) ( M log M + log N ))$
//           $ O(N M log M) -> O(sqrt(N) ( M log M + log N )) $

//           #v(0.2em)

//           #v(0.5em)
//         ]
//       ]
// ]








#empty-slide()[
#set align(left)
  
  Bibliografia
  
  // Impostiamo il testo un po' più piccolo per far stare tutto in una slide
  #set text(size: 16pt)
  
  // Personalizziamo l'elenco numerato per avere le parentesi quadre blu [1], [2], ecc.
  #set enum(
    numbering: n => text(fill: blu-unipi, weight: "bold")[\[#n\]],
    indent: 1em,
    spacing: 1.5em // Spazio tra una voce e l'altra
  )

  



#set enum(
  numbering: n => text(fill: white, weight: "bold")[\[#n\]], // Aggiunge parentesi quadre e colore
  indent: 1em,   // Rientro dell'elenco
  spacing: 1.3em // Spazio tra le voci
)
+ *R. R. Allen et al.*, _Quantum Computing Enhanced Sensing_, arXiv:2501.07625 (2025)
+ *V. A. Sharma*, _Integrating Quantum Algorithms with Gravitational-Wave Metrology for Enhanced Signal Detection_, arXiv:2406.05767 (2024)
+ *F. Nielsen*, _Cramér-Rao Lower Bound and Information Geometry_, Connected at Infinity II, Springer (2013)
+ *G. Tóth, I. Apellaniz*, _Quantum metrology from a quantum information science perspective_, J. Phys. A: Math. Theor. (2014)


  #place(right, dx: -3em, dy: +3em)[
    #text(size:30pt)[Grazie]
    ]
]



