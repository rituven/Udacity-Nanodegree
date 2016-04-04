#!/usr/bin/env python
"""
Query the streetmapdb.pdx collection to find the number of
nodes and ways and print it out
"""

from datetime import datetime
from pymongo import MongoClient


def get_db():
    
    client = MongoClient('localhost:27017')
    db = client.streetmapdb
    return db

if __name__ == "__main__":
    # For local use
    db = get_db()
    #count = db.pdx.find().count()
    #print count
    '''
    query = [{"$match": {"created.user": {"$regex": "Peter Dobratz"},
                         "address.postcode": {"$exists": 1}}},
             {"$group": {"_id": "$address.postcode",
                         "count": {"$sum":1}}}]
    results = db.pdx.aggregate(query)

    results = db.pdx.find({"pos":{"$near": [45.5342611,-122.8476254] },
                           "amenity": {"$regex": "fast_food|pub|restaurant"}},
                          {"_id":0, "amenity": 1, "name": 1})
    

    results = db.pdx.find({"pos":{"$near": [45.5342611,-122.8476254] },
                                "name": {"$exists":1}},
                         {"_id":0, "amenity": 1, "name": 1})

'''
    results = db.pdx.find({"pos":{"$near": [45.5342611,-122.8476254]},
                                "amenity": {"$exists":1}},
                         {"_id":0, "amenity": 1, "name": 1})
    
    from collections import defaultdict
    amenity = defaultdict(int)
        
    for result in results:
        type = result["amenity"]
        amenity[type] +=  1
        
        
    import pprint
    pprint.pprint(amenity)
