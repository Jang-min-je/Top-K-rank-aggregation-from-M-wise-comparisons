% # of items that include in a M-wise observation
M = 2;

% # of items to be ranked
NumItem = 500;

% # of repeated monte carlo simulation
sample_num = 10000;

% # of top items 
K = 10;

% score gap between top-K item and top-(K+1)item
delta_K = 0.1;

% set of L's (# of repeated comparison) we want to simulate 
sample_L = zeros(2, 25);
sample_L(1, :) = (1:1:25);
sample_L(2, :) = (10:10:250);


% set of p's (observation probability) we want ot simulate
sparse_p = 0.025;
dense_p = 0.25;
sample_P = [sparse_p, dense_p];
