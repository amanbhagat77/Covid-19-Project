
covid19 <- data.frame(read.csv("covid19.csv"))

covid <- covid19 %>% group_by(countriesAndTerritories,geoId) %>% summarize("Total.Cases" = sum(cases))
covid$countriesAndTerritories <- gsub("_", " ", covid$countriesAndTerritories)
covid$countriesAndTerritories <- gsub("Cases on an international conveyance Japan", "Japan", covid$countriesAndTerritories)
covid <- as.data.frame(covid)
covid$geoId <- gsub("JPG11668" , "JP" , covid$geoId)
covid$geoId <- gsub("UK" , "GB" , covid$geoId)

n <- nrow(covid)

counter <- 1
covid$lon[counter] <- 0
covid$lat[counter] <- 0

while(counter <= n){
  cc <- covid$geoId[counter]
  if(cc %in% countries$country){
    covid$lon[counter] <- countries[grep(cc,countries$country),]$longitude
    covid$lat[counter] <- countries[grep(cc,countries$country),]$latitude
  }
  counter <- counter + 1
}

covidData <- covid %>% filter(covid$lon != 0)