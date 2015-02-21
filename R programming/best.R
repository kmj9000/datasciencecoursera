best <- function(state, outcome) {
  
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  
  ## Check that state and outcome are valid
  if(!is.element(state, data$State))
    stop("Invalid state")
  
  vOutcomes <- c("heart attack", "heart failure", "pneumonia", 
                "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", 
                "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", 
                "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
  dim(vOutcomes) <- c(3, 2)
  
  if(!is.element(outcome, vOutcomes[,1]))
    stop("invalid outcome")
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  colName <- vOutcomes[vOutcomes[,1] == outcome, 2]
  stateData <- data[data$State == state,]
  stateData[,colName] <- suppressWarnings(as.numeric(stateData[,colName]))
  stateData <- na.omit(stateData)
  
  ranked <- stateData[order(stateData[,colName], na.last=TRUE),]
  
  ranked[1, "Hospital.Name"]
}