# Selecting usable TOTAL attendance entries from all data

# Read a slightly large data set with ALL known attendance data
all_attendance <- read.csv("data/all_attendance.csv")

# Convert strings like "94.32" to numbers like 94.32.
# Non-numeric strings like "NS" become missing values.
all_attendance$ATTN_PCT <- as.numeric(as.character(all_attendance$ATTN_PCT))

# For nice relational-esque data manipulation, load the dplyr package.
library("dplyr")

# Extract the total percentages and number of entries for each day.
totals <- all_attendance %>%
  group_by(ATTN_DATE_YMD) %>%
  summarise(ATTN_PCT = ATTN_PCT[DBN=="TOTAL"],
            n = n())

# Observe the distribution of attendance percentages.
hist(totals$ATTN_PCT, breaks=100)
# Observe the distribution of entries per day.
hist(totals$n, breaks=100)
# Make a decision about what data to use.

# Select rows of data to use going forward.
good_data <- totals %>%
  filter(0 < ATTN_PCT) %>%
  filter(1450 < n) %>%
  select(-n)

# Write out data to a file.
write.csv(good_data, "data/good_total_attendance.csv", row.names=FALSE)
