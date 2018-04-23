% # of items that include in a M-wise observation
M = 4;

% # of items to be ranked
NumItem = 100;

% # of repeated monte carlo simulation
sample_num = 1000;

% # of top items 
K = 5;

% score gap between top-K item and top-(K+1)item
delta_K = 0.1;

% set of L's (# of repeated comparison) we want to simulate 
sample_L = (1:1:51);

% set of p's (observation probability) we want ot simulate
dense_p = (M - 1)*sqrt(log(NumItem) / nchoosek(NumItem-1, M-1));
sample_P = dense_p;