import numpy as np
from scipy.spatial import cKDTree
import json

def world_vertices(cityjson):
    transform = cityjson.get("transform", {})
    scale = np.asarray(transform.get("scale", [1, 1, 1]), dtype=float)
    translate = np.asarray(transform.get("translate", [0, 0, 0]), dtype=float)

    vertices = np.asarray(cityjson["vertices"], dtype=float)
    return vertices * scale + translate


def vertex_hausdorff_distance(cityjson_a, cityjson_b):
    vertices_a = world_vertices(cityjson_a)
    vertices_b = world_vertices(cityjson_b)

    # For each vertex in A, find the nearest vertex in B, and vice versa.
    distances_a_to_b, _ = cKDTree(vertices_b).query(vertices_a)
    distances_b_to_a, _ = cKDTree(vertices_a).query(vertices_b)

    return max(distances_a_to_b.max(), distances_b_to_a.max())

def json_reader(file_path):
    with open(file_path, "r", encoding="utf-8") as file:
        cityjson = json.load(file)
    return cityjson

cube_a = json_reader("examples/cityjsontest/unit-cube.json")
cube_b = json_reader("examples/cityjsontest/unit-cube_crasher.json")

# Example:
distance = vertex_hausdorff_distance(cube_a, cube_b)
print(distance)
