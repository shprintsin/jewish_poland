library(stringi)
library(data.table)
library(dplyr)
library(stringr)
df=fread('tax_registers_16c.csv')  %>% select(-V1,data,-data_zrd,-sygn,-rejestr,-link_do_skanu,-str,-varia)
df <- df %>%
  rename(
    id = id_osady,
    name_16c = nazwa_16w,
    year = rok,
    date = data,
    entry_no = nr_not,
    parish = parafia,
    char_settlement = char_osady,
    name_source = nazw_zrd,
    owner_source = wlasciciel,
    persons = osoby,
    family = rodziny,
    objects = obiekty,
    tax_tavern_gr = wyszynk_gr,
    tax_tavern_desc = wyszynk_opis,
    tavern_count = taberna,
    tavern_hereditary = tbr_hrd,
    tavern_annual = tbr_man,
    mill_undershot = k_walne,
    mill_overshot = k_korz,
    mill_hereditary = rota_hrd,
    mill_annual = rota_ann,
    windmill_count = wiatrak,
    windmill_hereditary = wtr_hrd,
    windmill_annual = wtr_ann,
    mill_other_count = k_inne_lb,
    mill_other_type = k_inne_kom,
    vodka_pots = garnce_gorz,
    land_peasant = lany_kmc,
    land_empty = lany_pust,
    land_noble = aratura_sua,
    land_mayor = lany_solt,
    land_other_count = inne_lany_lb,
    land_other_type = inne_lany_kom,
    land_total = lany_suma,
    livestock_sheep = owce,
    workers_fishermen = rybacy,
    craftsmen_count = rzem_lb,
    craftsmen_list = rzem_lista,
    workers_apprentices = czeladnicy,
    smallholders_unspecified = zagr_niesprec,
    smallholders_land = zagr_ziem,
    smallholders_no_land = zagr_bez,
    smallholders_house = zagr_dom,
    tenants_unspecified = kom_niesprec,
    tenants_property = kom_dob,
    tenants_no_property = kom_bez,
    workers_ploughmen = rataje,
    workers_vagrants = luzni,
    tax_jews_gr = zydzi_gr,
    tax_urban_fl = szos_fl,
    tax_urban_gr = szos_gr,
    tax_urban_total_gr = szos_w_gr,
    tax_total_fl = suma_fl,
    tax_total_gr = suma_gr,
    tax_total_den = suma_den,
    tax_total_in_gr = suma_w_gr,
    peasants_count = kmc_liczba,
    pop_ruski = pop_ruski,    
    tax_pop = pop_podatek,    
    livestock_horses = konie  
  )

df  %>%  select(id,name_16c,year,tavern_count,tavern_annual,tavern_hereditary,tax_tavern_desc,tax_tavern_gr)  %>% fwrite('taven_df.csv')
df  %>%  select(id,name_16c,year,mill_undershot,mill_overshot,mill_hereditary,mill_annual,mill_other_count,mill_other_type)  %>%  fwrite('mill_df.csv')
df  %>%  select(id,name_16c,year,vodka_pots,tax_tavern_gr,tax_tavern_desc,tax_jews_gr,tax_urban_fl,tax_urban_gr,tax_urban_total_gr,tax_total_fl,tax_total_gr,tax_total_den,tax_total_in_gr,tax_pop)  %>%  fwrite('tax_df.csv')
df  %>%  select(id,name_16c,year,land_peasant,land_empty,land_noble,land_mayor,land_other_count,land_other_type,land_total,smallholders_unspecified,smallholders_land,smallholders_no_land,smallholders_house)  %>%  fwrite('land_df.csv')
df  %>%  select(id, name_16c, year, livestock_horses, livestock_sheep)  %>% fwrite('animals_df.csv')
df  %>%  select(id,name_16c,year,tenants_unspecified,tenants_property,tenants_no_property)  %>% fwrite('tenants_df.csv')
df  %>%  select(id, name_16c, year, pop_ruski, peasants_count, craftsmen_count, workers_fishermen, workers_apprentices, workers_ploughmen, workers_vagrants, craftsmen_list)  %>%  fwrite('workers_df.csv')
df  %>%  select(id, name_16c, year,tavern_count,tax_tavern_gr,vodka_pots,tax_jews_gr,tax_pop)  %>%  select(id,name_16c)  %>%  filter(!duplicated(id))