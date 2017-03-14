%% use pca to get the eigenvectors and eigenvalues
%% and plot the data points of the first 2 components
%% running environment£º matlab 2016b, whose library contains pca() function

function Q2_2()
addpath(genpath(pwd));
load('DataB.mat');% get DataB.mat to fea

[COEFF, SCORE, LATENT, TSQUARED] = pca(zscore(fea)); % LATENT is the eigenvalues
figure(8);
gscatter(SCORE(:,1),SCORE(:,2),gnd);
xlabel('X'),ylabel('Y');
title('Classes reprensentation based on the 1th and 2th principal components ');
end




