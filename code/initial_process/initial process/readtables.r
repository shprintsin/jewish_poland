library(data.table)
library(tidyverse)


df <- fread("C:/home/users/desktop/pinkas/kalik/tables/csv_tables/table_14_8.csv",fill=TRUE)
df[1]


# read the tables then create a list of all avalliable tables
all_tables <- data.table()
columns_array <- c()
rows_dt <- data.table()
list_of_tables=c("1","2","3_1","3_2","4_1","4_2","5_1","5_2","6_1","6_2","6_3","6_4","6_5","6_6","6_7","6_8","7_1","7_2","7_3","8_1","8_2","8_3","9","10","11","12_1","12_2","12_3","12_4","13","14_1","14_2","14_3","14_4","14_5","14_6","14_7","14_8")
table_names <- paste0("table_",list_of_tables)
colnames(table_names)
for (i in 1:length(table_names)){
  dt=fread(paste0("csv_tables/",table_names[i],".csv"),header = F,fill = T)
  rows_num <- dt[,.(table=table_names[i],rows=.N)]
    rows_dt <- rbind(rows_dt,rows_num)
  colnames(dt)[colnames(dt) == "V1"] <- "new_table"
  dt[,line:=1:.N]
  dt[,table:=list_of_tables[i]]
  dt[new_table == "years"]
  
  columns_array=append(columns_array,nrow(dt))
  all_tables <- rbind(all_tables,dt,fill=TRUE)
}
rows_dt



####
# Get the unique table names
tables <- unique(df$table)

# Apply the operations to all tables
list_of_tables <- lapply(tables, function(x) {
  table_x <- df[table == x]
  table_x <- c(t(table_x[new_table == "years", -c("table", "line", "new_table", "row")]))
  table_x <- table_x[!is.na(table_x)]
  return(table_x)
})


# Name the list elements after the table names
names(list_of_tables) <- tables

# Create a list of data tables
list_of_data_tables <- lapply(names(list_of_tables), function(x) {
  data.table(table = paste0("table_", x), year = list_of_tables[[x]])
})

# Bind all data tables together
df <- do.call(rbind, list_of_data_tables)
df[stringr::str_starts(df$year,"census"),year:="census"]
df[stringr::str_starts(df$year,"Census"),year:="census"]
df[stringr::str_starts(df$year,"poll-tax"),year:="potential"]
df[stringr::str_starts(df$year,"poll tax"),year:="potential"]
df[stringr::str_starts(df$year,"Poll-tax"),year:="potential"]
df[stringr::str_starts(df$year,"Poll tax"),year:="potential"]
df[,.N,year][order(-year)]

tables <- dcast(df, year~table, value.var = "year")
tables %>% setDT()
tables[1:5]
tables[,table_1]
tables[,table_1:=as.numeric(year)*as.numeric(table_1)]
cols <- setdiff(names(tables), "year")
tables[, (cols) := lapply(.SD, function(x) as.numeric(year) * as.numeric(x)), .SDcols = cols]
write.csv(tables,"tables_years.csv")






fwrite(all_tables,"alltc.csv",bom=TRUE)



table_names="table_14_8"
rows_num <- dt[,.(table=table_names[i],rows=.N)]
rows_dt <- rbind(rows_dt,rows_num)
colnames(dt)[colnames(dt) == "V1"] <- "new_table"
dt[,line:=1:.N]
dt[,table:=list_of_tables[i]]


df=fread(paste0("csv_tables/",table_names,".csv"),header = F,fill = T)
new_rows <- df %>% filter(new_table=="years") %>%  group_by(table) %>% filter(!duplicated(V2))%>% select(table,V2,line,row) %>% setDT()
setorder(new_rows,table,V2)
start_rows <- df[new_table=="years"][row %in% new_rows$row]
start_rows <- start_rows[!duplicated(start_rows$row)]
df <- df[new_table!="years"]
df <- rbind(df,start_rows)
setorder(df,row)
df$new_table <- stringr::str_replace_all(df$new_table,"\\n"," ")
df$new_table <- stringr::str_replace_all(df$new_table,"\\r"," ")


df[new_table=="years",start_rows:=1]
df[,row:=.I]
nextTable <- df[start_rows==1][,lead(row)]
nextTable[length(nextTable)] <- nrow(df)+1
df[new_table=="years",nextTable:=..nextTable]
tables_location <- df[start_rows==1,.(table,row,nextTable,from_year=V2)]
tables_location[,to_year:=lead(from_year)]



process_table
# Assuming you have a data.table named 'df' with the necessary columns

process_table <- function(df, table_name) {
  df[new_table == table_name, start_rows := 1] 
  nextTable <- df[start_rows == 1][, lead(row)]
  nextTable[length(nextTable)] <- nrow(df) + 1
  df[new_table == table_name, nextTable := ..nextTable]
  
  tables_location <- df[start_rows == 1, .(table, row, nextTable, from_year = V2)]
  tables_location[, to_year := lead(from_year)]
}

process_subtable <- function(subtable_data) {
    first_row <- subtable_data[1, -c("start_rows", "nextTable", "row", "table", "line", "new_table")]
    range_columns <- !is.na(c(t(first_row[1])))
    other_columns <- subtable_data[, c("table", "line", "row")]
    year_columns <- subtable_data[, ..range_columns]
    colnames(year_columns) <- c(t(year_columns[1]))
    year_columns <- year_columns
    cbind(other_columns, year_columns)
}

  
  subtables <- list()
  for (i in seq_len(nrow(tables_location))) {
    subtable_info <- tables_location[i]
    subtable_data <- df[(subtable_info$row):(subtable_info$nextTable - 1)]
    # subtables[[i]] <- process_subtable(subtable_data)
  }
  


# Example usage
subtables <- process_table(df, "years")
subtables
process_subtable(subtable_data)
##
# Get the number of sub-tables
n_sub_tables <- nrow(tables_location)
# Initialize an empty list to store the standalone tables
standalone_tables <- vector("list", n_sub_tables)

# Loop over the sub-tables
for (i in seq_len(n_sub_tables)) {
  # Get the current sub-table location
  sub_table_location <- tables_location[i]
  sub_table <- df[(sub_table_location$row):(sub_table_location$nextTable - 1)]
  first_row <- sub_table[1, -c("start_rows", "nextTable", "row", "table", "line", "new_table")]
  range_columns <- !is.na(c(t(first_row[1])))
  other_columns <- sub_table[, c("table", "line", "row")]
  year_columns <- sub_table[, ..range_columns]
  print(c(t(year_columns[1,new_table])))
    # Set the column names of the year columns
  colnames(year_columns) <- c(t(year_columns[1]))
  
  # Combine the other columns and the year columns
  standalone_table <- cbind(other_columns, year_columns)
  
  # Store the standalone table in the list
  standalone_tables[[i]] <- standalone_table
}

# Loop over the standalone tables
for (i in seq_len(length(standalone_tables))) {
  # Get the current standalone table
  standalone_table <- standalone_tables[[i]]
  
  # Get the table and subtable names
  table_name <- tables_location[i, table]
  subtable_name <- i
  
  # Create the file name
  file_name <- paste0(table_name, "-sub-", subtable_name, ".csv")
  setDT(standalone_table)
  fwrite(standalone_table, file_name, row.names = FALSE,bom = TRUE)
  }


