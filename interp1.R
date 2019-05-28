# Interpolate values between data points for each mm of stage

interp1 <- function(x){
  # Round stage to 1 digit and Q_model to 4 digits 
  x <- x %>% 
  mutate(Stage_avg = round(Stage_avg, digits = 1)) %>% 
  mutate(Q_model = round(Q_model, digits = 4))

  # Interpolate values within measurement points
  Rating_interp <- as.data.frame(approx(x$Stage_avg, x$Q_model, method = "linear", n = ((max(x$Stage_avg)*10 + 1)- (min(x$Stage_avg)*10))))
  return(Rating_interp)
}