# Interpolate values between data points for each mm of stage

interp2 <- function(x){
  # Round stage to 1 digit and Q_model to 4 digits 
  x <- x %>% 
    mutate(Stage_avg = round(Stage_avg, digits = 1)) %>% 
    mutate(Q_model = round(Q_model, digits = 4)) %>% 
    mutate(Max_CI = round(Max_CI, digits = 4)) %>% 
    mutate(Min_CI = round(Min_CI, digits = 4))

  # Interpolate values within measurement points
  interp_Q_model <- as.data.frame(approx(x$Stage_avg, x$Q_model, method = "linear", n = ((max(x$Stage_avg)*10 + 1)- (min(x$Stage_avg)*10))))
  names(interp_Q_model) <- c("Stage_avg", "Q_model")
  interp_Max_CI <- as.data.frame(approx(x$Stage_avg, x$Max_CI, method = "linear", n = ((max(x$Stage_avg)*10 + 1)- (min(x$Stage_avg)*10))))
  names(interp_Max_CI) <- c("Stage_avg", "Max_CI")
  interp_Min_CI <- as.data.frame(approx(x$Stage_avg, x$Min_CI, method = "linear", n = ((max(x$Stage_avg)*10 + 1)- (min(x$Stage_avg)*10))))
  names(interp_Min_CI) <- c("Stage_avg", "Min_CI")
  
  interp_all <- merge(interp_Q_model, interp_Max_CI, by.x = "Stage_avg")
  interp_all <- merge(interp_all, interp_Min_CI, by.x = "Stage_avg")
  interp_all <- interp_all %>% 
    mutate(Q_model = round(Q_model, digits = 4)) %>% 
    mutate(Max_CI = round(Max_CI, digits = 4)) %>% 
    mutate(Min_CI = round(Min_CI, digits = 4))
  return(interp_all)
}