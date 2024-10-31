# %%
# Mainly Menial work - SKIP recommended
# create normalised names for ease of mutation
# "prefix" is temporal variable with unique 3 letters, or 4 letters if two towns have the same prefix

src_names=tbls_mod  %>% data.table()  %>%    mutate(prefix = str_remove_all(name, 'e|a|o|i|u| .*'))  %>% 
  mutate(
   # number of letters in prefix
    prefix3 = substr(prefix, 1, 3),
    prefix4 = substr(prefix, 1, 4),
    prefix5 = substr(prefix, 1, 5),
    prefix6 = substr(prefix, 1, 6)
  )
  # modify known trouble maker names
src_names[,prefix:=case_when(
    name=='oksza'~'ksa',
    name=='kilikiew'~'kilk',
    name=='berezno'~'brzno',
    name=='zurow'~'zurw',
    name=='letow'~'ltwo',
    name=='miedzyrzecz_korecki'~'mdzk',
    name=='miedzyrzecz_podlaski'~'mdzp',

    TRUE~prefix
)]
# find the duplicated variable
src_names=src_names %>% data.table()
src_names[,dup:=1:.N,.(table,prefix3)]
src_names[,dup4:=1:.N,.(table,prefix4)]
src_names[,dup5:=1:.N,.(table,prefix5)]
src_names[,dup6:=1:.N,.(table,prefix6)]

# define the prefix as the minimum letters 3,4,5,6 letters

src_names=src_names  %>%  mutate(prefix=case_when(
    dup==1~prefix3,
    dup4>1~prefix4,
    dup5>1~prefix5,
    dup6>1~prefix6,
    TRUE~prefix
))  %>%  select(-dup,-dup4,-dup5,-dup6,-prefix3,-prefix4,-prefix5,-prefix6)
src_names  %>%  setDT()

