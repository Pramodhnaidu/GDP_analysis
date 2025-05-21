library(tidyverse)
library(janitor)
library(stringr)


dir()

dir(path = "GDP Data")
 read.csv("GDP Data/NAD-Andhra_Pradesh-GSVA_cur_2016-17.csv" ) -> ap_df1
 
 
 
 
 ap_df1 %>% pull(Item) 

 ## diff method 
 
 "NAD-Andhra_Pradesh-GSVA_cur_2016-17.csv" %>% 
   str_split("-") %>% 
   unlist() -> state_name_vector
 
 state_name_vector[2] ->st_name
 
 
 
 ap_df1 %>% 
   slice(-c(7,11,27:33)) %>% 
   pivot_longer(-c(1,2), names_to = "Year", values_to = "gsdp") %>% 
   clean_names() %>% 
   select(-1) %>%
   mutate(state = st_name) -> ap_state_data
 
 
 
 ## 
dir(path = "GDP Data",
    pattern = "NAD") -> state_files

state_files


tempdf<- tibble()
for (i in state_files ) {
  print(paste0("File name:" ,i ))
i %>% 
  str_split("-") %>% 
  unlist() -> state_name_vector

state_data_vector[2]  -> st_name 
print(paste0("state name:", i))

paste0("GDP Data/", i) %>% 
  read_csv() -> st_df1

st_df1 %>% 
  slice(-c(7,11,27:33)) %>% 
  pivot_longer(-c(1,2), names_to = "Year", values_to = "gsdp") %>% 
  clean_names() %>% 
  select(-1) %>%
  mutate(state = st_name) -> state_df
print(state_df)
bind_rows(tempdf , state_df) -> tempdf
}

tempdf -> final_statewise_gsdp
## step 5 
## save the final_statewise_gsdp in csv 

final_statewise_gsdp %>% 
  write_csv("final_statewise_gsdp.csv")




