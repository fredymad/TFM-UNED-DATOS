# TFM-UNED-DATOS
Código generado para el TFM: Recognition of professions in medical documentation
Autor: Alfredo Madrid García

NotasARevisar.ipynb: code that employs a rule-based algorithm and an occupation gazetteer to identify letters with potential occupation mentions for annotation. This code applies to BARR2, CANTEMIST, CodiEsp, LivingNER, MEDDOCAN, and PharmaCoNER corpus.The output of this code is a list of names of potential notes.

ExtraccionNotas.ipynb: script that searches the notes to annotate identified by NotasARevisar. ipynb in the different corpora directories, and copies them into a specified destination folder.

DuplicadosNotas.ipynb: code that searches for duplicate notes in both the notes identified for annotation, and the MEDDOPROF training and test set. Since there are duplicate notes with the same name, duplicate notes with different name and duplicate notes with slightly differences such as, identation level; different techniques are applied for the identification of such notes. Therefore, this code implements preprocessing steps such as converting to lowercase, removing special characters and stopwords, stemming and TF-IDF vectorisation to eventually perform document similarity analysis. Finally, the notes identified by this script are manually assessed and removed where appropriate.

ProcesadoMOD.ipynb: code that splits .ann files with multiple annotations into .ann files retaining only the tags of interest. Therefore, the input of this code are annotated notes with BRAT standoff format. In this work, this script was used to split each .ann file annotated with both task 1 and task 2 entities, into two files, one for each task. In addition, this code identifies the .txt files with at least one related annotation. By default, BRAT creates an .ann file for each .txt file even if the .txt is not annotated with an entity. With this script, the .txt files are filtered, and only those with at least one annotation in their corresponding .ann file are kept

ConversorBRATIOB.ipynb: code to transform the .ann annotations into a suitable format that can be read and handled easily to construct the input to the neural network. Depending on the level of aggregation there are two options, aggregation at the clinical note level or at the sentence level. In both cases, brat_to_conll function from NeuroNER is used. This script facilitates data conversion from .ann BRAT standoff format to BIO, using spaCy as a tokenizer. The output of this code is a single file with the annotations in BIO. Each sentence is separated from the rest by a blank line, allowing the addition of a sentence identifier. For this script to work, both .ann and .txt files should be in the same directory, and a tokenizer and a language should be specified as function parameters. This code is used interchangeably in MOD and MEDDOPROF notes

EstadisticasMOD.ipynb: code that computes statistical measures to obtain insights from the MOD corpus, such as the distribution of entities; the minimum, maximum, average and total number of characters, tokens, entities and sentences per dataset. An equivalent code is built to obtain the MEDDOPROF corpus statistics EstadisticasMEDDOPROF.ipynb.

ModeloXXX.ipynb: main document for training the transformers models, postprocessing and evaluation.
