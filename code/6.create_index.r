# %%
# assign unique index for towns
# index is constructed by the name of the woiwodship and name (woj_name)
assign_index =assign_com   %>%  mutate(
    normalized_name=name  %>% str_remove_all('e|o|i|a|u'),
    community_code=community  %>% str_remove_all('e|o|i|a|u|_')
)  %>%  mutate(index=paste0(viv_e,'_',normalized_name))
