# %%
# create table of land, community, and the original names in the book, 
table_land=tribble(
~table,~land,~community,~table_abbr,
    0100,"Autonomous","ext",'ext',
    0200,"Autonomous","rzeszow",'rzs_snd',
    0301,"Autonomous","tykocin", "tyk_maz",
    0302,"Autonomous","tykocin", "tyk_pdl",
    0401,"Autonomous","wegro", "weg_maz",
    0402,"Autonomous","wegro", "weg_pdl",
    0501,"Chellm-Belz","chelm_belz", "chl",
    0502,"Chellm-Belz","chelm_belz", "chl_lub_rus",
    0601,"Great Poland","great_poland", "gp_prussia",
    0602,"Great Poland","great_poland", "gp_in_and_kuj",
    0603,"Great Poland","great_poland",  "gp_kalisz",
    0604,"Great Poland","great_poland", "gp_lcz",
    0605,"Great Poland","great_poland", "gp_maz_and_sier",
    0606,"Great Poland","great_poland", "gp_plock",
    0607,"Great Poland","great_poland", "gp_poznan",
    0608,"Great Poland","great_poland", "gp_rawa",
    0701,"Little Poland","little_poland", "lp_krakow",
    0702,"Little Poland","little_poland", "lp_maz_and_raw",
    0703,"Little Poland","little_poland", "lp_snd",
    0801,"Lublin","lublin", "lbl",
    0802,"Lublin","lublin", "lbl_maz_and_raw",
    0803,"Lublin","lublin", "lbl_snd",
    0900,"Lublin","ordynacja_zamoyska", "ordzam",
    1000,"Podolia","podolia", "podolia",
    1100,"Autonomous","przemysl", "przemysl",
    1201,"Rus","rus", "rus_brc_kij_pod",
    1202,"Rus","rus", "rus_halicz",
    1203,"Rus","rus", "rus_lwow",
    1204,"Rus","rus",  "rus_brc_kij_pod",
    1300,"Samborszczyzna","samborszczyzna","samborszczyzna",
    1401,"Wolyn", "dubno_kowel_olyka_MiedKorecki", "dubno",
    1402,"Wolyn", "krzemieniec", "krzemieniec",
    1403,"Wolyn", "luck",   "luck",
    1404,"Wolyn", "ostrog", "ostrog_brac_pod",
    1405,"Wolyn", "ostrog", "ostrog_kij",
    1406,"Wolyn", "ostrog", "ostrog_wol",
    1407,"Wolyn", "owrucz","owrucz",
    1408,"Wolyn", "wlodzimierz","wlodzimierz"
)  %>% data.table()  %>% mutate(table=table  %>% sprintf('%04d',.) %>% as.character())

# add title of the tables
table_title=fread('data/kalik/metadata/table_list.csv')  %>% mutate(table=table  %>% sprintf('%04d',.))  %>% 
    mutate(table_title=sprintf('%s %s',land,Voivodeships))  %>%
    select(table,table_title)   %>% 
     data.table()  %>% mutate(table=table  %>% as.character())
table_land=table_land  %>% left_join(table_title,"table")
# %%
# modification for in-table community mention 
# (table 1 and table 14_1 have data on multiple communites
assign_com=assign_viv  %>% left_join(table_land,'table')
assign_com=assign_com  %>% mutate(
   community = case_when(
       table=='0100' & prefix %in% c('cch','grd','jbl','ksc','wys','mzw') ~ 'ciechanowiec',
       table=='0100' & prefix=='dbc' ~ 'debica',
       table=='0100' & prefix=='jzf' ~ 'jezefow',
       table=='0100' & prefix=='kzm' ~ 'krakow',
       table=='0100' & prefix=='pzn' ~ 'poznan',
       table=='0100' & prefix %in% c('lbl','lbln','glsk','gls') ~ 'lublin',
       table=='0100' & prefix=='smt' ~ 'siemiatycze',
       table=='0100' & prefix=='mdzy' ~ 'miedzyrzecz_korecki',
       table=='0100' & prefix=='mdzp' ~ 'miedzyrzecz_podlaski',
       table=='0100' & prefix=='prz' ~ 'przemysl',
       table=='1401' & prefix %in% c("dbn","wrk","wrkw") ~'dubno',
       table=='1401' & prefix %in%   c("kmn","mch",'mln')~'kamien_korzecki',
       table=='1401' & prefix %in%   c("kwl","wyzwa",'wyzw','wyz',"nsc")~'kowel',
       table=='1401' & prefix %in%   c("lyk")~'olyka',
       table=='1401' & prefix %in%   c("mdz")~'miedzyrzecz_korecki',
       TRUE~community
   )
)
   













