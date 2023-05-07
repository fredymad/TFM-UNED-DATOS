# Cargamos el directorio de trabajao
setwd("/Users/alfredomadrid/Desktop/TFM/Analisis de error")

# Los archivos NERGS y CLASSGS lo obtenemos tras haber pasado NeuroNER a todas las notas del conjunto de test.
# Es el mismo archivo que se encuentra en el drive NEURONER/Test/nerneuronersm_final.txt

# Los archivos CLASSPredicciones.txt los obtenemos después de lanzar el siguiente código:
# awk '{print $0,FILENAME}' *.txt >> ~/Desktop/prediccionesNER.txt
# Sobre los archivos del mejor modelo BIO (un archivo por nota clínica)
# Una vez pasado el codigo anterior reempalzamos los espacios por tabulaciones

# Cargamos las librerías necesarias
library(dplyr)

# Cargamos el gold standard
#GSNER <- read.table("CLASS/CLASSGS.txt", sep = " ", header = T, quote = "")
GSNER <- read.table("NER/NERGS.txt", sep = " ", header = T, quote = "")

# Eliminamos última columna
GSNER <- GSNER[-ncol(GSNER)]

# Cargamos las predicciones
#prediccionesNER <- read.table("CLASS/CLASSPredicciones.txt", sep = " ", quote = "")
prediccionesNER <- read.table("NER/NERPredicciones.txt", sep = " ", quote = "")

prediccionesNER <- prediccionesNER[-ncol(prediccionesNER)]

# Cambiamos los nombres
names(prediccionesNER) <- paste(names(GSNER),"pred",sep="_")
names(GSNER) <- paste(names(GSNER),"GS",sep="_")

# Juntamos ambos df
todo <- cbind(GSNER, prediccionesNER)

# Vemos si hay discrepancias en los tokens
all.equal(GSNER[,1], prediccionesNER[,1])

# Vemos que discrepancias hay
todo %>% filter(words_GS != words_pred)
# Vemos que las posiciones de los token está bien
todo %>% filter(start_GS != start_pred)
# Obtención de la matriz de confusión
table(todo$label_GS, todo$label_pred)

# Obtenemos un conjunto de datos en el que se identifiquen todos los errores
errores <- todo %>% filter(todo$label_GS != todo$label_pred)
aciertos <- todo  %>% filter(todo$label_GS == todo$label_pred)
nrow(errores)+nrow(aciertos) == nrow(prediccionesNER)

# Vemos en cuantas notas distintas hay errores 
length(unique(errores$fileId_GS))

# Guardamos únicamente las columnas necesarias
#write.table(todo, file ="CLASSFinalCompleto.txt", sep = "\t", row.names = FALSE)

# NO ejecutar
# write.table(todo %>% select(words = words_GS, gs = label_GS, pred = label_pred), file ="CLASSFinal.txt", sep = "\t", row.names = FALSE)

#todo <- todo %>% select(words = words_GS, gs = label_GS, pred = label_pred)

# Vamos a calcular los diferentes tipos de error según esta página web
# https://www.davidsbatista.net/blog/2018/05/09/Named_Entity_Evaluation/





