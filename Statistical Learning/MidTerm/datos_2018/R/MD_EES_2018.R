#################################################################################
# Nombre del programa:	MD_EES_2018.R                                          
# Autor:              	INE & Marcos Crespo
# Version:            	4.1
# Ultima modificacion: 	22 de febrero de 2024
#                                                                                
# Descripcion: 
#	Este programa procesa un fichero de microdatos (md_EES_2018.txt)
#   a partir de un fichero de metadatos (dr_EES_2018.xlsx) que contiene 
#   el diseño de registro del archivo de microdatos. 
#     EES.: Operacion estadistica
#     2018: Año(s) de produccion de los datos
#
# Entrada:                                                           
#     - Diseño de registro: 	dr_EES_2018.xlsx
#     - Archivo de microdatos: 	md_EES_2018.txt
# Salida: 
#     - Archivo de microdatos en formato data.frame de R: fichero_salida 
#                                                                                
#################################################################################


assign("flag_num", 0, envir = .GlobalEnv)

atencion = function(mensaje){
  cat(mensaje)
  assign("flag_num", 1, envir = .GlobalEnv)
  
}

library(openxlsx)

####################    Asignacion de parametros    #######################
#Recogemos la ruta del script que se esta ejecutando

fichero_micro <- "md_EES_2018.txt"
fichero_meta  <- "dr_EES_2018.xlsx"

####################     INICIO     #########################
start.time <- Sys.time()
cat("\n")
cat("\n Inicio: ")
print.Date(start.time)
t0 <- proc.time()

#Lectura del fichero de metadatos (METAD), Hoja "Dise?o" de archivo .xlsx
workBook <- loadWorkbook("dr_EES_2018.xlsx")
df <- read.xlsx(workBook, namedRegion = "METADATOS")


nombresVarbls <- df[,1]
nombresTablas <- df[,2]
posiciones    <- df[,3]
tipo          <- df[,4]
tamanio       <- length(nombresVarbls)

# Lectura del fichero de microdatos (MICROD)
if(length(df) == 4){
  cat("Sin formato")
  
  #Capturamos las columnas con su tipo de dato
  tipDatos <- as.vector(sapply(df[,4], function(x){
    if(identical(x, "A"))
      "character"
    else{
      if(identical(x, "N"))
        "numeric"
    }
  }
  )
  )
  # Lectura del fichero de microdatos (MICROD), decimales con punto en MD  
  tryCatch((df1 <- read.fwf(file = fichero_micro, widths= posiciones, colClasses=tipDatos)), error=function(e)
    stop(paste("Error. No se encuentra el fichero: ", e, fichero_micro,". Saliendo de la ejecuci?n...", sep = "")))
  
}else{
  formatos <- df[,5]  
  cat("Con formato")
  
  # Lectura del fichero de microdatos (MICROD), decimales sin punto en MD
  tryCatch((df1 <- read.fortran(file = fichero_micro, format= formatos)), error=function(e)
    stop(paste("Error. No se encuentra el fichero: ", e, fichero_micro,". Saliendo de la ejecuci?n...", sep = "")))
}

#Aplicamos los nombres de la cabecera del registro
names(df1) <- df[,1]
fichero_salida <- df1


#Liberacion de memoria y aclaraci?n de variables 
#Values
rm(flag_num,workBook,nombresVarbls,nombresTablas,posiciones,tamanio,df,df1)
if(length(df) == 4){rm(tipDatos)}


# Mensaje final ##########################################
end.time <- Sys.time()
cat("\n")
cat("\n Fin del proceso de lectura: ")
print.Date(end.time)

TTotal <- proc.time() - t0
tiempo <- TTotal[3]

if(tiempo < 60){
  cat(paste("\n Tiempo transcurrido:", format(round(tiempo, 2), nsmall = 2), "segundos"))
}else{
  if(tiempo< 3600 & tiempo >= 60){
    cat(paste("\n Tiempo transcurrido:", format(round(tiempo/60, 2), nsmall = 2), "minutos"))
  }else{
    cat(paste("\n Tiempo transcurrido:", format(round(tiempo/3600, 2), nsmall = 2), "horas"))
  }
}










