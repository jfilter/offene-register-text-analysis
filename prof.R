# Source: https://joachim-gassen.github.io/2019/02/german-female-corporate-officers-where-are-you/

library(DBI)
library(tidyverse)
library(ggmap)
library(rgdal)
library(rgeos)

# You will also need the packages R.utils, maproj, and RSQLite to run this code

tmp <- tempdir()
download.file("https://daten.offeneregister.de/openregister.db.gz", 
              destfile = file.path(tmp, "openregister.db.gz"))
db <- R.utils::gunzip(file.path(tmp, "openregister.db.gz"))
con <- dbConnect(RSQLite::SQLite(), db)

sql <- "select id, company_number as company_id, current_status, retrieved_at, registered_address from company"
res <- dbSendQuery(con, sql)
company <- dbFetch(res)
dbClearResult(res)
sql <- "select id as officer_id, company_id, firstname, start_date, end_date, dismissed from officer"
res <- dbSendQuery(con, sql)
officer <- dbFetch(res)
dbClearResult(res)
dbDisconnect(con)

company %>%
  filter(current_status == "currently registered",
         !is.na(registered_address)) %>%
  mutate(plz = str_extract(registered_address, "\\d{5}")) %>%
  filter(plz != "") %>%
  select(company_id, plz) -> company_plz

officer %>%
  filter(firstname != "",
         !is.na(firstname),
         is.na(dismissed)) -> officer_firstname

company_plz %>%
  left_join(officer_firstname) %>%
  filter(!is.na(firstname)) -> company_firstname

nl <- read_csv2("https://raw.githubusercontent.com/MatthiasWinkelmann/firstname-database/master/firstnames.csv") %>%
  rename(firstname = name) %>%
  select(firstname, gender) %>%
  group_by(firstname) %>%
  filter(n() == 1) %>%
  ungroup()

company_firstname %>%
  left_join(nl) %>%
  filter(gender == 'M' | gender == 'F') -> plz_name_gender

plz_name_gender
