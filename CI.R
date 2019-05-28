# This function calculates 95% CI around the rating curve

# a = CI_model_input
# b = n
# d = Span
# e = Expand

CI <- function(a,b,d,e){
  z <- nrow(a)
  CI_mod = data.frame(matrix(nrow = z, ncol = b))
  
  for(i in 1:b){
    CI_mod_input <- a[,c(1,i+1)]
    loessMod <- loess(Q ~ H, data = CI_mod_input, span=d)
    CI_mod[,c(i,i+b)] <- predict(loessMod, se = TRUE)
  }
  
  Q_est <- CI_mod[,1:b]
  se <- CI_mod[,(b+1):(b*2)]
  
  CI = data.frame(matrix(nrow = z, ncol = 2))
  
  for(j in 1:z){
    mean <- Q_est[j,]
    sd <- se[j,]
    CI[j,1] <- qmixnorm(0.95,mean, sd, expand = e)
    CI[j,2] <- qmixnorm(0.05,mean, sd, expand = e)
  }
  
  CI[CI <0] <- 0
  colnames(CI) <- c("Max_CI","Min_CI")
  return(CI)
  
}