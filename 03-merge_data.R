# Load attendance and weather data, then join them together

# Read in data files.
attendance <- read.csv("data/good_total_attendance.csv")
weather <- read.csv("data/central_park_weather.csv")

# Merge data by YYYYMMDD (numeric) columns.
attd_temp <- merge(attendance,
                   subset(weather, select=c("YEARMODA", "TEMP")),
                   by.x="ATTN_DATE_YMD", by.y="YEARMODA")

# Write out data to a file.
write.csv(attd_temp, "data/attd_temp.csv", row.names=FALSE)
