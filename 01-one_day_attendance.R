# A repeatable investigation into the day's NYC public school attendance

# (To run R code in RStudio,
#  highlight what you want to run and
#  press Control-Enter.)

# Download XML from a URL
download.file("http://schools.nyc.gov/AboutUs/schools/data/attendancexml/",
              # to a local file.
              "attendance.xml")

# Read the local XML file into R as text.
attendanceXML <- readLines("attendance.xml")

# To deal with XML, load the XML package.
library("XML")

# Translate from XML format to a tabular data frame
attendance <- xmlToDataFrame(attendanceXML)

# Check the column names.
names(attendance)

# Make a table of dates.
table(attendance$ATTN_DATE_YMD)


# Make a table of Boroughs.
##### YOUR CODE HERE ######


# Drop a few columns.
attendance$LOC_CODE <- NULL
attendance$Borough <- NULL
attendance$DistrictCode <- NULL

# Convert strings like "94.32" to numbers like 94.32.
# Non-numeric strings like "NS" become missing values.
attendance$ATTN_PCT <- as.numeric(as.character(attendance$ATTN_PCT))

# Make a histogram of attendance percentages.
hist(attendance$percent)

# Make a boxplot of attendance percentages.
boxplot(attendance$ATTN_PCT)

# What are the schools with the lowest attendance?
head(attendance[order(attendance$ATTN_PCT), ])

# What is the citywide attendance percentage?
subset(attendance, DBN=="TOTAL")
