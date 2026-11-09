#import "@preview/dashy-todo:0.1.3": todo
#set list(spacing: 0.5em, body-indent: 0.7em)

3D city models are virtual representations of the built environment and have been widely adopted by municipalities and governmental organisations to visualise and store information about cities @Eriksson2021. 3D city models used to be for visualisation purposes only, but with recent development 3D city models are able to serve numerous other use cases @Biljecki2015, such as measuring energy demand, enabling urban planning, aiding 3D cadastre and supporting simulations for disaster management. Practitioners and researchers use 3D city models in workflows to improve existing 3D city models or extract useful information.

A 3D city model is a snapshot of a city taken at a certain time. However, cities expand and change over time, creating a need for 3D city models to grow alongside their real-world counterpart. These changes need to be tracked in order to create a digital timeline of the cities' development. 

// Misschien moet dit er later een keer uit
Currently, updating a city model is done by extracting an old 3D city model and making modifications or by building a new 3D city model from scratch. For example, after the construction of a new neighbourhood or the modification of existing infrastructure. Workflows like this disregard the incentive of a change and lose useful information for practitioners and researches to draw meaningful conclusions. 

A versioning tool is an ideal solution for this problem. Versioning allows practitioners to track and store changes over time within a project and create a history of versions. Git @Spinellis2012 is a popular version control system (VCS), a tool to manage changes in a project, and is nowadays an integral part of software development. Contributors make changes locally that are later pushed to a remote repository where hierarchy of changes is stored. However, Git marks textual changes disregarding the geometries of buildings, making it unsuitable for a 3D city model.

// Deze tekst moet nog een beetje worden aangepast.
Existing versioning tools for 3D city models have a hard time to be implemented @Idris2024, because of complexity of data and the integration of multiple data sources. These tools do support tracking of temporal data, allow for collaboration and keeps track of a city's lineage. There exist versioning tools for 3D city models in the CityGML-XML exchange format @Kutzner2020 and CityJSON encoding @Vitalis2019. They either lack a robust change detection method or add further complexity. The CityJSON versioning tool has a change detection method that tracks changes between versions, but uses graph representations, wrongly detecting geometry changes.

// Dit laatste moet wellicht worden aangepast want klopt niet van stukje hierboven
This thesis introduces CityGit, a Git-inspired version control system for 3D city models built on top of the CityJSON encoding and built for practitioners to track and store the development of cities. It will improve on the afore mentioned change detection algorithm, whilst maintaining the simplicity of CityJSON.

#pagebreak()
== Research questions <research_questions>
//The research questions are clearly defined, along with the scope (ie what you will not be doing).
// To help you define a "good" research question, read #link("https://geomatics.bk.tudelft.nl/geo2022/templates/Research-Questions_WS-handout.pdf")[this document].

This thesis is based around the following research question:

#emph[How can the CityJSON encoding of a 3D city model, inspired by Git, serve as a repository for a versioning tool for 3D city models?]

This thesis will focus on creating ae versioning tool that has the option to serve multiple 3D city model encodings. The emphasis will be on improving the diff operation to handle changes in attributes and in geometry, while also reducing the total file size.

To reach this goal the following sub-questions are formed:
- What geometric and attribute change detection options are available for a 3D city model versioning tool?
- How can the CityGit framework achieve format neutrality at input, serving multiple 3D city model encodings?
- How can techniques from Git be incorporated to reduce the file size of a versioned CityJSON file?
- What are the limiting factors for developing a collaboration tool for 3d city models?

== Scope of research

This thesis will improve the existing prototype for a versioning tool for 3D city models. The main focus will be on improving the change detection algorithm from graph representation to detecting attribute and geometry changes via a distance metric and not giving a semantic interpretation to change. For geometric change the thesis will only implement the Hausdorff distance metric, but possible assess against other distance metrics. Additionally, the only 3D city model encodings that will be implemented as input for the versioning tool are CityJSON and CityGML-XML. The versioning tool will be developed for local use and will not yet have the option to collaborate with different users. Input data will be used from a single data source with unique identifiers for non-overlapping buildings and the versioning tool will only work for a single Level of Detail (LoD).