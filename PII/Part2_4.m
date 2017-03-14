%% compute the pca errors and compare them with Retained Variance
%% use naivebayes classifier to do classification
%% running environment£º matlab 2016b, whose library contains pca(),classify() functions
function Q2_4()
addpath(genpath(pwd));
load('DataB.mat');% get DataB.mat to fea
[COEFF, SCORE, LATENT, TSQUARED] = pca(zscore(fea));
fea=SCORE;
%% random choose data from fea
a=randi([0 1],1,2066); %#ok<REMFF1>
b=find(a==0);
c=find(a==1);
fea_train=fea(b,:);
gnd_train=gnd(b,:);
fea_test=fea(c,:);
gnd_test=gnd(c,:);
%% NaiveBayes Classifier
number=[2,4,10,30,60,200,500,784];
re=ones(8,2);
for j=1:8
i=number(j);
Error=sum(LATENT(1:i,:))/sum(LATENT);
[PredictClass,ERR]= classify(fea_test(:,1:i),fea_train(:,1:i),gnd_train,'diaglinear');
re(j,:)=[ERR,Error]; 
end
disp(re);
figure(10);
bar(re);
set(gca,'XTickLabel',{'First 2 PCA','First 4 PCA','First 10 PCA','First 30 PCA','First 60 PCA','First 200 PCA','First 500 PCA','First 784 PCA'}) 
xlabel('Numbers'),ylabel('Error percentage');
legend('Classication Error','Retained Variance');
title('Classication Error VS Retained Variance');
end



