%% parameters
num_item = 200;
M = 2;
Comp = 20;
sample_delta_K = (0.1:0.01:0.3);
monte_carlo_trial = 1000;

sample_p = zeros(length(sample_delta_K), 40);

for i = 1:length(sample_delta_K)
    low_point = 0.6*(0.1 / sample_delta_K(i))^2 ;
    inter = 0.01*low_point;
    interval = (low_point+inter*10:inter:low_point + inter*50);
    sample_p(i,1:length(interval)) = interval; 
end


%% Find empirical sample complexity


success = zeros(length(sample_p), length(sample_delta_K));
empirical_sample_complexity = zeros(length(sample_delta_K), 1);

for index_delta_K = 1:length(sample_delta_K)
    delta_K = sample_delta_K(index_delta_K);
    
    %% Generate ground truth score vector
    vGroundTruth = gen_groundtruth(num_item, K, delta_K);
    
    index_p = 0;
    for Prob = sample_p(index_delta_K, :)
        %% Find # of samples that achieves >95% success rate
        if index_p == 0 || success(index_p, index_delta_K) <= 0.95
            index_p = index_p + 1;
            for trial = 1:monte_carlo_trial
                fprintf('Delta_K: %f, index_p: %d, monte_carlo_trial: %d \n',delta_K, index_p, trial); 
                %% Generate and break M-wise data
                [Mwise_data, mRing_Breaking, mFull_Breaking, madjacency, num_sample] = gen_and_break_Mwise_data(Prob, Comp, vGroundTruth, M);
                %% Run prposed method
                score_proposed = run_Proposed(num_item, mRing_Breaking, madjacency);
                %% Evaluation
                success(index_p, index_delta_K)  = success(index_p, index_delta_K) + (1 - rank_fail(score_proposed, K));
            end
            success(index_p, index_delta_K)  = success(index_p, index_delta_K)  / monte_carlo_trial;
        end    
    end
    empirical_sample_complexity(index_delta_K) = nchoosek(num_item, M)*sample_p(index_delta_K, index_p)*Comp;
end






