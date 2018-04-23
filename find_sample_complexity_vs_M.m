%% Parameters
num_item = 100;
K = 5;
Comp = 20;
delta_K = 0.3;
sample_M = (3:1:15);
sample_p = zeros(length(sample_M), 40);
monte_carlo_trial = 1000;

% Set of p's for simulation
for i = 1:length(sample_M)
    M = sample_M(i);
    low_point = log(num_item) / nchoosek(num_item - 1, M  - 1);
    inter = 0.01*low_point;
    interval = (low_point+inter*10:inter:low_point + inter*50);
    sample_p(i,1:length(interval)) = interval; 
end


%% Find empirical sample complexity
success = zeros(length(sample_p), length(sample_M));
empirical_sample_complexity = zeros(length(sample_M), 1);
for index_M = 1:length(sample_M)
    M = sample_M(index_M);
    
    %% Generate ground truth score vector
    vGroundTruth = gen_groundtruth(num_item, K, delta_K);
    
    index_p = 0;
    for Prob = sample_p(index_M, :)
        %% Find # of samples that achieves >95% success rate
        if index_p == 0 || success(index_p, index_M) <= 0.95
            index_p = index_p + 1;
            
            for trial = 1:monte_carlo_trial
                fprintf('M: %d, index_p: %d, monte_carlo_trial: %d \n',M, index_p, trial); 
                %% Generate and break M-wise data
                [Mwise_data, mRing_Breaking, mFull_Breaking, madjacency, num_sample] = gen_and_break_Mwise_data(Prob, Comp, vGroundTruth, M);
                %% Run prposed method
                score_proposed = run_Proposed(num_item, mRing_Breaking, madjacency);
                %% Evaluation
                success(index_p, index_M)  = success(index_p, index_M) + (1 - rank_fail(score_proposed, K));
            end
            success(index_p, index_M)  = success(index_p, index_M)  / monte_carlo_trial;
        end    
    end
    empirical_sample_complexity(index_M) = nchoosek(num_item, M)*sample_p(index_M, index_p)*Comp;
end





