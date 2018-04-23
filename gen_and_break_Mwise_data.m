function [Mwise_data, mRing_Breaking, mFull_Breaking, madjacency, num_sample] = gen_and_break_Mwise_data(Prob, Comp, vGroundTruth, M)

size_temp = size(vGroundTruth);
num_item = size_temp(1);


% # of samples
sample_numsamp = round(nchoosek(num_item, M)*Prob);
% Define adjacency matrix for ring breaking
madjacency = zeros(num_item, num_item);

for num_sample = sample_numsamp
    %% Choose M items for each observation
    M_items_for_all_data = zeros(num_sample, M);
    Mwise_data = zeros(num_sample, Comp, M);
    
    for sample = 1:num_sample
        M_items_for_all_data(sample, :) = datasample(1:1:num_item, M, 'Replace', false);
    end
    
   %% Generate and break M-wise data
    mRing_Breaking = zeros(num_item, num_item);
    mFull_Breaking = zeros(num_item, num_item);
    for sample = 1:num_sample
        M_items = reshape(M_items_for_all_data(sample, 1:M), M, 1);
        vGT_score_M_itmes = vGroundTruth(M_items);
        
       %% adjacency matrix for ring breaking        
        for m = 1:M-1
            madjacency(M_items(m), M_items(m+1) ) = madjacency(M_items(m), M_items(m+1)) + 1;
            madjacency(M_items(m+1), M_items(m) ) = madjacency(M_items(m+1), M_items(m)) + 1;
        end
        if M ~= 2
            madjacency(M_items(M), M_items(1)) = madjacency(M_items(M), M_items(1)) + 1;
            madjacency(M_items(1), M_items(M)) = madjacency(M_items(1), M_items(M)) + 1;
        end

        mRing_Breaking_per_sample = zeros(M, M);
        mFull_breaking_per_sample = zeros(M, M);
        for comp = 1:Comp        
            %% Generate M-wise data
            tmp_GT_score = vGT_score_M_itmes;
            rank_M_items = zeros(M,1);
            for m = 1:M
                beat_prob = tmp_GT_score / sum(tmp_GT_score);
                ecdf = cumsum([0, beat_prob']);
                tmp = histc(rand(1), ecdf);
                [garbage, ind] = max(tmp);
                rank_M_items(ind) = m;
                tmp_GT_score(ind) = 0;
            end
            [garbage, M_ranking] = sort(rank_M_items);
            Mwise_data(sample, comp, :) = M_items(M_ranking);

            %% ring permutation breaking
            if rank_M_items(1) < rank_M_items(M)
                mRing_Breaking_per_sample(1, M) = mRing_Breaking_per_sample(1, M) + 1;
            else
                mRing_Breaking_per_sample(M, 1) = mRing_Breaking_per_sample(M, 1) + 1;
            end
            if M ~= 2
                for m = 1:M-1
                    if rank_M_items(m+1) < rank_M_items(m)
                        mRing_Breaking_per_sample(m+1, m) = mRing_Breaking_per_sample(m+1, m) + 1;
                    else
                        mRing_Breaking_per_sample(m, m+1) = mRing_Breaking_per_sample(m, m+1) + 1;
                    end
                end
            end
            %% full-breaking
            for m1 = 1:M-1
                for m2 = m1+1:M
                    if rank_M_items(m1) < rank_M_items(m2)
                        mFull_breaking_per_sample(m1, m2) = mFull_breaking_per_sample(m1, m2) + 1;
                    else
                        mFull_breaking_per_sample(m2, m1) = mFull_breaking_per_sample(m2, m1) + 1;
                    end
                end
            end
        end
        mRing_Breaking_per_sample = mRing_Breaking_per_sample / Comp;
        mFull_breaking_per_sample = mFull_breaking_per_sample / Comp;

        mRing_Breaking(M_items, M_items) = mRing_Breaking(M_items, M_items) + mRing_Breaking_per_sample;
        mFull_Breaking(M_items, M_items) = mFull_Breaking(M_items, M_items) + mFull_breaking_per_sample;
    end
end




















