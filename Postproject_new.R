#count duplicates
sum(duplicated(data))
#remove duplicates
distinct(data)
#group and summerise
data %>% group_by(colmn name) %>% 
  summarise(
    mean_col = mean(colmn name),
    count = n()
  )
#Top 5 rows by values
slice_max(colmn name, n=5)