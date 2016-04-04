#!/usr/bin/env python
# -*- coding: utf-8 -*-
import xml.etree.cElementTree as ET
from collections import defaultdict
import pprint
import re
import codecs
import json
"""
I used this code to wrangle the data in the NWPortland.osm and convert it to
NWPortland.osm.json following the guidelines defined in the last problem in
Lesson 6 of the Data Wrangling in MongoDB course.

The list of 'expected' values was updated based on the output of
audit_street_type.py. I also updated the 'mapping' dictionary based on that output,
adding each abbreviation and street without a 'Street' at the end to the list.

I also added a list of expected directions (expected_dir) and a corresponding
mapping dictionary (mapping_dir) to be used by the update_dir function to
update the street name with the full directional value.

The shape_element function calls the update_name and update_dir functions to
modify the street names before writing them to the json file.
"""


lower = re.compile(r'^([a-z]|_)*$')
lower_colon = re.compile(r'^([a-z]|_)*:([a-z]|_)*$')
problemchars = re.compile(r'[=\+/&<>;\'"\?%#$@\,\. \t\r\n]')
address_re = re.compile(r'^addr:([a-z]|_)*$')

CREATED = [ "version", "changeset", "timestamp", "user", "uid"]
street_type_re = re.compile(r'\b\S+\.?$', re.IGNORECASE)
street_dir_re = re.compile(r'^([a-z]|_)*\b\S+\.?', re.IGNORECASE)

street_types = defaultdict(set)

expected = ["Avenue", "Boulevard", "Circle", "Court", "Drive", "Highway", "Lane",
            "Loop", "Parkway", "Place", "Road", "Street", "Terrace",  "Way" ]

expected_dir = ["Northwest", "Southwest"]

mapping = { "St": "Street",
            "Ave": "Avenue",
            "Dr": "Drive",
            "Hwy": "Highway",
            "Rd": "Road",
            "road": "Road",
            "GLN": "Glen Street",
            "Regatta": "Regatta Lane",
            "Blanton": "Blanton Street"
            }

map_dir = { "NW": "Northwest",
            "SW": "Southwest"
            }

def audit_street_type(street_types, street_name):
    m = street_type_re.search(street_name)
    if m:
        street_type = m.group()
        if street_type not in expected:
            street_types[street_type].add(street_name)


def is_street_name(elem):
    return (elem.attrib['k'] == "addr:street")

def update_name(name, mapping):

    street_name = street_type_re.search(name)
    key = street_name.group()
    new_street = mapping.get(key)
    if new_street:
        name = re.sub(street_type_re, new_street, name)
    return name

def update_dir(name, map_dir):

    street_dir = street_dir_re.search(name)
    key = street_dir.group()
    new_street = map_dir.get(key)
    if new_street:
        name = re.sub(street_dir_re, new_street, name)
    return name


def shape_element(element):
    node = {}
    if element.tag == "node" or element.tag == "way" :
        #print "Ritu"
        node["type"] = element.tag
        created = {}
        address = {}
        attributes = element.attrib
        lat = 0
        lon = 0
        node_refs = []
        for attrib in attributes:
            #print attrib
            value = element.get(attrib)
            if attrib in CREATED:
                created[attrib] = value
            elif attrib == "lat":
                lat = float(value)
            elif attrib == "lon":
                lon = float(value)
            else:
                node[attrib] = value

        for tag in element.iter("tag"):
            #print tag
            tag_name = tag.attrib['k']
            if address_re.search(tag_name) is not None:
                value = tag.attrib['v']
                if is_street_name(tag):
                    audit_street_type(street_types, value)
                    value = update_name(value, mapping)
                    value = update_dir(value, map_dir)
                address[tag_name[5:]] = value
            else:
                node[tag_name] = tag.attrib['v']
                        
        if element.tag == "way":
            for nd in element.iter("nd"):
                node_refs.append(nd.get("ref"))
                              
        if len(created) > 0:
            node["created"] = created
        if lat != 0 or lon != 0:
            node["pos"] = [lat, lon]
        if len(address) > 0:
            node["address"] = address
        if len(node_refs) > 0:
            node["node_refs"] = node_refs
        #print node
        return node
    else:
        return None


def process_map(file_in, pretty = False):
    file_out = "{0}.json".format(file_in)
    data = []
    with codecs.open(file_out, "w") as fo:
        for _, element in ET.iterparse(file_in):
            el = shape_element(element)
            if el:
                data.append(el)
                if pretty:
                    fo.write(json.dumps(el, indent=2)+"\n")
                else:
                    fo.write(json.dumps(el) + "\n")
    return data

def test():
    data = process_map('NWPortland.osm', True)
    #pprint.pprint(data)
    
if __name__ == "__main__":
    test()
