#!/usr/bin/env python

import csv

# usage: in.csv is the file of interest
# in order to extract certain columns
# modify the included_cols list below

with open('in.csv', 'rb') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    included_cols = [2, 3, 6, 7, 10]
    for row in reader:
        content = list(row[i] for i in included_cols)
        print content
