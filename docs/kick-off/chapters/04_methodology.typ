Overview of the methodology to be used.

Generally, the methodology is based on a new approach combining the existing solution and the framework of Git. 

My approach includes multiple structural changes which are further emphasized in the following sections. The main change is worth adressing here, the vCityJSON file will only show the building in the active branch. 

== Staging Area

The first change is the addition of a staging area. The staging area is a stage between the working directory and the respository. A user is able to use the command 'git add', 'git remove' and 'git change' to add, remove or change buildings in the active vCityJSON file.
When one of these commands is performed two pre-commit hooks are executed. 

The idea of a staging area is taken from the Git framework. Within that framework a index file is maintained that tracks all files that are staged. A new member called 'index' will be added to the vCityJSON.  

=== Intersecting geometries

One of the pre-commit hooks checks for intersecting geometries. 
- For adding buildings, the newly added buildings get checked for intersections with the existing buildings. In case of intersecting geometries, the new buildings to do not get added to the vCityJSON file. 
- The buildings to be removed have their geometries checked with existing buildings for the programme to know which buildings will be removed. 
- The buildings that require a modification have in a similar case to the removed buildings their geometries checked with existing buildings for the programme to know which buildings will be modified.

// Hoe ga ik de intersecting geometries check doen? 

=== Geometry validation

The second pre-commit hook checks that the new geometries are valid. This is done by using a script that runs the cjval library. 

=== CityJSON merger function

In the new solution the vCityJSON document shows the buildings of the active branch. When adding, removing or changing a building the vCityJSON's object will change. A merger function allows for the vCityJSON file to be merged or unmerged of the desired buildings. 

// Hoe verzeker ik dat coordinaat systemen kloppen en dat de buildings echt op de goede plek zitten.

== CityObject Storage

In the current approach, using the same file to store all buildings with possibly minor modifications will lead to a large file size. To solve this another idea from the Git framework is used. A new objects directory will be added to store every unique building as a CityJSONFeature. To reduce the amount of buildings in the vCityJSON file, only the buildings that exist in the active branch will be stored in the vCityJSON file. The other buildings will be stored in the objects directory.

=== CityJSONSequences

vCityJSON files will use the cjseq library to split all buildings into seperate CityJSONFeatures. These features are hashed with the SHA-1 hash from Git and then stored in the objects directory in sub-directores based on the first two characters of the hash. Reversly, if a building needs to be added to the vCityJSON file, the building is retrieved from the objects directory and merged with the other CityJSONFeatures to be streamed into a CityJSON file. 

// Hier moeten ook 2 file merger functies komen. 
