# 2. unify the tables to one table
list.dirs('.')
tables=list.files('./data/kalik/tables',full.names = TRUE)
tables %>% head()
tbls=lapply(tables,function(x) fread(x,header = TRUE))  %>% rbindlist(fill = TRUE)

# %%
# mutate the names and remove 'villages' addition
tbls=tbls  %>% mutate(
   village=as.numeric(grepl('village',name)|type=='villages'),
   suburb=as.numeric(grepl('suburb',name)|type=='suburb'),
   near=as.numeric(grepl('near',name)),
   total=as.numeric(type=='total')
)

tbls=tbls  %>% mutate(name=name %>% str_remove_all('village_near_|suburb_of_|small_towns_and_|village_|_village'))  %>% mutate(name=name  %>% str_remove_all('_and.*|_near_.*'))








