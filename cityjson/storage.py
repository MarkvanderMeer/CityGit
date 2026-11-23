"""Module that contains logic to store features of versioned CityJSON files"""

import abc
import hashlib
import subprocess
import json 
import zlib
import sys


# Might remove later
class Hashable(abc.ABC):
    """Abstract class that represents a hashable object."""

    @property
    @abc.abstractmethod
    def data(self):
        """Returns the original json data of the object."""

    def hash(self):
        """Computes the hash of the objects."""
        encoded = json.dumps(self.data).encode('utf-8')
        m = hashlib.new('sha1')
        m.update(encoded)

        return m.hexdigest()

class CityJSONToSequences:
    """Class that converts a CityJSON file to CityJSON Features"""
    
    def __init__(self, input_file, output_file):
        self._input_file = input_file
        self._output_file = output_file

    def convert(self):
        with open(self._output_file, "w") as f:
            subprocess.run(
                ["cjseq", "cat", str(self._input_file)],
                stdout=f,
                check=True
            )

class SequencesToCityJSON:
    """Class that converts CityJSON Features to a CityJSON file"""

    def __init__(self, input_file, output_file):
            self._input_file = input_file
            self._output_file = output_file
    
    def convert(self):
        with open(self.output_file, "w") as f:
            subprocess.run(
                ["cjseq", "collect", str(self.input_file)],
                stdout=f,
                check=True
            )


class BlobObject(Hashable):
    """Class that represents a Blob object in the storage"""

    def __init__(self, data):
        self._json = data

    @property
    def data(self):
        """Returns the original json data."""
        return self._json

    @data.setter
    def data(self, value):
        """Updates the json data."""
        self._json = value

    @classmethod
    def split(cls, file):
        """Creates the BlobObjects from a CityJSONSequence file."""

        header = json.loads(file.readline())

        properties = cls(header)
        properties_hash = properties.hash()

        encoded = json.dumps(properties.data).encode("utf-8")
        compressed = zlib.compress(encoded)

        # Yield header first
        yield compressed, "properties", header

        for line in file:
            if not line.strip():
                continue

            feature = json.loads(line)
            feature["header_hash"] = properties_hash

            blob = cls(feature)

            encoded = json.dumps(blob.data).encode("utf-8")
            compressed = zlib.compress(encoded)

            yield compressed, feature["id"], feature
