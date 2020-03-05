#***************************************************************************
# Learning using ggmap. By https://www.storybench.org/geocode-csv-addresses-r/
# Using ggmap library:
# D. Kahle and H. Wickham. ggmap: Spatial Visualization with ggplot2. The R Journal,
# 5(1), 144-161. URL http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf

# Still missing KEY for Google's API to Google Maps

#***************************************************************************

# install.packages("ggmap")
#load ggmap
library(ggmap)

# Select the file from the file chooser
fileToLoad <- file.choose()

# Read in the CSV data with the addresses
origAddress <- read_csv(fileToLoad)

# Initialize data frame
geocoded <- data.frame(stringsAsFactors = FALSE)

# Loop through the addresses to get the latitude and longitude of each of them
# and it to the new data frame

for(i in 1:nrow(origAddress)){
  
  # Print("It works...")
  result <- geocode(origAddress$address[i], output = 'latlona', source = 'google')
  origAddress$lon[i] <- as.numeric(result[1])
  origAddress$lat[i] <- as.numeric(result[2])
  origAddress$geoAddress[i] <- as.character(result[3])
  
}

# Write a CSV file containing origAddress to the Working Directory
write.csv(origAddress, "geocoded.csv", row.names = FALSE)

