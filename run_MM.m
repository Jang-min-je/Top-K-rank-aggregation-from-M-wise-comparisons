function score_MM = run_MM(num_item, Comp, Mwise_data, num_sample, M)

% Y_result_2(i, j, k) = X means that "kth ranked items (k = 1~M)" of "jth repeated comparison (j = 1~L)" of "ith M-wise Comparison (M=10 for LOL)" is "item X"  
% num_sample is the # of total Mwise comparison samples

score_MM = ones(num_item, 1) / num_item;


% Get scores of items like counting method
% If "item X" is "3rd ranked" among "10 items", add "10 - 3 = 7" points to "item X" 
win_score = zeros(num_item, 1);
for i = 1:num_sample
    for comp = 1:Comp
        for j = 1:M
            tmp_winner = Mwise_data(i, comp, j);
            win_score(tmp_winner) = win_score(tmp_winner) + sign(M - j);
        end
    end
end


for iteration = 1:100
    
    % EXAMPLE FOR line 31 to 40$
    % If four items, {1,2,3,4} are ordered as (1,2,3,4)", 
    % add 1/(w_1 + w_2 + w_3 + w_4) to item 1, 
    % add 1/(w_1 +w_2 + w_3 + w_4) + 1/(w_2 + w_3 + w_4) to item 2, 
    % add 1/(w_1 +w_2 + w_3 + w_4) + 1/(w_2 + w_3 + w_4) + 1/(w_3 + w_4) to item 3 and item 4
    
    score = zeros(num_item, 1);
    for i = 1:num_sample
        for comp = 1:Comp
            for j = 1:M-1
                for k = j:M
                    score(Mwise_data(i,comp, k)) = score(Mwise_data(i,comp, k)) + (1 / sum(score_MM(Mwise_data(i,comp, j:M))));
                end
            end
        end
    end
    
    % Estimate using win_score and score vectors
    score_MM = win_score./score;
    
    % Normalize scores
    score_MM = score_MM / sum(score_MM);
end























