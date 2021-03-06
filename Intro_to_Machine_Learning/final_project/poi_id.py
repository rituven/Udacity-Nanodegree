#!/usr/bin/python

import sys
import pickle
sys.path.append("../tools/")

from feature_format import featureFormat, targetFeatureSplit
from tester import dump_classifier_and_data
from tester import test_classifier

### Task 1: Select what features you'll use.
### features_list is a list of strings, each of which is a feature name.
### The first feature must be "poi".
features_list = ['poi','salary', 'total_payments', 
                 'shared_receipt_with_poi'] # You will need to use more features

#                 'director_fees', 'deferred_income', 
#                 'to_messages', 'from_messages',
#                'from_this_person_to_poi', 
 
### Load the dictionary containing the dataset
with open("final_project_dataset.pkl", "r") as data_file:
    data_dict = pickle.load(data_file)


### Task 2: Remove outliers
### Task 3: Create new feature(s)
### Store to my_dataset for easy export below.

data_dict.pop('TOTAL', 0)
my_dataset = data_dict

for person in data_dict.keys():
    if (data_dict[person]['from_messages'] != 'NaN') & (float(data_dict[person]['from_messages']) != 0.) & \
       (data_dict[person]['from_this_person_to_poi'] != 'NaN'):
        perc_email_to_poi = (float(data_dict[person]['from_this_person_to_poi']) /
                             float(data_dict[person]['from_messages']))*100
    else:
        perc_email_to_poi = 0
    if (float(data_dict[person]['to_messages']) != 'NaN') & (float(data_dict[person]['to_messages']) != 0.) & \
       (data_dict[person]['from_poi_to_this_person'] != 'NaN'):
        perc_email_from_poi = (float(data_dict[person]['from_poi_to_this_person']) /
                               float(data_dict[person]['to_messages']))*100
    else:
        perc_email_from_poi = 0
    data_dict[person]['perc_email_from_poi'] = perc_email_from_poi
    data_dict[person]['perc_email_to_poi']= perc_email_to_poi


features_list.append('perc_email_from_poi')
features_list.append('perc_email_to_poi')

my_dataset = data_dict

### Extract features and labels from dataset for local testing
data = featureFormat(my_dataset, features_list, sort_keys = True)
labels, features = targetFeatureSplit(data)

print len(data)
print features_list

from sklearn import preprocessing
min_max_scaler = preprocessing.MinMaxScaler()

scaled_features = min_max_scaler.fit_transform(features)

### Task 4: Try a varity of classifiers
### Please name your classifier clf for easy export below.
### Note that if you want to do PCA or other multi-stage operations,
### you'll need to use Pipelines. For more info:
### http://scikit-learn.org/stable/modules/pipeline.html


# Provided to give you a starting point. Try a variety of classifiers.
#from sklearn.naive_bayes import GaussianNB
#clf = GaussianNB()

from sklearn.tree import DecisionTreeClassifier
dtree = DecisionTreeClassifier(min_samples_split =20)

from sklearn.svm import SVC

svc = SVC(kernel="rbf")


### Task 5: Tune your classifier to achieve better than .3 precision and recall 
### using our testing script. Check the tester.py script in the final project
### folder for details on the evaluation method, especially the test_classifier
### function. Because of the small size of the dataset, the script uses
### stratified shuffle split cross validation. For more info: 
### http://scikit-learn.org/stable/modules/generated/sklearn.cross_validation.StratifiedShuffleSplit.html

# Example starting point. Try investigating other evaluation techniques!
from sklearn.cross_validation import train_test_split
features_train, features_test, labels_train, labels_test = \
    train_test_split(scaled_features, labels, test_size=0.3, random_state=42)

### Task 6: Dump your classifier, dataset, and features_list so anyone can
### check your results. You do not need to change anything below, but make sure
### that the version of poi_id.py that you submit can be run on its own and
### generates the necessary .pkl files for validating your results.

from sklearn.feature_selection import SelectKBest, f_regression
from sklearn.pipeline import make_pipeline
from sklearn.decomposition import PCA
from sklearn.ensemble import AdaBoostClassifier

# anova filter, take 6 best ranked features
kbest = SelectKBest(f_regression, k=5)
kbest.fit(features_train, labels_train)

params = kbest.get_support(indices=True)
print params

ada = AdaBoostClassifier(base_estimator=dtree, n_estimators = 100, algorithm='SAMME')
pca = PCA(n_components=2)

my_pipeline = make_pipeline(min_max_scaler, kbest, dtree)


dump_classifier_and_data(my_pipeline, my_dataset, features_list)

#test_classifier(my_pipeline, my_dataset, features_list)
