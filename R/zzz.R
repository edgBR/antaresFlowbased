# init options flowbased on load
.onLoad <- function(libname, pkgname){
  available_model <- list.dirs(system.file("input/model", package = "antaresFlowbased"), full.names = TRUE, recursive = FALSE)
  if(length(available_model) > 0){
    options(flowbased = list(path = available_model[1]))
  }
}


readIniFile <- antaresRead:::readIniFile

###Import antaresProcessing usefull funciton
.writeAllTables <- antaresProcessing:::.writeAllTables
.writeNewColumns <- antaresProcessing:::.writeNewColumns
.getDim <- antaresProcessing:::.getDim
.getIndexToWrite <- antaresProcessing:::.getIndexToWrite