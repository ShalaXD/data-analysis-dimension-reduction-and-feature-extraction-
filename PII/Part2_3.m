%% use pca to reduce the data demensionality
%% plot the data points of the 5th and 6th components
%% running environment£º matlab 2016b, whose library contains pca() function
function Q2_3()
addpath(genpath(pwd));
load('DataB.mat');% get DataB.mat to fea
[COEFF, SCORE, LATENT, TSQUARED] = pca(zscore(fea)); % LATENT is the eigenvalues
disp(size(COEFF));
figure(9);
gscatter(SCORE(:,5),SCORE(:,6),gnd);
xlabel('X'),ylabel('Y');
title('Classes reprensentation based on the 5th and 6th principal components ');
end




