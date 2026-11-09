= Feedback on report and presentation for kick-off 04-11.

#figure(
  image("Screenshot 2026-11-09 at 10.26.04.png"),
)

= Important
- There is no real use case for my proposed solution. It would be best if i find a workflow where my solution can be used, this will also answer a lot of different questions posed in the report/presentation.
- Can i used my tool for 3dbag diff releases.

== Introduction
- Rephrase the main research question
- RQ3 is ambiguous as it does not imply the downsides of the filesize, RQ4 is out of the scope and -> change both of these.

== Scope
- Add sematic change to scope.
- Maybe more food for tought: what is the minimum i deliver and what is the maximum? 


== Related work & literature
=== Encodings
- Will I support 3dcitydb / why not use the versioning of postgresql? (2.1.3)

=== Time & Change detection
- Can we separate life-cycle modelling and version control (2.2)
- Elaborate / research on the transaction vs transition and what kind of change i track. (2.2)
- Make chap 2.2 and 2.3 flow together and use the concept of time to explain what change i detect. Might be nice to have an explicit definition. (2.2 & 2.3)
- How to deal with triangulated buildings (2.3)
- Extend the sections about alternative change detection algorithms (2.3)

=== Versioning
- What are the pros & cons of Git, what are the reasons i use it and not another option (2.4.1)
- How is CityGML versioning implemented (2.4.2)
- Explain more of the downsides of vCityJSON and what parts i want to re-use (2.4.3)


== Methodology
- Explain why one big file is a problem and why I propose to a 'storage system' (3) 
- Drop the format neutrality for CityGML-XMl. citygml-tools also works on java, so may not be necessary. (3.1)
- What alternative method is there for Hausdorff that can deal with the point on edge case (3.2.1)
- How do i choose and validate my threshold ? (3.2.1)
- Use JSON Patch for attribute diff? (3.2.2)
- How to maintain a unique ID across versions? (3.2)
- How to do hashing and not duplicate buildings that are identical, but have minor textual differences (3.3)
- How will the structure of my .git folder look like?
- How do i evaluate my methodology: what datasets will i use to test and which metrics will i measure (e.g. diff correctness, repository size, commit/checkout time), against what will i compare it.


== Results
- Deal with triangulation case
- Why is point on line a change in distance metric.
- Add case where objects / vertices are not in the same order 


= Minor feedback
- Refer to sections form the introduction (1.1)
- Name the existing prototype in the scope. (1.3)
- Rephrase how Git does it's change detection (2.4.1)
- Refer to stellios's paper in (3.3)


= Presentation 
- Can my tool track the lineage of a single building.
- Find a new name for vCityJSON.
