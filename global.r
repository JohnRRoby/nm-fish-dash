# this is global.r for public new mexico's fish dash

#load packages
library(tidyverse)
library(shiny)
library(lubridate)
library(shinythemes)

#read in and format the report. must cast to lower case first, then to title case.
report <- read.csv("stocking_report.csv", stringsAsFactors = FALSE)
report$water <- tolower(report$water)
report$species <- tolower(report$species)
report$water <- tools::toTitleCase(report$water)
report$species <- tools::toTitleCase(report$species)
#requried to allow dates to be sorted. server.r has logic to reformat into char for display
report$date <- mdy(report$date)
#rename some columns for better display later
names(report)[names(report) == "fish_length_in"] <- "avg. length (in.)"
names(report)[names(report) == "fish_lbs"] <- "pounds"
names(report)[names(report) == "fish_n"] <- "number"
#drop the hatchery id field because who cares
report <- report[ -c(7) ]

#get vector of waters, 1 instance, alphabetical, to populate dropdown at launch
waterlist <- report %>%
	distinct(water) %>%
	arrange(water)
waterlist <- as.vector(c("All", waterlist$water))




