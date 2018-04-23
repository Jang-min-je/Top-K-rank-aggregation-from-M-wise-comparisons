function score_count = run_Counting(mPageRankInit)

score_count = sum(mPageRankInit')';
score_count = score_count / sum(score_count);