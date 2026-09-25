#import "./template.typ": *
#set text(lang: "en", region: "GB")


#show: doc => kickoff(
  title: "CityGit: a Versioning Control System for 3D City Models",
  author: "Mark van der Meer",
  studentnumber: "6301975",
  supervisor1: "Hugo Ledoux",
  supervisor2: "Hidemichi Baba",
  doc,
)

//---
= Introduction
#include "chapters/01_introduction.typ"
#pagebreak()

//---
= Related work
#include "chapters/02_related_work.typ"
#pagebreak()

//---
= Research objectives
#include "chapters/03_research_objectives.typ"
#pagebreak()

//--
= Methodology
#include "chapters/04_methodology.typ"
#pagebreak()

//--
= Preliminary results
#include "chapters/05_preliminary_results.typ"
#pagebreak()

//--
= Time planning
#include "chapters/06_time_planning.typ"
#pagebreak()

//-- 
= Tools and datasets used
#include "chapters/07_tools_and_data.typ"
#pagebreak()

#bibliography("refs.bib", style: "chicago-author-date")