#import "@preview/gantty:0.5.1": *

Having a Gantt chart is probably a better idea than just a list.
This one here is just taken from #link("https://typst.app/universe/package/gantty/")[gantty].

#let gantt_yaml = yaml("../gantt.yaml")
#figure(
  gantt(gantt_yaml)
)