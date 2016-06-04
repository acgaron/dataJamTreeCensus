#tree census and environmental / economic indicators

#importing in dataset

`2015_Street_Tree_Census_._Tree_Data` <- read.csv("~/Documents/DataJam/2015_Street_Tree_Census_-_Tree_Data.csv")

treecensus <- `2015_Street_Tree_Census_._Tree_Data`

tree_census_indicators <- read.csv("~/Documents/DataJam/tree_census_indicators.csv")

treehumancensus <- merge(treecensus, tree_census_indicators, by.x = "cb_num", by.y = "cd")

non_census_indicators <- read.csv("~/Documents/DataJam/non_census_indicators.csv")



