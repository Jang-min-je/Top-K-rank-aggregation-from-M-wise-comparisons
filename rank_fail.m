function bit_rank_fail = rank_fail(score, K)

num_item = length(score);
[vSorted_score, vRanking] = sort(score);
vRanking = vRanking(num_item:-1:1);
vSorted_score = vSorted_score(num_item:-1:1);

%% performance measure
rank_success = 1;
vTop_K = (1:K);
for i = 1:K
    if ~ismember(vRanking(i), vTop_K)
        rank_success = 0;
        break;
    end    
end

if vSorted_score(K) == vSorted_score(K+1);
    rank_success = 0;
end

bit_rank_fail = abs(rank_success  - 1);