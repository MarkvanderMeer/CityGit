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

