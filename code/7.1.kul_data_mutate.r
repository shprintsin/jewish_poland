# %%
# Start Matching by iteretion, each time add more variables
# MATCHING STRATEGY OVERVIEW:
# 1. Data Preparation
#    1.1. Consolidate variant names (original, variant, German)
#    1.2. Create normalized names (remove vowels)
#    1.3. Basic cleaning and standardization
# 2. Direct Name Matching
#    2.1. Match by exact original names
#    2.2. Create mapping table
# 3. Normalized Name Matching
#    3.1. Process unmatched names
#    3.2. Remove additional text patterns
#    3.3. Match using cleaned names
# 4. Fuzzy Name Matching
#    4.1. Prepare data for fuzzy matching
#    4.2. Apply fuzzy matching on normalized names
#    4.3. Apply fuzzy matching on original names
# 5. Manual Mapping
#    5.1. Define known name mappings
#    5.2. Apply mappings to remaining unmatched
#    5.3. Final matching attempt
# %%
library(dplyr)
library(stringr)
library(tidyr)
library(fedmatch)

# select names only
kul_names=kul_data  %>% select(id,name,normalized_name,viv,name_german,name_variant)
kalik_names=assign_index  %>%  filter(village+suburb+near+total==0) %>% # find only towns (sense villages named after towns)
  select(table,name,viv=viv_e,normalized_name,index)
kul_names  %>% setDT()
kul_names=kul_data  %>% ungroup()  %>%  select(id,name,name_german,name_variant,viv,normalized_name)

# first step, prepare data- 
# remove duplicates with the same wiwodeship
# 1.1 add variant names
kul_names[grepl('mied',name)&viv=='pdl',name:='miedzyrzecz_podlaski']
kul_names[grepl('miedzyrzec korecki',name),name:='miedzyrzecz_korecki']
kul_names[grepl('wysokie',name)]
kul_names[grepl('wysokie mazowieckie',name),name:="wysokie_mazowieckie"]
kul_names[grepl('kamieniec_podolski',name),name:="wysokie_mazowieckie"]

# 1. DATA PREPARATION
# 1.1. Consolidate variant names
kul_names_variant <- bind_rows(
    kul_names %>% select(kul_id = id, viv, kul_name = name),
    kul_names %>% 
        filter(name_variant != '') %>%
        select(kul_id = id, viv, kul_name = name_variant) %>%
        separate_rows(kul_name, sep = ",\\s*"),
    kul_names %>%
        filter(name_german != '') %>%
        select(kul_id = id, kul_name = name_german, viv)
)

# 1.2. Create normalized names
kul_names_variant <- kul_names_variant %>%
    mutate(
        normalized_name = kul_name %>%
            str_to_lower() %>%
            stri_trans_general('Latin-ASCII')   %>% 
            str_remove_all('a|o|e|i') 
    )

# 1.3. Create normalized version of kalik_names with unique identifier
kalik_names <- kalik_names %>%
    mutate(
        kalik_id = row_number(),
        normalized_name = name %>%
            str_to_lower() %>%
            stri_trans_general('Latin-ASCII')   %>% 
            str_remove_all('a|o|e|i')  %>% 
            str_remove_all(' ') 
    )

# 2. DIRECT NAME MATCHING
# 2.1. Match by exact original names
direct_matches <- kul_names_variant %>%
    inner_join(kalik_names, by = c("normalized_name")) %>%
    select(kul_id, kalik_id, kul_name, kalik_name = name) %>%
    mutate(match_type = "direct")

# 3. NORMALIZED NAME MATCHING
# 3.1. Get unmatched records
unmatched_1 <- kul_names_variant %>%
    anti_join(direct_matches, by = "kul_id")

# 3.2. Clean normalized names further
unmatched_modified <- unmatched_1 %>%
    mutate(
        normalized_name = normalized_name %>%
            str_remove_all('nwy | kszyrsk| stry| nwy|^str | str$|mzwck|kjwsk| rwsk| strmlw| jgllnsk| wlk| zlt| lblsk| nw|wlk | dln| kscln|stry | dz| krlwsk| rsk') %>%
            str_remove_all(' ')
    )

# 3.3. Match using cleaned names
normalized_matches <- unmatched_modified %>%
    inner_join(kalik_names, by = "normalized_name") %>%
    select(kul_id, kalik_id, kul_name, kalik_name = name) %>%
    mutate(match_type = "normalized")

# 4. FUZZY NAME MATCHING
# 4.1. Prepare data for fuzzy matching
unmatched_2 <- kul_names_variant %>%
    anti_join(bind_rows(direct_matches, normalized_matches), by = "kul_id")  %>% 
     filter(!duplicated(kul_id))

# 4.2. Fuzzy match on normalized names
fuzzy_result_1 <- merge_plus(
    data1 = kalik_names,
    data2 = unmatched_2,
    by.x = "normalized_name",
    by.y = "normalized_name",
    unique_key_1 = "kalik_id",
    unique_key_2 = "kul_id",
    match_type = "fuzzy"
)

# 4.3. Fuzzy match on original names
fuzzy_result_2 <- merge_plus(
    data1 = kalik_names,
    data2 = unmatched_2,
    by.x = "name",
    by.y = "kul_name",
    unique_key_1 = "kalik_id",
    unique_key_2 = "kul_id",
    match_type = "fuzzy"
)

fuzzy_matches <- bind_rows(
    fuzzy_result_1$matches %>% 
        select(kul_id, kalik_id, kul_name, kalik_name = name),
    fuzzy_result_2$matches %>% 
        select(kul_id, kalik_id, kul_name, kalik_name = name)
) %>%
    mutate(match_type = "fuzzy") %>%
    distinct()


# 5. MANUAL MAPPING
# 5.1. Get remaining unmatched
unmatched_final <- kul_names_variant %>%
    anti_join(bind_rows(direct_matches, normalized_matches, fuzzy_matches), 
              by = "kul_id")

# 5.2. Define manual mappings
  # Confident matches (clear spelling variations or transliterations)
name_mappings <- tribble(
    ~kul_name,                ~kalik_name,
    # Simple spelling variations
    'brusilow',               'brusylow',
    'czeczelnik',             'czekielnik',
    'dzwinogrod',             'dωwinogrod',
    'frampol',                'frannopol',
    'gwozdziec',              'gwoωdziec',
    'hulewicze',              'hulewiczow',
    'jaruga',                 'jaruha',
    'knichynicze',            'knihynicze',
    'kornik',                 'kurnik',
    'kruty',                  'krute',
    'luhiny',                 'luhyny',
    'mizocz',                 'misocz',
    'morachwa',               'murachwa',
    'murawica',               'morawica',
    'nawarja',                'nawarya',
    'norynsk',                'nordzynsk',
    'orla',                   'orly',
    'przytyk',                'przytuk',
    'rudki',                  'rudka',
    'sarnowa',                'sarny',
    'smila',                  'smyla',
    'sokul',                  'sokol',
    'srem',                   'szrem',
    'strzemilcze',            'stremilche',
    'studzienica',            'studenica',
    'szczuczyn',              'szczucin',
    'touste',                 'towste',
    'zolynia',                'zulin',
    # Shortened forms
    'brzesc kujawski',        'brzesc',
    'murowana goslina',       'goslina',
    'okopy swietej trojcy',   'okop',
    'piotrkow kujawski',      'piotrkow',
    'ustrzyki dolne',         'ustrzyki',
    
    # Common prefix/suffix variations
    'bukaczowce',             'bukaszowce',
    'chwarczenko',            'chwaszczow',
    'solodkowce',             'solobkowiec',
    'traktamirow',            'trechtymirow',

    'frampol',                'frannopol',           
    'dzwinogrod',             'dωwinogrod',          
    'gwozdziec',              'gwoωdziec',           
    'przytuk',                'przytyk',             
    'brzesc kujawski',        'brzesc',              
    'bukaczowce',             'bukaszowce',          
    'chwarczenko',            'chwaszczow',          
    'obrzycko',               'obrzysko',            
    'srem',                   'srem',                
    
    # MEDIUM CONFIDENCE (Clear similarities with comm
    'trechtymirow',           'traktamirow',         
    'teplik',                 'teofilpol',           
    'drohobycz',              'drohiczyn',           
    'strzemilcze',            'stremilche',          
    'kamien_korzecki',        'kamien koszyrski',    
    
    # LOWER CONFIDENCE (Require verification)
    'zbrzyz',                 'zbaraz',              
    'zarzecze',               'zarzecze',            
    'wisniowiec stary',       'wisniowczyk',
    "fitowo",                   "fijewo",
    "bochlin",                  "bachtyn",
    "fitowo",                   "fijewo",
    "goraj",                    "goray",
    "kamien koszyrski",          "kamien_korzecki",
    "mohylow",                  "mohylow_podolski",
    "pruszcz",                   "prysucha",
    "rachmanow",                "rachanie",
    "teplik",                   "teplic",
    "turka",                "turka_w_gorach",
    "uscie zielone",            "uscie"
)




kalik_names  %>% filter(grepl('kamieniec',name))
# 5.3. Apply manual mappings and match
manual_matches <- unmatched_final %>%
    inner_join(name_mappings, by = "kul_name") %>%
    inner_join(kalik_names, by = c("kalik_name" = "name")) %>%
    select(kul_id, kalik_id, kul_name, kalik_name) %>%
    mutate(match_type = "manual")

# 6. COMBINE ALL MATCHES AND ANALYZE
# 6.1. Combine all matching results
all_matches <- bind_rows(
    direct_matches,
    normalized_matches,
    fuzzy_matches,
    manual_matches
)

# 6.2. Identify and analyze duplicate matches
match_table=all_matches  %>% select(kul_name,kalik_name,kul_id,match_type)   %>% filter(!duplicated(kalik_name))
unmatched=assign_index  %>% filter(!grepl('total|village',name))  %>%  mutate(kalik_name=name) %>% 
left_join(match_table,"kalik_name")  %>% filter(is.na(kul_id),!duplicated(index))  
all_matches=all_matches  %>% filter(!duplicated(kalik_name))  %>% select(name=kalik_name,kul_id)



# %%
# 7. for the rest of the variable, use dataset prepeared by jewishgen information and geonames alternative spelling
# then merge all to one file
kull_full_data=sf::read_sf("data/kul/geojson/sacral_objects.geojson")  %>% data.table()  %>% select(kul_id=ob_id,geometry)
all_matches=all_matches  %>% filter(!duplicated(kalik_name))  %>% select(name=kalik_name,kul_id)

jewishgen=fread('data/jewishgen_features.csv')  %>% select(name,rid,geom)

df_geom=kalik_names %>%  left_join(all_matches,'name')  %>% left_join(jewishgen,'name') %>%
 left_join(kull_full_data,'kul_id')  %>% 
 data.table()  %>% mutate(
    geometry=ifelse(is.na(kul_id),geom,geometry)
 )  %>% select(table,name,normalized_name,index,geometry)

df_geom

geoname_data <- tribble(
  ~index,              ~name,               ~geom,
  "pod_kmnc_pdlsk", "kamieniec_podolski", "48.67882|26.58516",
  "pod_plw",         "pilawa",             "51.95945|21.53089",
  "pod_srbr",        "serebria",           "48.45556|27.71635",
  "rus_bbc_bchw",    "babice_bachow",      "52.26028|20.83403",
  "wol_krnc",        "kornica",            "52.18183|22.93752",
  "wol_klcz",        "klucz",              "50.43783|18.28194",
  "maz_jdw",         "jadow",              "52.47849|21.63199",
  "lcz_brtszwc",     "bratoszowice",       "51.92876|19.65441",
  "wol_lksync",      "oleksyniec",         "49.83932|25.55571",
  "pod_mktync",      "mikitynce",          "48.90647|24.75334",
  "pod_sdkwc",       "sudkowce",           "48.63078|28.23291",
  "pod_mztw",        "moztow",             "48.83333|28",
  "wol_tfpl",        "tofipol",            "49.83892|26.4204",
  "lbl_cp_btwn_sn",  "cape_between_san",   "54.3632|18.95255"
)
geoname_data <- geoname_data %>%
  separate(geom, into = c("lat", "lon"), sep = "\\|") %>%
  mutate(lat = as.numeric(lat), lon = as.numeric(lon))

# Convert to sf object with initial CRS (assuming EPSG:4326)
sf_data <- st_as_sf(geoname_data, coords = c("lon", "lat"), crs = 4326)
sf_data_3857 <- st_transform(sf_data, crs = 3857)

geoname_data=kalik_names  %>%  select(table,index)  %>% inner_join(sf_data_3857,'index')  %>% select(table,index,geometry)  %>% data.table()

df_geom = df_geom %>% data.table()
df_geom=rbind(df_geom,geoname_data,ignore.attr=TRUE,fill=TRUE)
# unmatched$kalik_name
# rbind(kul  %>% select(name,normalized_name),
# assign_index   %>%  mutate(kalik_name=name) %>% left_join(match_table,"kalik_name")  %>% filter(is.na(kul_id),!duplicated(index))    %>% select(name)  %>% 
# filter(!grepl('total',name))  %>% arrange(name) %>% mutate(src='----- kal ------'),fill=TRUE)  %>% arrange(name)  %>% clipr::write_clip()



