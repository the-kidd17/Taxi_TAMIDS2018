library(data.table)
library(fasttime)

data_2017 <- fread("Chicago_taxi_trips2017.csv")

# get trip date
data_2017[, "TripDate" := as.Date(`Trip Start Timestamp`, 
                                  format = "%m/%d/%Y %H:%M:%S %p")]

# parse dollar amounts to numeric
cols = c("Fare", "Tips", "Tolls", "Extras", "Trip Total")
data_2017[, (cols) := lapply(.SD, readr::parse_number), .SDcols = cols]

# remove redundant columns
cols = c("Pickup Centroid Location", "Dropoff Centroid Location")
data_2017[, "Pickup Centroid Location" := NULL]
data_2017[, "Dropoff Centroid  Location" := NULL]

