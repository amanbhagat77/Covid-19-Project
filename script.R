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
    covid$lon[counter] <- x[[1]]$lon
    covid$lat[counter] <- x[[1]]$lat    
  }
  counter <- counter + 1
}
covid <- covid19 %>% group_by(countriesAndTerritories,geoId) %>% summarize('Total Cases' = sum(cases))

leaflet(covid) %>% addTiles() %>% addCircles(weight = 5, radius =covid$`Total Cases`)