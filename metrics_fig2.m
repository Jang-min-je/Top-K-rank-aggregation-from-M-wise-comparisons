% Successr rate of each algorithm 
RC_success = ones(length(sample_L), 1)*sample_num;
bit_RCfull_rankfail = ones(length(sample_L), 1 )*sample_num;
SMLE_success = ones(length(sample_L), 1 )*sample_num;
Count_success = ones(length(sample_L), 1 )*sample_num;
MM_success  = ones(length(sample_L), 1 )*sample_num;
LS_success = ones(length(sample_L), 1 )*sample_num;

% Overlap of each algorithm
RC_overlap = zeros(length(sample_L), 1 );
SMLE_overlap = zeros(length(sample_L), 1 );
Count_overlap = zeros(length(sample_L), 1 );
MM_overlap = zeros(length(sample_L), 1 );
LS_overlap = zeros(length(sample_L), 1 );
