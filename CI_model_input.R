# This function provides the data input for CI.R

# a = HQ_unc
# b = n
# d = HQ

CI_model_input <- function(a,b,d){
  
  z = nrow(a)
  
  CI_Q_input = data.frame(matrix(nrow = z, ncol = b))
  
  for(j in 1:b){
    for(i in 1:z){
      model <- sample(as.numeric(a[i,]), 1)
      CI_Q_input[i,j] <- model
    }
    colnames(CI_Q_input)[j] <- "Q"
  }
  
  CI_model_input <- cbind(d$Stage_avg, CI_Q_input)
  colnames(CI_model_input)[1] <- "H"
  return(CI_model_input)
  
}
