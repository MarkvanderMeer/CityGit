#import "@preview/dashy-todo:0.1.3": todo

The general approach that I propose is to use the VCS framework @Vitalis2019 and research @Vitalis2026 and combine it with techniques from Git to create a user-friendly and robust VCS. In @existing_workflow a diagram is shown of the existing workflow and @workflow_citygit displays a diagram of the proposed CityGit framework. The main improvements include making the framework format neutral (accepting multiple 3DCM encodings), improving the diff algorithm, adding a storage and clarifying the repository. This chapter include three subchapters explaining the different modification to create CityGit.

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,

  [
    #figure(
    image("../figures/existing_solution.jpg", width:95%),
    caption: [Existing workflow in @Vitalis2019]
    ) <existing_workflow>
  ],

  [
    #figure(
    image("../figures/citygit_solution.png", width:110%),
    caption: [Main workflow of CityGit]
    ) <workflow_citygit>
  ],
)

== Format neutrality
//Definition
A format-neutral software product is designed to function with data from multiple file formats, rather than requiring one specific format. Designing format-neutral software code is more flexible and less susceptible to errors, as it is easier to exchange data and it reduces the dependency on a single vendor. The 3D city model encodings are not fighting against each other, but live next to one another, supporting all is only reasonable. It doesn't imply that it works on every data format and preserve all features equally. 

// Scope
Within the scope of this thesis it is planned to have CityGML-XMl and CityJSON file formats as input. CityJSON can proceed directly to validation and change detection, CityGML-XML will first be converted to CityJSON and then follow the same workflow. All encodings will be checked against a list of features that are set as input requirements and accepted by CityGit. Only the input are format neutral, the repository is represented through a canonical CityJSON file. The end goal for CityGit is that it had the possibility to handle every encoding for a 3D city model.

// Workflow
Converting a CityGML-XML file to a CityJSON file can be done with citygml-tools#footnote[https://github.com/citygml4j/citygml-tools]. It is a #emph[command line interface] (cli) that can manipulate CityGML-XML files, including a conversion to and from CityJSON. CityGit will have an input parameter profile, which include a list of supported features. As CityJSON is a subset of the CityGML data model, the support feature is limited by CityJSON's coverage of the CityGMl data model and by the feature CityGit requires. A specific list of features is yet to be defined, but a geometry and list of attributes is a must. 


== Change detection <change_detection_methodology>
Action `1` in @workflow_citygit indicates the step taken when the `git commit` action is performed. When a new version of a 3D city model is committed the change detection algorithm will match CityObjects by its unique identifiers. Per identifier a geometric diff and attribute diff are executed. Changes occur as addition, removal, modification or unchanged, the semantic label attached to the change is stored to log a buildings gradual change (action `3` in @workflow_citygit).

=== Geometric diff <geom_diff>
CityGit will implement the Hausdorff distance as its geometric change detection. Per-object comparison is done on similar LoD's. CityObjects are stored in a CityJSON data format, so from the `boundaries` member, the correct vertices from `vertices` have to be extracted and transformed via `scale` and `translate`. Resulting points are treated as two sets, on which a symmetric Hausdorff distance calculation is performed on a vertex-to-vertex distance. The mathematical definition is:

$ H(A, B) = max(
  d(A,B),d(B,A)
) $

The resulting formula yield a numerical value, with the help of a threshold value a change can be detected. Currently, the threshold value is not defined. It will either be tested and evaluated or be a tweak-able parameter for the user to set.

Existing Hausdorff distance calculations exist in `CGAL`#footnote[https://doc.cgal.org/latest/Polygon_mesh_processing/group__PMP__distance__grp.html] or in python#footnote[https://docs.scipy.org/doc/scipy/reference/generated/scipy.spatial.distance.directed_hausdorff.html] and will as examples of to be modified.

=== Attribute diff <attribute_diff>

Detecting change among attributes is a more straightforward process. Attributes are stored as key-value pair in a CityJSON file and can therefore be compared on a textual level. The attributes of a CityObject, including the attributes of the CityObjects's children, are checked and compared.

== CityObject storage
A downside of the old approach is that all data is stored in the single versioned CityJSON file. When working on larger scale city and after a few commits, multiple versions of the same building will be stored, thus the file size will increase tremendously, making it unpractical to use. 

To solve this problem an idea from Git's internal structure is used (action `2` from @workflow_citygit). Git uses a hidden object folder that is not visible for the user, but is stored in the same directory as the project. The object folder contains all objects of the project's history and orders them in sub0directories starting with the first two characters of the object's hash. 

#figure(
  image("../figures/storage.png", width:70%),
  caption: [Storing CityObjects in objects folder]
) <storage>

In order to split the CityJSON file into its objects, the functionality of CityJSON Text Sequences #footnote[https://www.cityjson.org/cityjsonseq/] <cjseq> (CityJSONSeq) is used. A large CityJSON file is decomposed into its objects to create multiple #emph[CityJSONFeatures]. One feature stores the data of one #emph[CityObject] independently and has a list of local vertices. The #emph[CityJSONFeatures] are then stored per hash in the objects folder. Hashes are generated via the SHA-1 hash function and identical buildings have a common hash.
Reversely, when a version has to be loaded or when `git checkout` is performed, the objects are taken from the objects folder and merged into a single #emph[CityJSONSeq] file, which is be converted back to a regular CityJSON file. @storage and @retrieval show simplified diagrams of both storing and retrieving processes.

#figure(
  image("../figures/retrieval.png", width:70%),
  caption: [Retrieving CityObjects from storage]
) <retrieval>

Additionally, adding a storage system and moving CityObjects from storage to repository causes the repository to only show the active CityObjects per version (action `5` in @workflow_citygit). In the repository, the versioning group the of #emph[vCityJSON] stores all versions of a project. Per version, objects have their hashes stored per `building-id` ensuring only that the correct objects get loaded into the repository. 
To track what the active version is (action `4` of @workflow_citygit) another idea from Git is used. The `HEAD` reference is added as a key-value pair and act as a pointer to the active commit. Implementing the storage distributes the data load load and leads to a unambiguous working directory.