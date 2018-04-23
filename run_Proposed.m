function score_proposed = run_Proposed(num_item, mRing_Breaking, madjacency)


for i = 1:num_item
    for j = 1:num_item
        if mRing_Breaking(i,j) ~= 0
            mRing_Breaking(i,j) = mRing_Breaking(i,j) / madjacency(i,j);
        end
    end
end

%% Construct Markov chain
dmax = max(sum(madjacency));
mMarkovmatrix = mRing_Breaking / (2*dmax);
for i = 1:num_item
    mMarkovmatrix(i,i) = 1 - sum(mRing_Breaking(1:num_item, i) / (2*dmax));
end

%% Run power method
iter = 2000;
score_proposed = ones(num_item,1) / num_item;
for i = 1:iter
    score_proposed = mMarkovmatrix*score_proposed;
end






















