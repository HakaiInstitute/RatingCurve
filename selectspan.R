# This function plots three loess fits with different span widths

selectspan <- function(x,a,b,c){
  span_a <- predict(loess(Q_meas ~ Stage_avg, data=x, span=a))
  span_a <- as.data.frame(span_a)
  span_b <- predict(loess(Q_meas ~ Stage_avg, data=x, span=b))
  span_b <- as.data.frame(span_b)
  span_c <- predict(loess(Q_meas ~ Stage_avg, data=x, span=c))
  span_c <- as.data.frame(span_c)
  def_span_shift <- bind_cols(x, span_a, span_b, span_c)
  def_span_shift <- def_span_shift %>% 
    select(Stage_avg, span_a, span_b, span_c) %>% 
    gather(key = smoothed, value = Q_model, span_a:span_c)
}