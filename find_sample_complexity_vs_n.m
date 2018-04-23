%% parameters
M = 2;
Comp = 5;
delta_K = 0.4;
sample_n = (200:100:1500);
monte_carlo_trial = 1000;

sample_p = zeros(length(sample_delta_K), 40);

for i = 1:length(sample_n)
    low_point = 7*log(sample_n(i))/ sample_n(i);
    inter = 0.1*log(sample_n(i))/ sample_n(i);
    interval = (low_point:inter:low_point + inter*20);
    sample_p(i,1:length(interval)) = interval; 
end


%% Find empirical sample complexity
success = zeros(length(sample_p), length(sample_n));
empirical_sample_complexity = zeros(length(sample_n), 1);

for index_n = 1:length(sample_n)
    num_item = sample_n(index_n);
    
    %% Generate ground truth score vector
    vGroundTruth = gen_groundtruth(num_item, K, delta_K);
    
    index_p = 0;
    for Prob = sample_p(index_n, :)
        %% Find # of samples that achieves >95% success rate
        if index_p == 0 || success(index_p, index_n) <= 0.95
            index_p = index_p + 1;
            for trial = 1:monte_carlo_trial
                fprintf('# of items: %d, index_p: %d, monte_carlo_trial: %d \n', num_item, index_p, trial); 
                %% Generate and break M-wise data
                [Mwise_data, mRing_Breaking, mFull_Breaking, madjacency, num_sample] = gen_and_break_Mwise_data(Prob, Comp, vGroundTruth, M);
                %% Run prposed method
                score_proposed = run_Proposed(num_item, mRing_Breaking, madjacency);
                %% Evaluation
                success(index_p, index_n)  = success(index_p, index_n) + (1 - rank_fail(score_proposed, K));
            end
            success(index_p, index_n)  = success(index_p, index_n)  / monte_carlo_trial;
        end    
    end
    empirical_sample_complexity(index_n) = nchoosek(num_item, M)*sample_p(index_n, index_p)*Comp;
end

