function vGroundTruth = gen_groundtruth(NumItem, K, delta_K)

vGroundTruth = zeros(NumItem, 1);
factor = 4.5 - 5*delta_K;
for i = 1:NumItem
    if i <= K
        vGroundTruth(i) = -factor*rand(1) + 10;
    else
        vGroundTruth(i) = factor*rand(1) + 1;
    end
end

%             for i = 1:NumItem
%                 if i <= K
%                     vGroundTruth(i) = -factor + 10;
%                 else
%                     vGroundTruth(i) = factor + 0;
%                 end
%             end

vGroundTruth = sort(vGroundTruth);
vGroundTruth = vGroundTruth(NumItem:-1:1);
vGroundTruth(1) = 10;
vGroundTruth(K) = 10 - factor;
vGroundTruth(K+1) = 1 + factor;
GT_factor = sum(vGroundTruth);
vGroundTruth = vGroundTruth / GT_factor;