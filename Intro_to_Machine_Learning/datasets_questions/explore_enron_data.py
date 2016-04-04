#!/usr/bin/python

""" 
    Starter code for exploring the Enron dataset (emails + finances);
    loads up the dataset (pickled dict of dicts).

    The dataset has the form:
    enron_data["LASTNAME FIRSTNAME MIDDLEINITIAL"] = { features_dict }

    {features_dict} is a dictionary of features associated with that person.
    You should explore features_dict as part of the mini-project,
    but here's an example to get you started:

    enron_data["SKILLING JEFFREY K"]["bonus"] = 5600000
    
"""

import pickle, pprint

enron_data = pickle.load(open("../final_project/final_project_dataset.pkl", "r"))

enron_data.pop('TOTAL', 0)
# size of data set
print "Sixe of Enron Dataset: " , len(enron_data)
    
# Get number of features
names = enron_data.keys()
person_1 = names[1]
features = enron_data[person_1].keys()
#print "Features: " , features

print "Number of Features: " , len(features)

# Number of POI
num_poi = 0

for person in names:
    if enron_data[person]['poi']== 1:
        num_poi += 1

print "Number of People of Interest:" , num_poi

# James Prentice
#print enron_data['PRENTICE JAMES']

print "Stock Value for James Prentice: ", \
      enron_data['PRENTICE JAMES']['total_stock_value']

# Wesley Colwell

print "Number of email from Wesley Colwell to POI: ", \
      enron_data['COLWELL WESLEY']['from_this_person_to_poi']


# Jeffery Skilling

print "Number of stock options exercised by Jeffery Skilling: ", \
      enron_data['SKILLING JEFFREY K']['exercised_stock_options']



# Total Payments
print "Total money taken home by Jeffery Skilling: ", \
      enron_data['SKILLING JEFFREY K']['total_payments']

print "Total money taken home by Andy Fastow: ", \
      enron_data['FASTOW ANDREW S']['total_payments']

print "Total money taken home by Ken Lay: ", \
      enron_data['LAY KENNETH L']['total_payments']

# Number that have a quantified salary and an email

import math
num_sal = 0
num_sal_poi = 0
num_email = 0
num_tp = 0
num_poi_tp = 0
eso = []
eso_poi = []
num_rso = 0
num_rso_poi = 0
rso = []
rso_poi = []
definc = []
definc_poi = []
srwp = []
srwp_poi = []
defp = []
defp_poi=[]
num_to =0
num_to_poi =0
num_from = 0
num_from_poi =0

for person in names:
    if enron_data[person]['salary'] != 'NaN':
        num_sal += 1
        if enron_data[person]['poi'] == 1:
            num_sal_poi += 1
    if enron_data[person]['email_address'] != 'NaN':
        num_email += 1
    if enron_data[person]['total_payments'] != 'NaN':
        num_tp += 1
    if (enron_data[person]['total_payments'] != 'NaN') & (enron_data[person]['poi']== 1):
        num_poi_tp += 1
    if enron_data[person]['exercised_stock_options'] != 'NaN' :
        eso.append(enron_data[person]['exercised_stock_options'])
        if enron_data[person]['poi'] == 1:
            eso_poi.append(enron_data[person]['exercised_stock_options'])
    if enron_data[person]['restricted_stock'] != 'NaN' :
        rso.append(enron_data[person]['restricted_stock'])
        num_rso += 1
        if enron_data[person]['poi'] == 1:
            num_rso_poi += 1
            rso_poi.append(enron_data[person]['restricted_stock'])
    if enron_data[person]['deferred_income'] != 'NaN' :
        definc.append(enron_data[person]['deferred_income'])
        if enron_data[person]['poi'] == 1:
            definc_poi.append(enron_data[person]['deferred_income'])
    if enron_data[person]['shared_receipt_with_poi'] != 'NaN' :
        srwp.append(enron_data[person]['shared_receipt_with_poi'])
        if enron_data[person]['poi'] == 1:
            srwp_poi.append(enron_data[person]['shared_receipt_with_poi'])
    if enron_data[person]['deferral_payments'] != 'NaN' :
        defp.append(enron_data[person]['deferral_payments'])
        if enron_data[person]['poi'] == 1:
            defp_poi.append(enron_data[person]['deferral_payments'])
    if enron_data[person]['from_messages'] != 'NaN' :
        num_from += 1
        if enron_data[person]['poi'] == 1:
            num_from_poi += 1
    if enron_data[person]['to_messages'] != 'NaN' :
        num_to += 1
        if enron_data[person]['poi'] == 1:
            num_to_poi += 1


print "Number of people with quantified salary:" , num_sal
print "Number of POI with quantified salary: ", num_sal_poi
print "Number of people with valid email address: ", num_email
print "Number of people with NaN for their total payments: ", num_tp
print "Number of POI with NaN for their total payments: ", num_poi_tp

perc_tp = (float(num_tp)/float(len(enron_data)))*100
perc_poi = (float(num_poi_tp)/float(num_poi))*100
print "Percentage of people with NaN for total payments: ", perc_tp
print "Percentage of POI with NaN for total payments: ", perc_poi
print "number of people with exercised stock options: ", len(eso)
print "Max and Mn Exercised stock options are: ", max(eso), " , ", min(eso)
print "number of POI with exercised stock options: ", len(eso_poi)
print "Max and Mn Exercised stock options for POI are: ", max(eso_poi), " , ", min(eso_poi)
print "Number of people with restricted stock: ", num_rso
print "Number of POI with restricted stock: ", num_rso_poi
print "Max restricted stock: ", max(rso), "Min restricted stock: ", min(rso)

print "Max RSO POI: ", max(rso_poi), "Min RSO POI: ", min(rso_poi)
print "Number of people with deferred income: ", len(definc)
print "Max Def Income: ", max(definc), "Min Def Income: ", min(definc)
print "Number of POI with deferred income: ", len(definc_poi)
print "Max Def Income POI: ", max(definc_poi), "Min Def Income POI: ", min(definc_poi)
print "Number of people with Shared receipt with POI", len(srwp)
print "Max Def Income: ", max(srwp), "Min Def Income: ", min(srwp)
print "Number of POI with shared receipt with poi: ", len(srwp_poi)
print "Max Def Income POI: ", max(srwp_poi), "Min Def Income POI: ", min(srwp_poi)

print "Number of people with deferral paymentsI", len(defp)
print "Max Def payments: ", max(defp), "Min Def payments: ", min(defp)
print "Number of POI with deferral_payments: ", len(defp_poi)
print "Max Def Income POI: ", max(defp_poi), "Min Def Income POI: ", min(defp_poi)

print "Number of From Messages: " , num_from, "Num from Messages for POI: ", num_from_poi
print "Number of To Messages: " , num_to, "Num to Messages for POI: ", num_to_poi



