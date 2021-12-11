# Generating a random walk for multiple armed bandit tasks
1. We start to generate the random-walk by assigning random starting points samples from a uniform distribution  between the two bounds.

2. We then calculate the next value in each arm to be equal to what it was plus some noise. Noise is samples from a multivariate distribution with a mean of 0, and variance-covariance matrix (i.e., sigma matrix).


for trial in 1 to Ntrials{
x[t+1] = x[t] + randomnoise
}


