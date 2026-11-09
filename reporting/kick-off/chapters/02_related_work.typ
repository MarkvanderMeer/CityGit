#import "@preview/dashy-todo:0.1.3": todo

This chapter gives background information on theory and the concepts used in the later chapters in thesis. 

== 3D city models
3D city model is a broad term to define a virtual representation of structures found in the built environment like, buildings, roads, vegetation and water. There are multiple data formats and encodings to represent a 3D city model, three popular encodings will be explained in this subchapter.

=== CityGML data model & encoding 
The #emph[City Geometry Markup Language] (CityGML) is a standard that defines a conceptual model for the storage and exchange of digital 3D city models @Kolbe2021. The CityGML 3.0 version was accepted by the #emph[Open Geospatial Consortium] (OGC) to be a international standard and is defined by a #emph[Unified Modelling Language] (UML). CityGML uses a GML encoding standard to represent topography of objects, handling geometry, topology, semantical and appearance properties @Kutzner2023. 'City' is not limited to cities and the built environment, but also comprises elevation, vegetation, water bodies and city furniture. 

The CityGML-XML exchange format is #emph[Geography Markup Language] (GML), which is a geospatial encoding that uses #emph[Extensible Markup Language] (XML). GML can represent geographical features, such as polygons and lines in the XML text format. In practice, the use of CityGML-XML has several drawbacks @Ledoux2019. Firstly, in GML there are multiple ways to store a geometry, forcing programmers to write separate code for each instance. Secondly, XML files are hierarchically structured with single objects at the lowest-level. This hierarchy can become deep, increasing the file size and making it difficult to read for humans and machines. Lastly, XML uses #emph[XML Linking Language] (XLinks) that act as referencers to external files. XLinks need libraries to be parsed, because it has a hard time extracting geometries. Consequently, CityGML-XML is a burdensome encoding to use in practice.


=== CityJSON
CityJSON is #emph[JavaScript Object Notation] (JSON)-based encoding of a subset of the CityGML 3.0 data model @Ledoux2023. Similar to CityGML-XML, the CityJSON data exchange format stores 3D city models and is accepted by the #emph[OGC] as an international standard. CityJSON was invented with simplicity in mind to serve programmers an alternative to the verbose CityGML-XML @Ledoux2019.

The JSON data format has a straightforward data structure and uses simple data types. These include a unordered list of elements and a key/value pairs, both respectively referred to as an array and a dictionary. Hence CityJSON is understood by most programming languages making it easy to read and write JSON files. CityJSON files are 'flattened out' removing the nested hierarchy of CityGML-XML, while maintaining the hierarchical relation of CityObjects. 3D coordinates are stored once in a CityJSON file, meaning geometric primitives stored per CityObject have to refer to these coordinates, greatly reducing the file size of a CityJSON file. 


=== 3DCityDB 
The #emph[3D City Database] (3DCityDB) is a free and open source 3D geo-database solution for CityGML-based 3D city models @Yao2018. It uses relational database management systems, such as PostgreSQL and PostGIS, to query and maintain CityGML-XML and CityJSON files. Many cities that use CityGML-XML for its 3D city models use a 3DCityDB @Eriksson2021. A database is useful for organising and querying data, while a versioning tool tracks changes over time. Using a database as a version control system brings several problems, such as there is not easy option to track changes or to restore earlier versions. Building records can store temporal information like #emph[validFrom] and #emph[validTo], but it does not preserve information about earlier versions of a building. Currently, 3DCityDB does not have a specified versioning tool. 


== Temporal modelling <temporal_modelling>
// What is time?
Integrating time in a geospatial model poses two contrasting concepts about past and future @Ledoux2006. Firstly, analysing changes on geospatial data that have been collected at different times in the past and secondly, predicting what will happen in the future on geospatial data that have been collected at a certain time. Both concepts share similar techniques, but have a different goal. 

// Different forms of time
Time can be used to record a feature in a GIS layer or another form of spatio-temporal data. It is important to distinguish #emph[valid time] from #emph[transactional time]. Valid time describes that data was created at a time in the real world, while transactional time describes data was recorded at a given time instance. In a 3D city model, a building can be added to a database after it has been built, indicating that transactional time and valid time are at two different time stamps or time intervals. 

// Life-cycle vs versioning
The distinction time helps to separate life-cycle modelling and version control. Life-cycle modelling is targeted at asset management and tracks states of a real-world building. A building can be planned, constructed, renovated or demolished. Whereas, version control is focussed on recording revisions of a digital assets. A history of a building can have two histories, but they might not be identical. A modification of a building does not correspond to a real-world event, and a real-world event may be recorded at a later time in the data. Theoretically life-cycle modelling and versioning can be combined, but a working example has not yet been developed @Idris2024b. 

// Difference version and change
In this thesis, a version control system consists of versions of a 3D city model. One version is a state of a 3D city model in its digital history and a change is the difference between two versions. A change can be the addition, removal of a CityObject, the modification of geometry or attribute. 

// Use of identifier
Comparing CityObjects across versions requires a way to identify the same object over time. CityGit assumes each CityObject is assigned a unique identifier, which is uniform in every version of a 3D city model. The identifier is used to match the same CityObject in every version, changing geometry or modifying attributes does not change a CityObject's identifier. The rationale for a unique identifier is that otherwise every geometry has to be compared between versions to detect if a change has taken place.  



== Change detection <change_detection_rw>
// Introduceert het concept van change detection en welke ik wil toepassen en wat voor soort veranderingen er zijn. 
The main mechanism of a VCS to detect change between different versions is to measure the difference, also known as diffing. Detecting change between versions implies that a new version exists built from its predecessors. In 3D city models multiple types of changes, such as appearance, semantic, geometric, topological, structural, Level of Detail (LoD), auxiliary and scoped changes occur @Nguyen2021, but for the sake of this thesis only two types of changes are measured, attribute change and geometry change. Attributes are store as key-value pair, changes occur when a value is modified or when a key is added or removed. Geometry changes occur when the shape of a building differs between two versions. 

There are various options to define a geometric change. A model can have a different topology across versions, such as different vertex ordering or triangulation, while retaining the same shape. Changing the shape of a building is meaningful even if the building's attributes remain the same. For this thesis, geometries are compared by shape, changes to the internal structure of a mesh or the topology are not treated as geometric change. A consistent use of LoD is also assumed, as building shapes vary across different LoD's, making it impractical to detect changes.

// Dit is semantic change detection en legt het concept uit hoe een verandering in een 3D model relateert aan de echte wereld.
Some change detection methods go even further and attempt to give semantic meaning to change. Tracking changes in the real-world and translating these to its virtual counterpart adds an extra layer of complexity to a VCS. Modified digital entities can be further semantically enriched in a multi-level process @Nguyen2024, essentially giving semantic meaning to change. To detect change a graph representation of a old and new building model is created in combination with a rule network. The rule network semantically stores modifications that are considered a change, while the graph adheres to the hierarchy of the CityGML data model. A building-component modification might be distinguished from a geometry modification. Giving full semantic meaning to change is useful for some practitioners, realising it in practice is complicated and poses a verbose solution.

// Dit zijn geometric change detection algortihms
There have been attempts to measure change between two geometric scenes. For meshes polygonal @Denning2012 have created #emph[MeshGit], a tool that gives an exact solution to difference in detailed meshes. It measures the dissimilarity between meshes and can transform one mesh into another. The solution is intended for highly detailed meshes and does not scale well, making it improbable for large-scale 3D city models. 
Geospatial diffing of vector data @Sveen2020 has been proposed by #emph[GeomDiff]. It uses the mathematical nature of vector geometries to propose an algorithm to compute a diff. This method is an improvement over textual or JSON diffing, but does not operate in three dimensions. 

// Presenteert de distance metrics in het algemeen en wordt ook uitgelegd waarom als change detection.
Measuring geometric distance between two objects or meshes can be done via distance metrics. Distance metrics measure a numerical difference between two mesh vertices. Most topology modification are not marked by distance metrics, as only the shape of a mesh matters. The most notable distance metrics are the Hausdorff distance, Chamfer distance and PoLiS. The Hausdorff distance measures the maximum distance between any pair of nearest neighbours between two sets in both ways. Neighbours imply the the nearest vertices between two objects. The Chamfer distance measures the average distance between pairs of nearest neighbours between two sets both ways. The PoLiS metric @Avbelj2015 on the other hand estimates similarity of 2D polygons with a different number of vertices. A basic example can be seen in @polis, where the three distance metrics are compared in both direction and symmetrically. The PoLiS metric is defined for polygons and not point sets, so a connecting line has to be added. Originally PoLiS was intended for 2D polygons, but there is an option to transform to 3D. Measuring distance from point to polyhedron can only be done with the help of connecting planes, making it computationally heavy. All options yield a numerical value of difference in 3D space, but no metric by itself defines a meaningful change, that requires a a threshold value. A suitable threshold value should be set according to the model and be evaluated. Coordinate noise should be taken into consideration, as it does not count as meaningful change.

#figure(
  image("../figures/polis.png",width: 50%),
  caption: [Distance metrics visualised, image from @Avbelj2015]
) <polis>

This thesis will use symmetric Hausdorff distance, as it gives a distinct binary change or no-change option, whereas Chamfer distance yields a smaller numerical value that indicates overall change to a building. In a simple scenario where no outliers occur, a single vertex is added to a building, the Hausdorff metric will generate the distance from the new vertex to the closest existing vertex. The Chamfer distance sums the average of all other vertices, which is 0, and add the same distance. The result is a margin that gets close to a possible coordinate noise. 


== Versioning
Versioning is the concept of tracking and storing different iterations of a data over a period of time, subsequently a version control system is making a tool out of versioning. A versioning tool can track revisions of files and store what has been changed by who, allowing practitioners to work in parallel and restore earlier states. This subchapter introduces Git, a well-developed VCS and the two versioning approaches of CityGML-XML and CityJSON. 

=== Git 
Git is decentralised VCS @Spinellis2012. Every contributor has a local repository where they can stage changes and consequently push the made changes to a remote repository. The distributed architecture allows practitioners to work individually and share their work once final.

#figure(
  image("../figures/dag.png",width: 70%),
  caption: [Directed Acyclic Graph (DAG), image from @Vitalis2019]
) <dag>

Git uses a data structure that stores versions instead of changes. It uses a Directed Acyclic Graph (DAG), where every node is a commit (version) that also stores information about its parents and children. A version is a snapshot of the state of a project, likewise it is possible to track the entire history of a project by traversing through all nodes @Vitalis2019, as can be seen in @dag. In a Git repository all project sub-directories and files can be found including a hidden #emph[.git] folder. This folder contains the internal structure and stores, for example, the #emph[HEAD] file; containing a reference to the current commit or branch; a #emph[refs] folder; containing references to commits and branches and most importantly; the #emph[objects] folder; containing every file used in a project. The latter differentiates three types of objects; 1) a blob, storing raw files, 2) a tree, representing a directory with links to various blobs and 3) a commit, making a snapshot of the project including the metadata. Redundant data storage is not necessary, as every blob is only stored once and commits are composed of trees and blobs.

Marking changes in Git is done per-line on a textual level. This implies that minor adjustments are considered a change. For 3D city models the order of its data is insignificant, re-ordering vertices or CityObjects would be detected as a change in Git, while the actual 3D city model did not change. Versioning information is also separately stored in Git, therefore adding an extra layer of complexity when sharing a 3D city model @Vitalis2026. Hence, making Git an unsuitable option as a VCS for 3D city models. 

A versioning tool for geospatial and tabular data does exist in Kart #footnote[https://kartproject.org/]. It is built on top of the structure of Git and work likes Git. However, it's not dedicated towards 3D city models, it doesn't establish object-aware handling of formats like CityGML-XML or CityJSON.


=== CityGML versioning <existing-citygml-versioning>
CityGML version 3.0 introduced the first versioning module. This version @Kutzner2020 introduced a class, #emph[AbstractFeatureWithLifespan], to express bi-temporal existance by adding attributes #emph[creationDate, terminationDate, validFrom] and #emph[validTo] taking the idea from the INSPIRE standard. Two core identifiers have been added: #emph[identifier] to track an object in its total lifespan and #emph[gml:id] to track a specific version of an object. Versioned objects can be denoted by the #emph[version] feature class and are linked by the #emph[versionTransition] feature class. 

A disadvantage of the CityGML versioning module is that it is bi-temporal, tracking both transaction time and valid time, fusing a versioning tool and a life-cycle modelling tool. This is projected in #emph[TransactionValue] that holds both fork and merge (versioning) and planned and realised (life-cycle). Life-cycle modelling requires the semantic meaning of changes and the order of operations to matter @Vitalis2019. It is more suited for asset and process management of a city, instead of managing changes to a 3D city model.


=== CityJSON versioning<existing-cityjson-versioning>
There exists a VCS for the CityJSON encoding of a 3D city models @Vitalis2019. The approach is based on the concepts of Git and uses a unique system architecture and data structure that extends the original CityJSON framework. The new system architecture is named #emph[vCityJSON] (versioned CityJSON), where a single file acts a repository. Within the repository versions are stored under the #emph[versioning] member. Every iteration of all buildings to exist within the VCS's lifespan are stored as a CityObject with a unique identifier. A version includes hashes that refer to an object in the CityObjects, the parent of the version (except for the first version and merged branches) and the metadata. Versions are stored in a first-to-last order and do not adhere to any semantic meaning, making the current approach semantic-agnostic. Additionally, the VCS is operated by multiple commands @Vitalis2026 also used in Git. These commands showcase the potential of the VCS, the approach supports the creation of new versions and the possibility to branch and merge from a lineage of the DAG. 

The change detection algorithm is based on a graph representations from @Nguyen2024. A 3D city model is represented through a graph, where the root node is the model and its children are CityObjects. The CityObject nodes are structured hierarchically, such that the relationships within a building are maintained together with its attributes. Changes are measured via the notion of graph distance, where a distance is measured to get from one version to another. The distance measure only marks changes as addition, removal or modification, but doesn't interpret the scale of the change or wether it is a attribute or geometry change. Topological adjustments are marked as a change, while the shape of a building is unchanged. 

The use of a single vCityJSON file as a repository serves as a good solution for small use cases, but every modified version of a building is stored in this single file. After regular progression of the city the file size will have increased tremendously, making it hard to operate. For example, a CityJSON file of a part of the city  Rotterdam (@rotterdam) is 210 MB in file size. Continuously making modifications to 3D city model, will make the #emph[vCityJSON] reach a file size above 1 GB easily, eventually making it hard to load in memory. Storing CityObjects in a different location will make the repository less clumsy and easier to handle.

#figure(
  image("../figures/screenshot_rotterdam.png", width: 100%),
  caption: [A snippet of the city of Rotterdam in LoD 2.2]
) <rotterdam>
