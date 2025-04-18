# %% 
# convert the data to long format

assign_index  %>% group_by(table)  %>% filter(duplicated(index))  %>% select(name)
result=assign_index   %>% select(
    name,table,community,community_code,
    land,table_title,
    table_abbr,village,suburb,near ,viv_e,index,type,
`1717`,`1718`,`1718`,`1719`,`1720`,`1721`,`1722`,`1723`,`1724`,`1725`,`1726`,`1727`,`1728`,
`1729`,`1731`,`1732`,`1733`,`1734`,`1735`,`1736`,`1737`,`1738`,`1739`,`1741`,`1742`,`1743`,`1744`,`1745`,
`1746`,`1747`,`1748`,`1749`,`1751`,`1752`,`1753`,`1754`,`1755`,`1756`,`1757`,`1758`,`1760`,`1761`,`1762`,
`1763`,`1764`,,'census','census','cen','poll')  %>% 
 pivot_longer(
    cols=c(`1717`,`1718`,`1718`,`1719`,`1720`,`1721`,`1722`,`1723`,`1724`,`1725`,`1726`,`1727`,`1728`,`1729`,`1731`,
    `1732`,`1733`,`1734`,`1735`,`1736`,`1737`,`1738`,`1739`,`1741`,`1742`,`1743`,`1744`,`1745`,`1746`,`1747`,`1748`,
    `1749`,`1751`,`1752`,`1753`,`1754`,`1755`,`1756`,`1757`,`1758`,`1760`,`1761`,`1762`,`1763`,`1764`,'census','census','cen'),
names_to = "year"
)   
# split for villages, nearby towns and suburbs and villages
villages =result %>% filter(!is.na(value))  %>% filter(village==1)   %>% select(year,villages_value=value,table,index)
near=result  %>% filter(!is.na(value))  %>% filter(near+suburb==1)  %>% select(year,near_value=value,table,index)
towns=result  %>% filter(!is.na(value))  %>% filter(village+near+suburb==0,year!='poll')   %>% select(-village,-suburb,-near,-type)

kalik_geomatry=fread('kalik_geometry.csv')
res=fread('full_result.csv')
# then, merge all to one long table

res=towns  %>% 
left_join(villages,c('index','table','year'))  %>% 
 left_join(near,c('index','table','year')) %>% setDT()
res=res  %>% mutate(
    year=case_when(grepl('cen',year) ~ '1765',
    TRUE~year
    )
)
# res %>% fwrite('full_result.csv')
# %% merge with geospatial coordinated data
# res %>% select(table,index,name) %>% mutate(table=table %>% as.numeric()) %>% unique() %>% left_join(kalik_geomatry,c('table','index'))   %>% filter(is.na(kalik_id)) %>% select(index,name.x,name.y) %>%filter(!grepl('totals',name.x)) %>%  unique() %>% print(100)
res %>% left_join(kalik_geomatry,c('table','index'))   %>% filter(is.na(kalik_id)) %>% colnames()
res %>% left_join(kalik_geomatry,c('table','index'))  %>% select(name=name.x,table,community,community_code,land,table_title,table_abbr,viv_e,index,poll,year,value,villages_value,near_value,kalik_id,newname,lon,lat)  %>% fwrite('result_2.0.csv')
final=fread('result_2.0.csv') %>% select(-table_title)



# remove NA and duplicates

setnames(final,'poll','potential')
setnames(final,'viv_e','voivodeship')
setnafill(cols=c('villages_value','near_value','potential'),fill=0,final) 
final=final %>% mutate(across(where(is.list), ~ lapply(., function(x) if (is.null(x)) NA else x))) 

final %>% fwrite('result_2.0.csv')
final=fread('result_2.0.csv') 
final=final %>% mutate(total=as.numeric(grepl('total|Total|totals',name)|grepl('_ttl',index))) 
final%>% select(table,index,year,value,villages=villages_value,near=near_value,is_sum=total) %>% fwrite('result_wide_values.csv',bom=TRUE)
final%>%select(table,name,index,id=kalik_id,community,community_code,land,table_abbr,potential,lon,lat,newname,is_sum=total)  %>% unique()%>% fwrite('KLK_result_wide_properties.csv',bom=TRUE)
setnames(final,'near_value','near')
setnames(final,'villages_value','villages')
final %>% colnames()

towns_clean <- final %>%
  select(name, table, community, community_code, land, table_abbr,
         voivodeship, potential, index, year, value, kalik_id,
         newname, lon, lat)

# Add transformed village rows
villages_long <- final %>%
  filter(!is.na(villages)) %>%
  transmute(
    name = paste0(name, "_village"),
    table,
    community,
    community_code = paste0(community_code, "_vilg"),
    land,
    table_abbr,
    voivodeship,
    potential,
    index,
    year,
    value = villages,
    kalik_id,
    newname,
    lon,
    lat
  )

# Add transformed near rows
near_long <- final %>%
  filter(!is.na(near)) %>%
  transmute(
    name = paste0(name, "_near"),
    table,
    community,
    community_code = paste0(community_code, "_near"),
    land,
    table_abbr,
    voivodeship,
    potential,
    index,
    year,
    value = near,
    kalik_id,
    newname,
    lon,
    lat
  )

#####################

# Combine all rows
final_long <- bind_rows(towns_clean, villages_long, near_long)
wide_res <- final_long %>%
  pivot_wider(
    id_cols = c(index, table, name, community, community_code, land, table_abbr,
                voivodeship, potential, kalik_id, newname, lon, lat),
    names_from = year,
    values_from = c(value),
    values_fill = NA,
    names_sep = "_",

  )
wide_res  %>% fwrite('result_wide.csv',bom=TRUE)

fread('KLK_result_wide_properties.csv') %>% filter(!is.na(lon),is_sum==0) 
fread('KLK_result_wide_properties.csv') %>% filter(is_sum==0) 
