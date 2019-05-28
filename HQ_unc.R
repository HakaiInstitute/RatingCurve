# This function adds the uncertainty in stage to discharge uncertainty 

# x = HQ
# y = Rating
# z = Rating_extrap_interp

HQ_unc <- function(x,y,z){

HQ_unc <- x %>% 
  select(Stage_avg, Stage_stdv, Q_meas, Q_rel_unc) 
HQ_unc <- merge(HQ_unc, y, by.x = "Stage_avg") 
HQ_unc <- HQ_unc %>%
  mutate(Stage_add_stdv = Stage_avg + Stage_stdv) %>% 
  mutate(Stage_add_stdv = round(Stage_add_stdv, digits = 1))
Rating_temp <- z
names(Rating_temp) <- c("Stage_add_stdv", "Q_model_add_stdv")
Rating_temp <- Rating_temp %>% 
  mutate(Stage_add_stdv = round(Stage_add_stdv, digits = 1))
HQ_unc <- merge(HQ_unc, Rating_temp)
HQ_unc <- HQ_unc %>%
  arrange(Stage_avg) %>% 
  mutate(Rel_unc_stage = (Q_model_add_stdv - Q_model)/Q_model*100) %>% 
  mutate(Rel_unc_stage = ifelse(Rel_unc_stage < 0, 0, Rel_unc_stage)) %>% 
  mutate(Q_H_rel_unc = sqrt((Q_rel_unc^2)+(Rel_unc_stage^2))) %>% 
  mutate(Q_H_abs_unc = (Q_H_rel_unc/100) * Q_meas) %>% 
  select(Stage_avg, Q_meas, Q_H_abs_unc)

HQ_unc <- HQ_unc %>% 
  select(Q_meas, Q_H_abs_unc) %>%  
  mutate(Q_max = Q_meas + Q_H_abs_unc) %>% 
  mutate(Q_min = Q_meas - Q_H_abs_unc) %>% 
  select(Q_meas, Q_max, Q_min)
}