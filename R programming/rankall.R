rankall <- function(outcome, num = "best") {
  
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  
  ## Check that state and outcome are valid
  vOutcomes <- c("heart attack", "heart failure", "pneumonia", 
                 "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", 
                 "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", 
                 "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
  dim(vOutcomes) <- c(3, 2)
  
  if(!is.element(outcome, vOutcomes[,1]))
    stop("invalid outcome")
  
  ## For each state, find the hospital of the given rank
  states <- sort(unique(data$State))
  result <- c()
  
  for(s in states) {
    colName <- vOutcomes[vOutcomes[,1] == outcome, 2]
    stateData <- data[data$State == s,]
    stateData[,colName] <- suppressWarnings(as.numeric(stateData[,colName]))
    stateData <- na.omit(stateData)  
    
    ranked <- stateData[order(stateData[, colName], stateData[, "Hospital.Name"], na.last=TRUE),]
    
    target <- ifelse(num == "best", 1, ifelse(num == "worst", nrow(ranked), num))
    record <- ranked[target, c("Hospital.Name", "State")]
    record$State <- s
    result <- rbind(result, record)
  }
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  colnames(result) <- c("hospital", "state")
  result
}
