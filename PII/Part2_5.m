%% LDA method to reduce the dimensionality;Use NaiveBayes to classify the data
%% running environment£º matlab 2016b, whose library contains lda() function
function Q2_5()
addpath(genpath(pwd));
load('DataB.mat');
%% LDA
A=fea;
disp(size(A));
%mappedA = compute_mapping(A, 'LDA', 1);
[mappedA, mapping] = lda(A, gnd, 2);
disp(size(mappedA));
%fea=mappedA;
figure(11);
gscatter(mappedA(:,1),mappedA(:,2),gnd);
xlabel('X'),ylabel('Y');
title('LDA Scatter Plot');
end
















