function score_SMLE = run_SpectralMLE(score_proposed, mRing_Breaking, madjacency, Delta_a)



size_temp = size(score_proposed);
NumItem = size_temp(1);
Max_Ground = 1.2*max(score_proposed);
Min_Ground = 0;
madjacency = sign(madjacency);


Error = 10^-6;
vMLEweight = zeros(NumItem, 1);


vEvolveWeight = score_proposed;
degree = sum(madjacency);
for time = 1:15
    Delta = Delta_a;
    %% Bisection method to conduct coordinate-wise MLE
    for i = 1:NumItem
        if degree(i) >= 7
            MaxTau = Max_Ground;
            MinTau = Min_Ground;
            Tau = (MaxTau + MinTau)/2;
            vIter_row = mRing_Breaking(i, :)';
            vadja_row = madjacency(i, :)';
            count = 0;
            while abs(MaxTau - MinTau) > Error
                count = count + 1;
                diff_ML = sum(vadja_row.*(vIter_row.*(1/Tau) - 1./(Tau + vEvolveWeight)));
                if diff_ML >= 0
                    MinTau = Tau;
                    Tau = (MinTau + MaxTau) / 2;
                else
                    MaxTau = Tau;
                    Tau = (MaxTau + MinTau) / 2;
                end

            end
            vMLEweight(i) = Tau;
        end
        
    end
    %% Update score
    for i = 1:NumItem
        if degree(i) >= 7
            if abs( ( vMLEweight(i) - vEvolveWeight(i) ) ) > Delta                   
                vEvolveWeight(i) = vMLEweight(i);
            end
        end
    end
end

score_SMLE = vEvolveWeight;






