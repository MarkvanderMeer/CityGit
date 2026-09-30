#let kickoff(
  title: "Computational modelling of terrains",
  author: "Mark van der Meer",
  email: "mjmeer@student.tudelft.nl", // <== tudelft email!!!
  studentnumber: "123456",
  supervisor1: "Eva de Groot",
  supervisor2: "Piet Smit",
  company: none,
  date: datetime.today(),
  body,
) = {

  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 2.5cm),
  )
  set text(size: 10pt)
  set par(
    justify: true,
    leading: 0.55em,
  )
  set heading(numbering: "1.1.")

  //-- title page
  align(center + horizon)[
    #set page(numbering: none)
    #counter(page).update(0)
    #align(horizon+center)[
      // #v(5cm)
      #text(size: 28pt, weight: "bold", title)
      #v(1cm)
      #text(size: 16pt, [Project proposal (Kickoff) \ GEO2022])
      #v(2cm)
      #text(size: 18pt, weight: "bold", author)\
      #text(size: 14pt, email)\
      #text(size: 14pt, studentnumber)\
      #v(5cm)
    ]
    #grid(
      columns: 2,
      align: (left, left),
      inset: 5pt,
    
      text("Responsible supervisor"),
      text(supervisor1),
      text("Second supervisor"),
      text(supervisor2),
    
      ..if company != none {
        (
          text("Company supervisor"),
          text(company),
        )
      } else {
        ()
      },
    )
      
  ]
  pagebreak()
  set page(numbering: "1")
  body
}