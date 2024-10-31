library(readxl)
library(tidyverse)
library(data.table)
setwd('jewish_professions')
list.files('csv')
rbind(fread('csv/profession_1.csv')  %>% select(prf=v5),
fread('csv/profession_2.csv')  %>% select(prf=v4))  %>% mutate(prdf= prf  %>%  str_to_lower()  %>% str_remove_all('\\d')) 

df=rbind(fread('csv/profession_1.csv')  %>% select(st,line=v1,name=v4,prf=v5,cname),
fread('csv/profession_2.csv')  %>% select(st,line=v1,name=v3,prf=v4)  %>% mutate(cname=name  %>%  str_to_lower()  %>% str_remove_all('\\d|-.*')))

df=df  %>%  left_join(
fread('name_dict_full.csv') %>% filter(!duplicated(cname)) ,'cname'
) 

pl_dict=fread('prf_dict.csv')
pl_dict=pl_dict  %>% filter(!duplicated(prfd))
df=df  %>% mutate(prfd=prf  %>%  str_to_lower()  %>% str_remove_all('\\d'))  %>% left_join(pl_dict,by='prfd')

df[category==1,.N,.(profession)][,.(profession,prcntg=100*N/sum(N),N)] %>% mutate(prcntg=round(prcntg))   %>% arrange(-prcntg)  %>% fwrite('prf_count.csv',bom=TRUE)
df[,.N,.(category,profession)]  %>% pivot_wider(names_from=category,values_from=N)  %>% fwrite('prf_count.csv',bom=TRUE)
df  %>% select(cname)  %>% filter(!duplicated(cname))  %>% fwrite('name_dict.csv',bom=TRUE) 


fread('all_ac8.csv') 

 %>% select(v4)



res=fread('all_ac_1_m.csv')  %>%  mutate(
    v1= v1  %>% str_remove_all('"'),
    v2= v2  %>% str_remove_all('"'),
    v3= v3  %>% str_remove_all('"'),
    v4 =  v4  %>% str_remove_all('"'),
    v5= v5  %>% str_remove_all('"'),
    v6= v6  %>% str_remove_all('"'),
    cname= cname  %>% str_remove_all('"')
)  %>% mutate(id=1:n())   %>% left_join(nl,by='id')  


res  %>%  filter(category==1)  %>% filter(prf=v5)


res[category==1,.N,v5]
