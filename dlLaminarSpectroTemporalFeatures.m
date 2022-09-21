function y = dlLaminarSpectroTemporalFeatures(lfp, fs, MaxFreq, TimeBins, FreqPointList)
   
    x = dlSpectroTemporalSpace(lfp, fs, MaxFreq, TimeBins);
    n = size(x, 1);
    k = length(FreqPointList);

    FreqPointList = [1e-9, FreqPointList];
    l = ceil((FreqPointList * n )/MaxFreq);
    y = zeros(k, size(x, 2), size(x, 3));

    for i = 1:k

        y(i, :, :) = mean(x(l(i):l(i+1), :, :), 1);

    end
    
    for i = 1:size(y, 1)

        for j = 1:size(y, 3)

            y(i, :, j) = y(i, :, j) / max(max(squeeze(y(i, :, j))));

        end

    end

end
