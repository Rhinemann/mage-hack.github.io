#let gold = rgb("#FFD700") // gold
#let purple = rgb("#4B0082") // indigo

#let par_indent = 2em

#let symbols = (
  d4: symbol("\u{2463}"),
  d6: symbol("\u{2465}"),
  d8: symbol("\u{2467}"),
  d10: symbol("\u{2469}"),
  d12: symbol("\u{246B}"),
  pp: symbol("\u{24C5}"),
)

#let spec_char = (:)

#for (key, val) in symbols.pairs() {
  spec_char.insert(key, text(purple, val))
}

#let interior_image = "images/interior/"

#let chapter(chapter_name: "", body) = {
  set text(
    font: ("XWGXSC+CortexSymbology", "Goudy Old Style"),
    size: 10pt,
    lang: "en",
    hyphenate: false,
  )

  set page(
    background: context {
      let page_num = here().page()
      let side = if calc.odd(page_num + 1) {
        "left"
      } else {
        "right"
      }
      place(
        image(
          "../../assets/images/interior/Background " + side + ".jpg",
          width: 100%,
          height: 100%,
        ),
      )
      place(
        image(
          "../../assets/images/interior/Border " + side + ".png",
          width: 100%,
          height: 100%,
        ),
      )
    },
    paper: "us-letter",
    margin: (top: 25mm, bottom: 30mm, inside: 15mm, outside: 30mm),
    footer: context {
      set text(font: "Abbess", size: 12pt)
      let h_skip = h(1em)
      let page_num = here().page()

      if calc.odd(page_num + 1) {
        [#page_num #h_skip Mage: The Ascension Cortex Conversion]
      } else {
        align(right)[#chapter_name #h_skip #page_num]
      }
    },
    footer-descent: 10%,
  )

  set terms(hanging-indent: 1em)

  set par(
    // first-line-indent: par_indent,
    leading: 0.2em,
    justify: true,
    linebreaks: "optimized",
  )
  show par: set block(spacing: 1em)

  set quote(block: true)
  show quote: it => {
    set block(above: 0em, below: 1em)
    set pad(left: 1em)
    emph(it)
  }

  show heading: set text(font: ("XWGXSC+CortexSymbology", "Abbess"))
  show heading: set block(below: 0.5em)

  show heading.where(level: 1): it => {
    set text(size: 24pt)
    set block(below: 0.3em)
    show line: set block(above: 0.3em, below: 0.5em)

    it
    line(length: 100%)
  }
  show heading.where(level: 2): set text(size: 20pt)
  show heading.where(level: 3): set text(size: 16pt)
  show heading.where(level: 4): set text(size: 12pt)

  show strong: set text(fill: purple)

  body
}

#let sidebar(s_heading: [], body) = {
  let bg = pattern(size: (139.7mm, 108mm))[
    #place(image("../../assets/images/interior/sidebar.jpg", width: 100%, height: 100%))
  ]
  show regex(symbols.values().join("|")): text.with(gold)

  block(width: 100%, inset: 10pt, stroke: gold + 3pt, fill: bg)[
    #text(
      font: ("XWGXSC+CortexSymbology", "Abbess"),
      fill: gold,
      size: 16pt,
    )[#align(center)[#s_heading <s_heading>]]
    #text(
      font: ("XWGXSC+CortexSymbology", "Futura PT"),
      fill: white,
      size: 10pt,
    )[#body]
  ]
}
