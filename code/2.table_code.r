# %%
# modify the name of the tables to index table (for ease of ordering)
tbls_mod=tbls  %>%  
mutate(table=str_remove_all(table,'table_'))  %>% 
separate(table,c('tab','sub'),sep='_')  %>%  mutate(
    tab=sprintf('%02d',as.numeric(tab)),
    sub=case_when(
        is.na(sub)~'00',
        TRUE~sprintf('%02d',as.numeric(sub))
    )
)  %>% mutate(table=paste0(tab,sub)) %>%  select(-tab,-sub)  %>% data.table()   


# %%