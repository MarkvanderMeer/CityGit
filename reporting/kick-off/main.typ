#import "./template.typ": *
#import "@preview/dashy-todo:0.1.3": todo
#set text(lang: "en", region: "GB")
#show heading.where(level: 1): set text(size: 20pt)
#show heading.where(level: 2): set text(size: 15pt)
#show heading.where(level: 3): set text(size: 12pt)

#show heading.where(level: 1): set block(below: 1.1em)
#show heading.where(level: 2): set block(below: 0.9em)
#show heading.where(level: 3): set block(below: 0.6em)



#show: doc => kickoff(
  title: "CityGit: a Version Control 
  System for 3D City Models",
  author: "Mark van der Meer",
  studentnumber: "6301975",
  supervisor1: "Hugo Ledoux",
  supervisor2: "Hidemichi Baba",
  doc,
)

#outline()
#pagebreak()

//---
= Introduction<introductionn>
#include "chapters/01_introduction.typ"
#pagebreak()

// Background chapter about stellios his paper?

//---
= Related work <related_work>
#include "chapters/02_related_work.typ"
#pagebreak()

//--
= Methodology <methodology>
#include "chapters/03_methodology.typ"
#pagebreak()

//--
= Preliminary results <preliminary_results>
#include "chapters/04_preliminary_results.typ"
#pagebreak()

//--
= Time planning  <time_planning>
#include "chapters/05_time_planning.typ"
#pagebreak()

//-- 
= Tools and datasets used <tools_used>
#include "chapters/06_tools_and_data.typ"
#pagebreak()

= AI & LLM usage <ai_llm_usage>
#include "chapters/07_ai_usage.typ"
#pagebreak()

#bibliography("refs.bib", style: "chicago-author-date")