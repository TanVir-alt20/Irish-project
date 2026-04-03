data(iris)
#First look--------------
head(iris)
tail(iris)
dim(iris)
str(iris)
colnames(iris)
summary(iris)
#check quality----------
is.na(iris)
sum(duplicated(iris))
iris[duplicated(iris), ]
distinct(iris)
iris_clean <- iris[!duplicated(iris), ]
iris_clean[duplicated(iris_clean), ]
sum(duplicated(iris_clean))
#clean & transform------
colnames(iris_clean)[colnames(iris_clean) == "Sepal.Length"] <- "SepalLength"
colnames(iris_clean)[colnames(iris_clean) == "Sepal.Width"] <- "SepalWidth"
colnames(iris_clean)[colnames(iris_clean) == "Petal.Length"] <- "PetalLength"
colnames(iris_clean)[colnames(iris_clean) == "Petal.Width"] <- "PetalWidth"
colnames(iris_clean)
iris_clean$PetalRatio <- iris_clean$PetalLength / iris_clean$PetalWidth
#explore with dplyr------------
library(dplyr)
iris_clean <- iris_clean %>% mutate(
  SepalRatio = SepalLength / SepalWidth
)
colnames(iris_clean)
iris_clean %>% filter(Species == "setosa")
unique(iris_clean$Species)
table(iris_clean$Species)

iris_clean %>% filter(Species == "setosa") %>% summarise(mean(SepalLength))
mean(iris_clean$SepalLength[iris_clean$Species == "versicolor"], na.rm = F)
iris_clean %>% filter(Species == "virginica") %>% summarise(mean(SepalLength))

iris_clean %>% slice_max(PetalLength, n=5)
which(iris_clean$Species == "setosa")
table(iris_clean$Species)

#summarize-----------
iris_setosa <- iris_clean %>% filter(Species == "setosa")
summary_setosa <- summary(iris_setosa)
iris_versicolor <- iris_clean %>% filter(Species == "versicolor")
summary_versicolor <- summary(iris_versicolor)
iris_virginica <- iris_clean %>% filter(Species == "virginica")
summary_virginica <- summary(iris_virginica)

summary_setosa <- as.data.frame.matrix(summary_setosa)
summary_versicolor <- as.data.frame.matrix(summary_versicolor)
summary_virginica <- as.data.frame.matrix(summary_virginica)
#export--------
library(data.table)
fwrite(iris_clean, "irish_cleaned.csv", row.names = FALSE)
fwrite(summary_setosa, "summary_setosa.csv", row.names = FALSE)
fwrite(summary_versicolor, "summary_versicolor.csv", row.names = FALSE)
fwrite(summary_virginica, "summary_virginica.csv", row.names = FALSE)




# Replace your 3 separate summaries with this:
species_summary <- iris_clean %>%
  group_by(Species) %>%
  summarise(
    mean_SepalLength = mean(SepalLength),
    mean_SepalWidth  = mean(SepalWidth),
    mean_PetalLength = mean(PetalLength),
    mean_PetalWidth  = mean(PetalWidth),
    mean_PetalRatio  = mean(PetalRatio),
    count            = n()
  )

# Export this single clean summary
fwrite(species_summary, "species_summary.csv")



irish_max_petallngth <- iris_clean %>%
  group_by(Species) %>% summarise(
    max_petal_length = max(PetalLength)
  ) %>% data.table::fwrite("maxpetalength.csv")

