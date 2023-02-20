import sys
import csv
import xml.etree.ElementTree as ET

tree = ET.parse(sys.argv[1])
root = tree.getroot()

elements = []


for elem in root:
    line = elem.attrib
    elements.append(line)

with open("sheet.csv", "w") as file:

    for line in elements:
        writer = csv.DictWriter(file, fieldnames=['name', 'x', 'y', 'width', 'height'])
        writer.writerow({'name': line['name'], 'x': line['x'], 'y': line['y'], 
                        'width': line['width'], 'height': line['height']})

