%% In Thy Name

% NeuroClassifierApp
% HNyXJ@VU - 2022 - September


%% Loading

clear;clc;
load("data.mat");

%% Initialization

lfpx = lfp(251:4250, :, :);
fs = 1000;
MaxFreq = 150;
TimeBins = 4;

FreqPointList = 10:10:150; % Band borders.
BandLabels = ["<Alpha"];

for i = 1:length(FreqPointList)-1

    if FreqPointList(i) < 10

        BandLabels = [BandLabels, "<Alpha"];

    elseif FreqPointList(i) < 30

        BandLabels = [BandLabels, "Beta"];

    elseif FreqPointList(i) >30

        BandLabels = [BandLabels, "Gamma"];

    end

end

%% Processing

clc;

y = zeros(length(FreqPointList), size(lfpx, 2), TimeBins);

for i = 1:3
    y(:, (i-1)*16+1:i*16, :) = dlLaminarSpectroTemporalFeatures(lfpx(:, (i-1)*16+1:i*16, :), fs, MaxFreq, TimeBins, FreqPointList);
end

%% Categorization

ChannelLabels = [];

for i = 1:size(y, 2)

    c1 = mean(mean(y(2:7, i, :))) / mean(mean(y(7:14, i, :)));
    c2 = max(max(y(2:7, i, :))) / max(max(y(7:14, i, :)));

    if c1 < 0.84 || c2 < 0.77

        ChannelLabels = [ChannelLabels, "Sup("+string(i)+")"];

    elseif c1 > 1.14 || c2 > 1.21

        ChannelLabels = [ChannelLabels, "Deep("+string(i)+")"];

    else

        ChannelLabels = [ChannelLabels, "Mid("+string(i)+")"];

    end

end

%% Initial Results

clc;
T = 2;

figure("WindowState", "fullscreen");
subplot(1, 1, 1);imagesc(y(:, :, T)');
xlabel("Band relative power plot for " + string(T) + "th time interval");
ylabel("Channel index");colorbar();

xticklabels(BandLabels);
xticks(1:length(BandLabels));
yticklabels(ChannelLabels);
yticks(1:length(ChannelLabels));

%%