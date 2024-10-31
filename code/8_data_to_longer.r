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

# then, merge all to one long table

res=towns  %>% 
left_join(villages,c('index','table','year'))  %>% 
 left_join(near,c('index','table','year')) %>% setDT()
res=res  %>% mutate(
    year=case_when(grepl('cen',year) ~ '1765',
    TRUE~year
    )
)
res

# %% merge with geospatial coordinated data
df_geom=df_geom  %>% select(table,index,geometry)
final=res  %>%
 left_join(df_geom,c('table','index'))  %>% data.table()

# remove NA and duplicates
final  %>% colnames()

setnames(final,'poll','potential')
setnames(final,'viv_e','voivodeship')
setnafill(cols=c('villages_value','near_value','potential'),fill=0,final) 
final=final %>% mutate(across(where(is.list), ~ lapply(., function(x) if (is.null(x)) NA else x))) 
final=final  %>% filter(!grepl('total',name)) 
final=final  %>% group_by(index,year)  %>% filter(!duplicated(value))
final=final  %>% left_join(geoname_data,c("index"))  %>% mutate(
    geometry=ifelse(is.na(table.y),geometry.x,geometry.y)
)  %>% select(-geometry.x,-geometry.y,-table.y)
setnames(final,'table.x','table')
final  %>% fwrite('result_full.csv')
final  %>% select()

final  %>% select(index,table,index,voivodeship,year,value, community,community_code,land,table_abbr,table_title,
index,potential,year,value,villages_value,near_value,geometry)  %>% fwrite('full_result.csv')

final  %>% select(
    table,index,year,value, geometry,
    potential,
    villages_value,near_value,
    name,
    voivodeship=voivodeship,land,community,
    
    community_code,table_abbr
)  %>% fwrite('result.csv')

