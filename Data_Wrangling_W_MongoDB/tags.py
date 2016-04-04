#!/usr/bin/env python
# -*- coding: utf-8 -*-
import xml.etree.cElementTree as ET
import pprint
import re
"""
I used this file to ensure that there were no problem tags in the OSM file
I was going to work with.
"""


lower = re.compile(r'^([a-z]|_)*$')
lower_colon = re.compile(r'^([a-z]|_)*:([a-z]|_)*$')
problemchars = re.compile(r'[=\+/&<>;\'"\?%#$@\,\. \t\r\n]')


def key_type(element, keys):
    if element.tag == "tag":
        attrib = element.attrib['k']
        if problemchars.search(attrib) is not None:
            keys['problemchars'] += 1
        elif lower_colon.search(attrib) is not None:
            keys['lower_colon'] += 1
        elif lower.search(attrib) is not None:
            keys['lower'] += 1
        else:
            #print 'other: ' + attrib
            #print problemchars.search(attrib)
            keys['other'] += 1
        
    return keys



def process_map(filename):
    keys = {"lower": 0, "lower_colon": 0, "problemchars": 0, "other": 0}
    for _, element in ET.iterparse(filename):
        keys = key_type(element, keys)

    return keys



def test():
    keys = process_map('Project/NWPortland.osm')
    pprint.pprint(keys)


if __name__ == "__main__":
    test()
