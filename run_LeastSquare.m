function score_LS = run_LeastSquare(NumItem, mPageRankInit, madjacent)


LS_mat = zeros(NumItem, NumItem);
for i = 1:NumItem
    for j = 1:NumItem
        if mPageRankInit(i,j) ~= 0 && mPageRankInit(j,i) ~= 0
            LS_mat(i,j) = log(mPageRankInit(i,j) / mPageRankInit(j,i));
        end
    end
end

Lap_mat = - madjacent;
for i = 1:NumItem
    Lap_mat(i,i) = sum(madjacent(i,:));
end

div_LS_mat = sum(LS_mat')';

score_LS = pinv(Lap_mat)*div_LS_mat;
score_LS = exp(score_LS);
score_LS = score_LS / sum(score_LS);