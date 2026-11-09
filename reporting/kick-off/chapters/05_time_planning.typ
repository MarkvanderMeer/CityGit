#import "@preview/gantty:0.5.1": *
#import "@preview/dashy-todo:0.1.3": todo



#let gantt_yaml = yaml("../gantt.yaml")
#figure(
  gantt(gantt_yaml)
) 