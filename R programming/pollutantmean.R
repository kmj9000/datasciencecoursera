pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  readings <- vector()
  
  for(i in id) {
    monitorfile <- paste0(directory, "/", sprintf("%03d", i), ".csv")
    monitor <- read.csv(monitorfile)
    
    readings <- c(readings, monitor[,pollutant])
  }
  
  round(mean(readings, na.rm=TRUE), digits=3)
}