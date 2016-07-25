#para leer el archivo de anotacion es importante especificar que los nombres de las columnas estan separados por comas.
#stringsAsFactors = false permite que se almacenen las entradas como cadenas de caracteres en lugar de factores.
data<-read.table("annot.csv", header=TRUE,sep=",",stringsAsFactors=FALSE)
#la columna 31 del archivo de anotacion es la que contiene los procesos asociados a cada molecula.
procesos<-data[,31]
#grepl devuelve un vector con valores T/F dependiendo si una entrada contiene o no el patron especificado.
#el primer parametro es el patron que quiero buscar, el segundo es el vector en donde busco, el tercero es T por que usa la estructura de busqueda de perl.
confirmacion<-grepl("inflammatory", procesos, perl=TRUE)
#extraer la lista de nombres con el gene id que se encuentra en la columna 15 del archivo de anotacion
nombres<-data[,15]
#extraemos los elementos en "nombres" que corresponden a TRUE en "confirmacion"
nombresfiltrados<-nombres[confirmacion]
#extraemos la columna de affy ids y lo filtramos con "confirmacion"
affiids<-data[,1]
affiidfiltrados<-affiids[confirmacion]
#lo mismo con los procesos
procesosfiltrados<-procesos[confirmacion]
#unimos las listas filtradas en un solo objeto
listafiltrada<-data.frame(affiidfiltrados,nombresfiltrados,procesosfiltrados)
#creamos un archivo con la lista filtrada y uno con los affyids
write.table(listafiltrada,file="lista", sep = ",",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE
            )
