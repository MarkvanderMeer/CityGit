#import "@preview/dashy-todo:0.1.3": todo

The implemented change detection in @Vitalis2019 has a few limitations, as mentioned in @existing-cityjson-versioning. A distance metric, like Hausdorff distance, can avoid these limitations. In this chapter a simple unit cube (@unit_cube) is used to compare two different change detection methods. The tests represent different boundary representations of the unit cube's mesh and common errors causes. In reality building structure are more complex, but for the sake of demonstration a unit cube is used. No tolerance it set for these tests.

#figure(
  image("../figures/unit_cube.jpeg", width: 45%),
  caption: [Unit cube]
) <unit_cube>

Results are presented in @cube_tests and show that modifying the internal structure (test 2, 3, 4 & 5) of a mesh is detected as a change for the graph representation. However, the Hausdorff distance results in a value of 0, indicating that no change occurred to the shape of the building. The last two test, where a point is added on the line and on a plane, do under both circumstances detect a change. These are preliminary results and is not a full proof that one change detection algorithm is better than the other.

#figure(
  table(
  columns: (auto, auto, auto, auto, auto),
  inset: 6pt,
  align: horizon,
  table.header(
    [],[*Type of test*],[*Description*], [*Graph representation*], [*Distance metric*],
  ),
  [*1*],[Error margin], [One vertex has an error margin of 0.001], [No change], [Based on tolerance],
  [*2*],[Swap 2 vertices],[Vertex 0 and 6 are swapped], [Change], [No change],
  [*3*],[Swap 2 planes],[The top (0123) and front (4510) plane are swapped], [Change], [No change],
  [*4*],[Incorrect plane],[Order of top plane is swapped to go clockwise ], [Change], [No change],
  [*5*],[Triangulated cube], [6 Faces are triangulated to 12 faces],[Change], [No change],
  [*6*],[Add point on line], [A point is added on the 0-1 edge],[Change], [Change],
  [*7*],[Add point on plane], [A point is added on the top face],[Change], [Change],
  ),
  caption: [Unit cube test results]
) <cube_tests>


