= Backlog decisions 

== Monday 09-11

I converged all feedback in one document for clarity.

I started with the Storage system: Succesfully convert a CityJSON file to a CityJSONSeq file and create a JSON file per feature.

== Tuesday 10-11

I created a workflow for CityGit when applied to 3D-Bag.

I did research on how Git creates and stores its blobs

== Wednesday 11-11

I improved the workflow for CityGit, writing down 2 alternative flows + evaluation criteria.

Json Patches are useful for detecting attribute change, not for vertices and boundaries.

LFS is not really needed in my case, but Packfiles can be. It stores a delta compression reducing storage size. Might be interesting to measure total file size in ratio against compressed file size

A iteration of a building will be referred to the first entry. 

File names will be hashed and file content will be compressed

== Thursday 12-11

Hashing and compressing CityJSONfeatures is nearly done. Have to merge header with rest of files.

== Monday 16-11 

I succeeded in creating the hashes of cityfeatures and store them separetly. For comparrison the file size of the normal cityfeature and compression are calcuted and are presented as a file_size_normal / file_size_compression. 

I made a start on converting vCityJSON to Cityjson that is used for the cjseq

== Wednesday 18-11 

I wrote down a MVP and a maximum or ideal scenario of what my result should look like.

I realised that converting cityjson --> vcityjson --> cityjson is unnecessary. Hence, the store command does not have to be used and automatic storage takes place when commiting a file. When commiting a new file, the cityobject automatically get stored to storage. Either the hash works on uniques or the cityobject that change have to be used for storage. 

I thouroughly read the CommitCommand, trying to understand the data flow and how a new commit is created and evaluated. I will use the change results for storage. 

== Thursday 19-11

The 'added' and 'changed' buildings get added to the storage, which is intended use. Their hash values are generated based on the cityjsonfeature instead of the hash given at the versionedcityobject. Have to deal with that. The blob.split method doesn't really include a citymodel, but now that i finally start to understand the logic of the versioning and citymodel class i can add that too. 

Next step is to show the active cityobjects in the vcityjson instead of all. 

== Friday 20-11

CityJSONFeatures > CityJSON when storing individual cityobjects. The features take up a little bit less space and I can use the cjseq library to convert instead of making my own conversions + vertex/indices mapping.

Note for self: I modified the cjv.py file such that it only deals with top level cli stuff and modified the StoreCommand in cjv_commands that it executes a long list of code. Currenty the data to be stored is still taken from the file and not the modified new_citymodel. The notes i wrote mean I want to extract the versionedcityobjects and like their name/hash to the cityjsonfeatures hash or smth.


== Monday 23-11

I removed the vertex / indices handler for vcityjson, as it was conflicting with storage. The files stored in local folder are now correctly labeled per hash. They are still overwritten and code can be made more flawless, but that's for another day. In cjv_commands it stores the actual 'added' and 'changed' buildings from the citymodel and not from the file.