# Se carga el directorio de trabajo
setwd("/Users/alfredomadrid/Desktop/TFM/Corpus convertido/Comprobacion overlapp")

# Se cargan las librerias necesarias
library(dplyr)
# Se lee el archivo
task1train <- read.table(file = "Meddoprof/task1combinadotrainann.txt", sep = "\t", col.names =  c("Tag", "Entity", "start", "end", "freetext", "document"))
# Se localizan los overlap
data <- task1train %>%
  #select(document, start, end) %>%
  group_by(document) %>%
  arrange(document, start, end) %>%
  mutate(overlap = ifelse(start <= lag(end), 1, 0))
