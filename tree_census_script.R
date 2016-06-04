#tree census and environmental / economic indicators

#importing in dataset

library("plyr")

`2015_Street_Tree_Census_._Tree_Data` <- read.csv("~/Documents/DataJam/2015_Street_Tree_Census_-_Tree_Data.csv")

treecensus <- `2015_Street_Tree_Census_._Tree_Data`

#just bronx and manhattan for comparison
BX_MN <- subset(treecensus, treecensus$borocode == 1 | treecensus$borocode == 2)
write.csv(BX_MN, file = "bronx_manhattan_tree_census.csv")

bronx_manhattan_tree_census <- read.csv("~/Documents/DataJam/bronx_manhattan_tree_census.csv")

BX_MN <- bronx_manhattan_tree_census

number_trees_bx_mn <- count(BX_MN, "cb_num")

number_trees_bx_mn$tree_count <- number_trees_bx_mn$freq

number_trees_bx_mn$freq <- NULL


tree_census_indicators <- read.csv("~/Documents/DataJam/tree_census_indicators.csv")

treehumancensus <- merge(treecensus, tree_census_indicators, by.x = "cb_num", by.y = "cd")

non_census_indicators <- read.csv("~/Documents/DataJam/non_census_indicators.csv")

#merge indicators
indicators <- merge(tree_census_indicators, non_census_indicators, by.x = "cd", by.y = "CD")

#merge number of trees
indicators <- merge(indicators, number_trees_bx_mn, by.x = "cd", by.y = "cb_num")

write.csv(indicators, file = "fullSetIndicators.csv")