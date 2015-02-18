# A repeatable investigation into the day's NYC public school attendance

# (To run R code in RStudio,
#  highlight what you want to run and
#  press Control-Enter.)

# Download XML from a URL
download.file("http://schools.nyc.gov/AboutUs/schools/data/attendancexml/",
# to a local file.
              "today.xml")

# Read a local XML file into R as text.
todayXML <- readLines("data/20150213.xml")

# To deal with XML, load the XML package.
library("XML")

# Translate from XML format to a tabular data frame
today <- xmlToDataFrame(todayXML)

# Check the column names.
names(today)

# Make a table of dates.
table(today$ATTN_DATE_YMD)


# Make a table of Boroughs.
##### YOUR CODE HERE ######


# Drop a few columns.
today$LOC_CODE <- NULL
today$Borough <- NULL
today$DistrictCode <- NULL

# Convert strings like "94.32" to numbers like 94.32.
# Non-numeric strings like "NS" become missing values.
today$ATTN_PCT <- as.numeric(as.character(today$ATTN_PCT))

# Make a histogram of attendance percentages.
hist(today$ATTN_PCT)

# Make a boxplot of attendance percentages.
boxplot(today$ATTN_PCT)

# What are the schools with the lowest attendance?
head(today[order(today$ATTN_PCT), ])

# What is the citywide attendance percentage?
subset(today, DBN=="TOTAL")
