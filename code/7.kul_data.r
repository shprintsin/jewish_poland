library(sf)
# %%
# read the "Religie i wyznania w Koronie w II połowie XVIII wieku" geospatial dataset
# kul: katolici uniwersytet lebelsky (catholic university of lublin)
# src: https://wiki.kul.pl/lhdb/Religie_i_wyznania_w_Koronie_w_II_po%C5%82owie_XVIII_wieku

kul_data=sf::read_sf("data/kul/geojson/sacral_objects.geojson")  %>% data.table()  %>% 
# that column that removed are those who had not additional information regrading to jewish community
 select(-geometry,-source,-patronage,-kind,-title,-name,-deanery,-adeaconry,-diocese,-metropoly,-parish,-material)
kul_data =kul_data  %>%  filter(denom=='Religia karaimska'|denom=='Religia mojżeszowa')   %>%  mutate(karaim=as.numeric(denom=='Religia karaimska'))  %>% select(-denom)
# Find main communites
kul_data  %>% mutate(
    main_community=as.numeric(type=='świątynia pomocnicza')
    )  %>%  select(-type) -> kul_data

# village
# indicator =1 if village and 0 if town or city
kul_data  %>%  mutate(isVillage=as.numeric(pl_type=='wieś') )  %>%  select(-pl_type) -> kul_data 

# change column names to english
kul_data=kul_data %>%  select(id=ob_id,name=pl_name,name_german=pl_name_de,name_variant=pl_name_v,viv=pal_name,karaim,main_community,isVillage)

# %%
# modification for ease of merge
# Mapping names to consistent wiewodehips names
kul_data=kul_data   %>% mutate(
    viv = viv  %>%  str_to_lower()  %>% 
     stri_trans_general('Latin-ASCII')
)

# adding normalized name variable -  vowels for each of merge
kul_data=kul_data  %>% mutate(
    original_atlas_name=name,
    name=name  %>% str_to_lower()  %>% 
    stri_trans_general('Latin-ASCII')
)   %>% mutate(
    normalized_name=name  %>% str_remove_all('e|o|i|a|u')
)
# %%

# modify the vivodeship to match with kalik notation
kul_data = kul_data  %>% mutate(viv=case_when(
    viv=='bel' ~  'blz',
    viv=='brac'~  'brc',
    viv=='brzkuj'~'bkj',
    viv=='che'~   'chl',
    viv=='gn'~    'gn', #gn ?
    viv=='in'~    'inw',
    viv=='kal'~   'kls',
    viv=='kij'~   'kij',
    viv=='kr'~    'krk',
    viv=='kuj'~   'kuj', #?
    viv=='lecz'~  'lcz',
    viv=='lub'~   'lbl',
    viv=='malb'~  'mlb',
    viv=='maz'~   'maz',
    viv=='pl'~    'plc',
    viv=='pod'~   'pod',
    viv=='podl'~  'pdl',
    viv=='pom'~   'pmr',
    viv=='poz'~   'pzn',
    viv=='raw'~   'raw',
    viv=='rus'~   'rus',
    viv=='san'~   'snd',
    viv=='sier'~  'swr',
    viv=='wol'~   'wol',
    viv=='hlc'~   'rus',
    viv=='lww'~   'rus',

    TRUE ~ viv
))


# kul  %>% mutate(id=id) %>% left_join(kul1,"id")  %>%  filter(!is.na(name.y))
# kul1=fread('data/util/jewish_towns.csv')  %>% arrange(name)







