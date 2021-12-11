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


  



generate_randomwalk<-function(Narms,Ntrials,tau,rho,
                              upper.bound,lower.bound){
  browser()
  #pre-allocate matrix with random starting points
  R          =matrix(NA,Ntrials,Narms)
  R[1,]      =lower.bound+(upper.bound-lower.bound)*runif(Narms)
  
  
  #generate the randomwalk
  for(t in 2:Ntrials){
    for(arm in 1:Narms){
    R[t,arm]=R[t-1,]+rho*R[t-1,-arm]+rnorm(1)
    }
    R[t,R[t,]>upper.bound]=  upper.bound
    R[t,R[t,]<lower.bound]=  lower.bound
  }
  
  #add column names
  colnames(R) <- paste0("arm_", 1:Narms)  
  
  return(R)
  
}

tau=0.02
rho=-1
Narms=4
tau        = rep(tau,Narms)  
cor_u      = matrix(rep(rho, Narms^2), nrow = Narms)  
diag(cor_u)= 1
Sigma_u    = diag(tau, Narms, Narms) %*%  cor_u %*%  diag(tau, Narms, Narms) #converting cor matrix to var-cov matrix

MASS::mvrnorm(n = 1, rep(0, Narms), Sigma_u)
