# %%
# Assign source names to 'assign_viv' for further modifications
assign_viv <- src_names
# Update prefix ('prefix') of specific trouble maker
assign_viv <- assign_viv %>%
  mutate(
    prefix = case_when(
      name == 'miedzyrzecz_podlaski' ~ 'mdzp',
      TRUE ~ prefix
    )
  )
# %%
# Assign voivodeship categories ('viv_e') based on 'table' and 'prefix' values

assign_viv=assign_viv  %>%  mutate(
    viv_e= case_when(
        table=='0100' & prefix %in%   c('cch','grd','jbl','ksc','nr','wys','wysk','maz') ~ 'maz',
        table=='0100' & prefix %in%    c('jzf','jzfw','lbln','glsk','gls','lbl')  ~ 'lbl',
        table=='0100' & prefix %in%    c('kzmr','kzm')  ~ 'krk',
        table=='0100' & prefix %in%    c('mdzy')  ~ 'wol',
        table=='0100' & prefix %in%    c('mdzp','smt')  ~ 'pdl',
        table=='0100' & prefix %in%    c('pzn')  ~ 'pzn',
        table=='0100' & prefix %in%    c('prz')  ~ 'rus',
        table=='0100' & prefix %in%    c('dbc')  ~ 'snd',     
        table=='0200' & prefix %in%   c('czd','nby','bnl','fry','glg','rpc','sdr','str','wlp','dbc') ~ 'snd',
        table=='0200' & prefix %in%   c('rzw') ~ 'swr',
        table=='0200' & prefix %in%   c('krs') ~ 'rus',
        table=='0200' & prefix %in%    c('blz','rzs','tyc','tycz') ~ 'rus',
        table=='0301' &prefix %in%  c("gwr",'klc','klz','stw','stws',"jbl","lpn","mys","nwg","rdk") ~ 'maz',
        table=='0301' &prefix %in%  c("snd",'sndw',"stq","trs","zmb","zwd","zwdw",'zwdq') ~ 'maz',
        table=='0301' &prefix %in%  c("grj","jdw","szc","wzn") ~ 'maz',
        table=='0302' ~ 'pdl',
        table=='0401' ~ 'maz',
        table=='0402' ~ 'pdl',
        table=='0501' ~ 'blz',
        table=='0502' & prefix %in%    c( 'mdl', 'blgr','blg','grz','mdk','pls') ~ 'lbl',
        table=='0502' & prefix %in%    c( 'szc', 'mcj', 'mcjw', 'skr', 'krl', 'kry', 'trb','chlm','chl','hls','hrbs','hrb','krsn','krs','krl','lbm','lbml','rtn','rjw','sdl','swrz','swr','trng','trn','wjs','pln','rtn','rjw','swr','trn','chn','wsj') ~'rus',
        table=='0502' & prefix %in%    c("snw") ~ 'rus',
        table=='0601' & prefix %in%    c('brt','cbr','fjw','str','plw','pkr','szm','trn','wlw') ~ 'chl',
        table=='0601' & prefix %in%    c('ksz') ~ 'mlb',
        table=='0601' & prefix %in%    c('czl','czlc','gdn','hmm','ksc','mra','nw','pck','swc','tcz','tch','tchl','mrc') ~ 'pom',
        table=='0602' & prefix %in%   c( 'dbr','frd','inw','kkl','lpn','rdz','zld','zldw', 'nwr' )~'inw',
        table=='0602' & prefix %in%  c( 'brz','kjw','zbc','kwl', 'lbr', 'lbrnc', 'ptr','kja','prz','str')~'kij',
        table=='0603' & prefix %in% c('cnj','mkw','nsl','rzn','wys','wysk')~ 'kls',
        table=='0603'~ 'kls',
        # table=='0603' & !prefix %in% c('bls','bls','brz','dbr','grb','kpn','ltm','lsk','ptr','try','wtr','wdw','wrs','zlc')~ 'kls',
        table=='0604' ~ 'lcz',
        table=='0605' & prefix %in% c('cch','mkw','nsl','rzn','wys') ~'maz',
        table=='0605' & prefix %in% c( 'bls', 'blslw', 'brz','dbr','grb','kpn','ltm','lsk','ptr','try','tsz', 'wrt','wdw','wrs', 'zlc', 'zlcz' ) ~'swr',          
        table=='0606' ~ 'plc',
        table=='0607' ~ 'pzn',
        table=='0608' ~ 'raw',
        table=='0701' ~ 'krk',
        table=='0702' & prefix %in%    c("dzl","kmn","knc","prs") ~ 'sier',
        table=='0702' & prefix %in%    c('wrs','bkw','jcm','nwt','rym','sch') ~'raw',
        table=='0702' & !prefix %in%   c('bkw','jcm','nwt','rym')~'maz',      
        table=='0703' ~ 'snd',
        table=='0801' ~ 'lbl',
        table=='0802' & prefix %in%    c('bl','glw', 'nwm', 'nwms', 'str','rw','plc') ~ 'raw',
        table=='0802' & prefix %in%   c( 'drw','grw','grs','grj','klb', 'ltw', 'ltwo', 'ltwc', 'gsz', 'pry', 'kby', 'mcj', 'mcjw', 'zrw', 'wrs', 'wrsw', 'lsk', 'msj','mgn','mns','mzw','mns','sck','prt', 'psc','prz','rz','skb','sbk','wrk','wrs') ~ 'maz',
        table =='0803' ~ 'snd',
        table=='0900' & prefix %in%    c("blgt", 'blgr', 'pls', 'mdl','blg','frn',"frnn",'frn',"grz","gry","mdlb","plz","wys",'tms') ~'lbl',
        table=='0900' & prefix %in%    c("krs","szc","trb","zms","zlk")  ~ 'rus',
        table=='0900' & prefix %in%    c("trn","rzw","lnw","knm","snd") ~'snd',
        table=='0900' & prefix %in%    c("lsz") ~'blz',        
        table=='1000' & prefix==       'czn' ~ 'brc',
        table=='1000' & prefix!=       'czn' ~ 'pod',
        table=='1100' & prefix %in%    c('dbc','dyd','dyn','zdb','jwrn','rsk') ~ 'rus',
        table=='1100' & prefix %in%    c('wlk')~'blz',
        table=='1100' & !prefix  %in%     c('dbc','dyd','dyn','zdb','jwrn','rsk','wlk')~'rus',
        table=='1201' & prefix %in%    c('brs','bsw','dzw') ~ 'brc',
        table=='1201' & prefix %in%    c('ldw','znk','ktj') ~ 'pod',
        table=='1201' & !prefix %in%    c('ldw','znk','ktj','brs','bsw','dzw') ~ 'kij',
        table=='1202'~'hlc',
        table=='1203'~'lww',        
        table=='1204' & prefix %in%    c("chlm","mgr")~'blz',
        table=='1204' & prefix %in%    c("drh","rd","ksl","str")~'rus',
        table=='1204' & prefix %in%    c("blg","lsk","mrz","snk","tyr",'wls')~'wol',
        table=='1204' & prefix %in%    c("zls") ~ 'rus',
        table=='1300'~'prz',
        table=='1401' ~ 'wol',
        table=='1402' & prefix %in%    c('czr')~'pod',
        table=='1402' & !prefix %in%    c('czr')~'wol',
        table=='1403' ~ 'wol',
        table=='1404' & prefix %in%    c('lnw')~'pod',
        table=='1404' & !prefix %in%    c('lnw')~'brc',
        table=='1405' ~ 'kij',
        table=='1406' ~ 'wol',
        table=='1407' ~ 'kij',
        table=='1408'  & prefix %in%    c('str')~'blz',
        table=='1408'  & !prefix %in%    c('str')~'wol'
    )
)

