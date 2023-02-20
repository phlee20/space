"""
XML Parser for Spritesheets

Author: Philip Lee

Take an XML file in the Starling format and writes a csv file.
Attributes include: image name, x and y coordinates and image width and height

Takes two command-line arguments: read file and write file
Ex. python3 xmlparser.py readfile.xml writefile.csv
"""

import sys
import csv
import xml.etree.ElementTree as ET

tree = ET.parse(sys.argv[1])
root = tree.getroot()

elements = []


for elem in root:
    line = elem.attrib
    elements.append(line)

with open(sys.argv[2], "w") as file:

    for line in elements:
        writer = csv.DictWriter(file, fieldnames=['name', 'x', 'y', 'width', 'height'])
        writer.writerow({'name': line['name'], 'x': line['x'], 'y': line['y'], 
                        'width': line['width'], 'height': line['height']})
