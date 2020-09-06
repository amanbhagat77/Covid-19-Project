library(RJSONIO)
nrow <- nrow(covid)
counter <- 1
covid$lon[counter] <- 0
covid$lat[counter] <- 0
while (counter <= nrow){
  CountryName <- covid$countriesAndTerritories[counter]
  CountryCode <- covid$geoId[counter]
  url <- paste(
    "http://nominatim.openstreetmap.org/search?country="
    , CountryName
    , "&countrycodes="
    , CountryCode
    , "&limit=9&format=json"
    , sep="")
  x <- fromJSON(url)
  if(is.vector(x)){
    x[[1]]$lon
    x[[1]]$lat    
  }
  counter <- counter + 1
}
covid$countriesAndTerritories <- gsub("_", " ", covid$countriesAndTerritories)
covid$countriesAndTerritories <- gsub("Cases on an international conveyance Japan", "Japan", covid$countriesAndTerritories)
