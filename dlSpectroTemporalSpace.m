function y = dlSpectroTemporalSpace(lfp, fs, MaxFreq, TimeBins)

    y = [];
    Tn = TimeBins;
    TimeInterval = fs*(4/Tn);
    
    for i = 1:Tn
    
        x = squeeze(lfp((i-1)*TimeInterval + 1:i*TimeInterval, :, 1));

        SignalsPSDx = pspectrum(x, fs, 'FrequencyLimits', [0 MaxFreq]);

        if i == 1

            SignalsPSD = zeros(size(SignalsPSDx, 1), size(SignalsPSDx, 2), Tn);

        end

        SignalsPSD(:, :, i) = SignalsPSDx;
    
    end
    
    y = SignalsPSD;
%     PinkEstimate = mean(SignalsPSD, 3);
% 
%     for i = 1:Tn
%     
%         SignalsPSD(:, :, i) = SignalsPSD(:, :, i)./(PinkEstimate);
%     
%     end
% 
%     y = SignalsPSD;

end
