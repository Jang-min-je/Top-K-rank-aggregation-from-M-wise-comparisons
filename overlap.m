function overlap_point = overlap(score, K)

NumItem = length(score);

[temp, ind] = sort(score);
rank_score = ind(NumItem:-1:1);
overlap_point = 0;
for i = 1:K
    if rank_score(i) <= K
        overlap_point = overlap_point + 1;
    end
end
overlap_point = overlap_point / K;