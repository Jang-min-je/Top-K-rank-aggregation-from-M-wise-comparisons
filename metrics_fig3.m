% Successr rate of each algorithm 
RC_success = ones(2, length(sample_L(1,:)));
SMLE_success = ones(2, length(sample_L(1,:)));


% linf norm of the proposed algorithm and spectral MLE (for experiments in figure 3)
RC_Linf = zeros(2, length(sample_L(1,:)));
SMLE_Linf = zeros(2, length(sample_L(1,:)));