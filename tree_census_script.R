#tree census and environmental / economic indicators

#importing in dataset

library("plyr")
library("ggplot2")
options(digits=2)


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

## analyze correlation in each boro

mn <- subset(indicators, indicators$boro.x == 1)

bx <- subset(indicators, indicators$boro.x == 2)


cor(bx$tree_count, bx$median_household_income_puma)

cor(mn$tree_count, mn$median_household_income_puma)

ggplot(bx, aes(bx$tree_count,bx$median_household_income_puma)) + geom_point() + geom_text(aes(label=bx$cd))


#health by CD
health_tree_cd <- table(BX_MN$cb_num, BX_MN$health)
prop.table(health_tree_cd, 1)


#alive dead by cd

alive_tree_cd <- table(BX_MN$cb_num, BX_MN$status)
prop.table(alive_tree_cd, 1)


#stewards by cd

steward_tree_cd <- table(BX_MN$cb_num, BX_MN$steward)
prop.table(steward_tree_cd, 1)

indicators <- merge(indicators, sq_mile, by.x = "cd", by.y = "BoroCD")

indicators$treesSqMile <- indicators$tree_count/indicators$Shape_Area

ggplot(bx, aes(bx$treesSqMile,bx$median_household_income_puma)) + geom_point() + geom_text(aes(label=bx$cd))

indicators_for_maps <- indicators[,c(
	"cd", 
	"boro.x", 
	"tree_count", 
	"any_exercise_cd", 
	"median_household_income_puma", 
	"air_qual_cd", 
	"at_least_hs_puma", 
	"voted_last_three_years_cd")]

indicators_for_maps <- indicators[indicators_for_maps]

