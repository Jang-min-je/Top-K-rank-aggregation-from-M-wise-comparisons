
for index = 1:2
    Prob = sample_P(index);
    for index_l = 1:length(sample_L(index, :))
        Comp = sample_L(index, index_l);
        for sample = 1:sample_num

            fprintf('comp: %d, sample: %d / %d \n', Comp, sample, sample_num)

            %% Ground truth generation
            vGroundTruth = gen_groundtruth(NumItem, K, delta_K);
            
            %% Generate and break M-wise data
           [Mwise_data, mRing_Breaking, mFull_Breaking, madjacency, num_sample] = gen_and_break_Mwise_data(Prob, Comp, vGroundTruth, M);
           
           %% Run Algorithms
           % Run prposed method
           score_proposed = run_Proposed(NumItem, mRing_Breaking, madjacency);
           % Run SMLE
           score_SMLE = run_SpectralMLE(score_proposed, mRing_Breaking, madjacency, 10^-4);

           %% Normalization
            score_SMLE = score_SMLE / max(score_SMLE);
            score_proposed = score_proposed / max(score_proposed);
            vGroundTruth = vGroundTruth / max(vGroundTruth);

            %% Evaluation
            RC_success(index, index_l) = RC_success(index,index_l) - rank_fail(score_proposed, K);
            SMLE_success(index,index_l) = SMLE_success(index,index_l) - rank_fail(score_SMLE, K);

            RC_Linf(index, index_l) = RC_Linf(index, index_l) + norm(score_proposed - vGroundTruth, 'inf') / norm(vGroundTruth, 'inf');
            SMLE_Linf(index, index_l) = SMLE_Linf(index, index_l) + norm(score_SMLE - vGroundTruth, 'inf') / norm(vGroundTruth, 'inf');    
        end
    end
end


RC_success = RC_success / sample_num;
SMLE_success = SMLE_success / sample_num;

RC_Linf = RC_Linf / sample_num;
SMLE_Linf = SMLE_Linf / sample_num;
