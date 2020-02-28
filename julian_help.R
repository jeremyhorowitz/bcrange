#here I am first plotting trends between mid latitude and range area size

#the slopes look similar despite being generated from different levels of 
#occurrence data/range type (lat only, geographic only, complete planar).
#This is the question we are addressing in our study.

#To test the effect of range type on the relationship between mid lat and
#range area, I need to make models to fit the data, then compare 
#the models with analysis of variance, to determine if the way the ranges
#are produced have an effect on the trend.

#I thought the below was how to run this analysis, but the results were not
#as expected. I now know that the below models are for linear regressions when they should be for
#something more similar to quadratic curves.



attach(pac_lat_all3)

three_lat_trends_pac<-ggplot(data=pac_lat_all3,aes(mid,area,colour=type))+
  geom_point()+
  geom_smooth(se=F,method=loess)+
  #scale_y_continuous(trans='log2')+
  xlab("mid latitude (degrees latitude)")+
  ylab("range area (m/m2)")
three_lat_trends_pac

what am i specifiing

mod1<-aov(area~mid*type,data=pac_lat_all3)
summary (mod1)

mod2<-aov(area~mid+type,data=pac_lat_all3)
summary (mod2)

anova(mod1,mod2)

AIC(mod1,mod2)
pred<-predict(mod2)

pred_lat_plot_pac<-ggplot(data=cbind(pac_lat_all3,pred),
                          aes(mid,area,color=type))+geom_point()+
  facet_grid(.~type)+geom_line(aes(y=pred))
pred_lat_plot_pac
