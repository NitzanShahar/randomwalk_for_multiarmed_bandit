#example for generation of a random walk

#generating the randomwalk matrix (requires the library MASS to be installed)
source('./randomwalk.R')
  R=
  generate_randomwalk(Narms=4,           
                      Ntrials=200,
                      tau            =.02,#standard deviation for the noise normal distribution of each arm
                      rho            =0, #true correlation between all arms. default should be zero
                      upper.bound   =0.85,
                      lower.bound   =0.15)



#check correlations 
cor(R)
  

#plot
library(ggplot2)
library(tidyr)
library(dplyr)
    #convert to data frame, add trial column, and convert to a lng format for ggplot
    R      =R%>%as.data.frame()%>%mutate(trial=seq(1,dim(R)[1],1))%>%pivot_longer(!trial,names_to = 'arm', values_to='ev')
    #plot
    ggplot(R,aes(x=trial,y=ev,color=arm))+geom_line()

save(R,file='randomwalk_4arms_200trials.rdata')
write.csv(R,file='randomwalk_4arms_200trials.rdata')

