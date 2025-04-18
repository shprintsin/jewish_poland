library(sf)
library(data.table)
library(dplyr)
borders=sf::read_sf('maps/1765borders.geojson')%>% sf::st_transform(4326)
data=fread('result_wide_properties.csv') %>% filter(!is.na(lon))

borders <- borders %>%
  filter(prow %in% c('WLP', 'MLP')) %>%
  mutate(type = "border")

data <- data %>%
  filter(!is.na(lon))
points <- st_as_sf(data, coords = c('lon', 'lat'), crs = 4326) %>%
  mutate(type = "point")

# Ensure identical column structure for union
common_cols <- intersect(names(borders), names(points))
borders_sub <- borders[, common_cols]
points_sub <- points[, common_cols]

unified <- rbind(borders_sub, points_sub)

# Save to GeoJSON
st_write(unified, "result_map.geojson", delete_dsn = TRUE)