#***************************************************************************
# Learning using open street maps 
# By https://towardsdatascience.com/geocoding-tableau-and-r-integration-c5b32dc0eda6
#***************************************************************************

# load jsonlite
library(jsonlite)

nominatim_osm <- function(address = NULL)
{
  if(suppressWarnings(is.null(address)))
    return(data.frame())
  tryCatch(
    d <- jsonlite::fromJSON( 
      gsub('\\@addr\\@', gsub('\\s+', '\\%20', address), 
           'http://nominatim.openstreetmap.org/search/@addr@?format=json&addressdetails=0&limit=1')
    ), error = function(c) return(data.frame())
  )
  if(length(d) == 0) return(data.frame())
  return(data.frame(lon = as.numeric(d$lon), lat = as.numeric(d$lat)))
}

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
  result <- nominatim_osm(origAddress$address[i])
  origAddress$lon[i] <- as.numeric(result$lon)
  origAddress$lat[i] <- as.numeric(result$lat)
  origAddress$geoAddress[i] <- paste("(",as.character(result$lon),",",as.character(result$lat),")")
}

# Write a CSV file containing origAddress to the Working Directory
write.csv(origAddress, "geocoded.csv", row.names = FALSE)

