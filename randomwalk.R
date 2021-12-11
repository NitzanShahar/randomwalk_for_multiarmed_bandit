generate_randomwalk<-function(Narms,Ntrials,tau,rho,
                              upper.bound,lower.bound){
  library(MASS) 
  
  #the aim of this function is to generate a randomwalk according
  #Narms       - the number of arms
  #Ntrial      - the number of trials
  #tau         - the noise variance 
  #rho         - the true correlation between the expected values for each arm
  #upper.bound - the maximum upper limit
  #lower.bound - the maximum lower limit
  
  #calculate var-cov matrix (i.e., Sigma) according to tau and rho
  #this will be later used as the var-cov matrix for a multivariate normal distribution that will generate noise for the randomwalk
  tau        = rep(tau,Narms)  
  cor_u      = matrix(rep(rho, Narms^2), nrow = Narms)  
  diag(cor_u)= 1
  Sigma_u    = diag(tau, Narms, Narms) %*%  cor_u %*%  diag(tau, Narms, Narms) #converting cor matrix to var-cov matrix
  
  #pre-allocate matrix with random starting points
  R          =matrix(NA,Ntrials,Narms)
  R[1,]      =lower.bound+(upper.bound-lower.bound)*runif(Narms)
  
  
  #generate the randomwalk
  for(t in 2:Ntrials){
    R[t,]=R[t-1,]+MASS::mvrnorm(n = 1, rep(0, Narms), Sigma_u)
    
    R[t,R[t,]>upper.bound]=  upper.bound
    R[t,R[t,]<lower.bound]=  lower.bound
  }
  
  #add column names
  colnames(R) <- paste0("arm_", 1:Narms)  
  
  return(R)
  
}