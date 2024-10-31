# Load required libraries
library(leaflet)
library(sf)
library(dplyr)

# Load your CSV with points

# Convert the string geom to actual tuples of coordinates
df <- fread("all_featrues.csv") %>% select(-jg_geom)
head(df)
df=df %>% filter(geom != "") %>%
  mutate(geom = gsub("\\[|\\]", "", geom)) %>%
  separate(geom, into = c("lon", "lat"), sep = ",") %>%
  mutate(lon = as.numeric(lon), lat = as.numeric(lat))

gdf=st_as_sf(df,coords=c("lon","lat"), crs=3857)
 
# df is a feature table that contains points (lon, lat) 
# woj is a polygon layer that contains polygons if provinces (woj)
woi=st_read("woiwodeship.geojson")
gdf=st_transform(gdf,crs=st_crs(woi)) 
viv_container=st_join(woi,gdf,join=st_contains) 
woi %>% group_by(prowincja)%>% summarise(count=n())
woi_litwa <- woi %>%  filter(prowincja == "Litwa") %>%   reframe(geometry = st_union(geometry),woj='Litwa') 
woi_Inflanty <- woi %>%  filter(prowincja == "Inflanty") %>%   reframe(geometry = st_union(geometry),woj='Inflanty')
woi_others <- woi %>%  filter(prowincja != "Inflanty",prowincja != "Litwa") 
woi_combined <- bind_rows(woi_others, woi_litwa) %>% bind_rows(woi_Inflanty)
df %>% select(viv.x) %>% unique()
woi_combined  %>%data.table() %>% group_by(woj)%>% summarise(count=n())%>% select(-count)%>%print(n=32) 
woi_combined=woi_combined %>% mutate(viv_label=case_when(

woj=="bełskie" ~ "bel",
woj=="bracławskie"        ~ "brac",
woj=="brzeskie kujawskie" ~ "brzkuj",
woj=="chełmińskie" ~ "che",
woj=="czernihowskie" ~ "czn",
woj=="inowrocławskie" ~ "in",
woj=="kaliskie" ~ "kal",
woj=="kijowskie" ~ "kij",
woj=="krakowskie" ~ "kr",
woj=="lubelskie" ~ "lub",
woj=="malborskie" ~ "mal",
woj=="mazowieckie" ~ "maz",
woj=="podlaskie" ~ "podl",
woj=="podolskie" ~ "pod",
woj=="pomorskie" ~ "pom",
woj=="poznańskie" ~ "poz",
woj=="płockie" ~ 'pl',
woj=="rawskie" ~ "raw",
woj=="ruskie" ~ "rus",
woj=="sandomierskie" ~ "san",
woj=="sieradzkie" ~ "sier",
woj=="wołyńskie" ~ "wol",
woj=="łęczyckie" ~ "lecz",
woj=='bełskie'~'bel',
TRUE~''
))
woi_combined

df %>% head()
map=leaflet() %>% addPolygons( data = woi_combined, color = "blue", weight = 2, fillOpacity = 0.2, label = ~viv_label, labelOptions = labelOptions( noHide = TRUE, direction = 'auto', textOnly = TRUE ), group = "Polygons" )


st_write(gdf, "output.geojson", driver = "GeoJSON")
# Convert the data to an sf object (simple features)

# Load the GeoJSON polygon layer

# Transform the points to the same CRS as the polygons
gdf <- st_transform(gdf, crs = st_crs(woi))

# Example: Group the data by 'viv.x' and assign a color palette based on the groups

# Create a color palette (using a factor for 'viv.x')
palette <- colorFactor(palette = "Set1", domain = gdf$viv.x)

palette(unique(df$viv.x))
# Extract coordinates from the sf object for leaflet


# Create a leaflet map centered on the area of interest
  map

help(sf)  # Add layer control to toggle between points and polygons
gdf_filters =st_join(woi_combined,gdf,join=st_contains) %>% filter(viv.x!=viv_label) 
gdf=gdf %>% st_sf()
gdf_filters %>% data.table() %>% left_join(gdf %>% data.table(),'code') %>% select(code,viv.x.x,viv_label)
gdf_filtered=gdf %>% filter(code %in% unique(gdf_filters$code ))
gdf_filtered %>% data.table() %>% 
map=addPolygons(lf, data = woi_combined, color = "blue", weight = 2, fillOpacity = 0.2, label = ~viv_label, labelOptions = labelOptions( noHide = TRUE, direction = 'auto', textOnly = TRUE ), group = "Polygons" )
palette=colorFactor(palette = "Set1", domain = gdf_filtered$viv.x)
gdf_coords=gdf_filtered %>% filter(viv.x=='lub') %>% st_coordinates()
# Display the map
map %>% addCircleMarkers(
    lng = gdf_coords[, 1],
    lat = gdf_coords[, 2],
    popup = gdf_filtered$name,  # Label the point with its name
    radius = 2,
    fill = TRUE,
    color=palette(unique(gdf_filtered$viv.x)),
    fillOpacity = 0.8,
    group = "Points"
  )  %>%   addLayersControl(
    overlayGroups = c("Polygons", "Points"),
    options = layersControlOptions(collapsed = FALSE)
  )


