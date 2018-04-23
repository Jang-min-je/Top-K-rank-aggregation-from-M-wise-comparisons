
for index_p = 1:length(sample_P)
    Prob = sample_P(index_p);
    for index_l = 1:length(sample_L)
        Comp = sample_L(index_l);
        for sample = 1:sample_num
            
            fprintf('c_p: %d, comp: %d, sample: %d / %d \n', index_p, Comp, sample, sample_num)
            
           %% Ground truth generation
            vGroundTruth = gen_groundtruth(NumItem, K, delta_K);
            
           %% Generate and break M-wise data
           [Mwise_data, mRing_Breaking, mFull_Breaking, madjacency, num_sample] = gen_and_break_Mwise_data(Prob, Comp, vGroundTruth, M);
           
           %% Run Algorithms
           % Run prposed method
           score_proposed = run_Proposed(NumItem, mRing_Breaking, madjacency);
           % Run SMLE
           score_SMLE = run_SpectralMLE(score_proposed, mRing_Breaking, madjacency, 10^-4);
           % Run MM
           score_MM = run_MM(NumItem, Comp, Mwise_data, num_sample, M);
           % run Least Square
           score_LS = run_LeastSquare(NumItem, mPageRankInit, madjacency); 
           % Counting method 
           score_count = run_Counting(mPageRankInit);
           
           %% Score normalization
            score_SMLE = score_SMLE / max(score_SMLE);
            score_proposed = score_proposed / max(score_proposed);
            score_MM = score_MM / max(score_MM);
            score_count = score_count / max(score_count);
            score_LS = score_LS / max(score_LS);
            vGroundTruth = vGroundTruth / max(vGroundTruth);
            
            %% Evaluation
            RC_success(index_l) = RC_success(index_l) - rank_fail(score_proposed, K);
            SMLE_success(index_l) = SMLE_success(index_l) - rank_fail(score_SMLE, K);
            Count_success(index_l) = Count_success(index_l) - rank_fail(score_count, K);
            MM_success(index_l) = MM_success(index_l) - rank_fail(score_MM, K);
            LS_success(index_l) = LS_success(index_l) - rank_fail(score_LS, K);
            
            RC_overlap(index_l) = RC_overlap(index_l) + overlap(score_proposed, K);
            SMLE_overlap(index_l) = SMLE_overlap(index_l) + overlap(score_SMLE, K);
            Count_overlap(index_l) = Count_overlap(index_l) + overlap(score_count, K);
            MM_overlap(index_l) = MM_overlap(index_l) + overlap(score_MM, K);
            LS_overlap(index_l) = LS_overlap(index_l) + overlap(score_LS, K);
        end
    end
end


%% Performance normalization
RC_success = RC_success / sample_num;
SMLE_success = SMLE_success / sample_num;
Count_success = Count_success / sample_num;
MM_success = MM_success / sample_num;
LS_success = LS_success / sample_num;

RC_overlap = RC_overlap / sample_num;
SMLE_overlap = SMLE_overlap / sample_num;
Count_overlap = Count_overlap / sample_num;
MM_overlap = MM_overlap / sample_num;
LS_overlap = LS_overlap / sample_num;
