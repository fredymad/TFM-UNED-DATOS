# Se carga el directorio de trabajo
setwd("~/Desktop/TFM/Código/Estadisticas y overlap/Meddoprof")

# Se cargan las librerias necesarias
library(dplyr)
library(stringi)
library(stringr)

# Descripción de la primera tarea para el conjunto de entrenamiento y de test
task1train <- read.table(file = "task1combinadotrainann.txt", sep = "\t", col.names =  c("Tag", "Entity", "start", "end", "freetext", "document"))
# Número de palabras por entidad
task1train$n_palabras <- str_count(task1train$freetext, "\\w+")
task1test <- read.table(file = "task1testcombinadoann.txt", sep = "\t", col.names =  c("Tag", "Entity", "start", "end", "freetext", "document"), quote = "")
# Número de palabras por entidad
task1test$n_palabras <- str_count(task1test$freetext, "\\w+")

# Vemos cómo se distribuyen las anotaciones del conjunto de train para la primera tarea
table(task1train$Entity)
table(task1test$Entity)

# Descripción de la segunda tarea para el conjunto de entrenamiento y de test
task2train <- read.table(file = "task2combinadotrainann.txt", sep = "\t", col.names =  c("Tag", "Entity", "start", "end", "freetext", "document"))
task2train$n_palabras <- str_count(task2train$freetext, "\\w+")
task2test <- read.table(file = "task2testcombinadoann.txt", sep = "\t", col.names =  c("Tag", "Entity", "start", "end", "freetext", "document"), quote = "")
task2test$n_palabras <- str_count(task2test$freetext, "\\w+")

# Vemos cómo se distribuyen las anotaciones del conjunto de train para la primera tarea
table(task2train$Entity)
table(task2test$Entity)

# Vemos el número de palabras por entidad
quantile(task1train$n_palabras)
quantile(task1test$n_palabras)
quantile(task2train$n_palabras)
quantile(task2test$n_palabras)

# Para obtener la media, Q1, Q3 por tipo de entidad
prueba <- task1train  %>%
  group_by(Entity) %>%
  summarise(quantile(n_palabras))
