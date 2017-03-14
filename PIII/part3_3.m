load 'DataB.mat';
% dimension reduction using LLE
[LLE,mapping] = lle(fea, 4, 5);

% retrain classifier for 7 times
% iterate 7 times because 0.3^7 * 2066 < 1 so that all sample is used
iter = 7;
accuracy_total = [];

for n = 1:iter

% radomly select 70% as training set and 30% as testing set    
a=randi(10,1,size(fea,1));
b=a>3;
c=a<=3;
LLE_train=LLE(b,:);
gnd_train=gnd(b,:);
LLE_test=LLE(c,:);
gnd_test=gnd(c,:);

% classify the dataset and calculate accuracy for every iteration
predictClass = classify(LLE_test,LLE_train,gnd_train,'diaglinear');
result=confusionmat(gnd_test,predictClass);
accuracy=trace(result)/(sum(sum(result)));
accuracy_total = [accuracy_total,accuracy];
end

%calculate average accuracy
accuracy_avg_LLE = mean2(accuracy_total);
disp(accuracy_avg_LLE);


% dimension reduction using ISOMAP
[ISOMAP, mapping] = isomap(fea, 4, 5);

% retrain classifier for 7 times
accuracy_total = [];
for n = 1:iter

a=randi(10,1,size(fea,1));
b=a>3;
c=a<=3;
ISOMAP_train=ISOMAP(b,:);
gnd_train=gnd(b,:);
ISOMAP_test=ISOMAP(c,:);
gnd_test=gnd(c,:);

% classify the dataset and calculate accuracy for every iteration
predictGroup = classify(ISOMAP_test,ISOMAP_train,gnd_train,'diaglinear');
result=confusionmat(gnd_test,predictGroup);
accuracy=trace(result)/(sum(sum(result)));
accuracy_total = [accuracy_total,accuracy];
end

% calculate average accuracy for ISOMAP
accuracy_avg_ISOMAP = mean2(accuracy_total);
disp(accuracy_avg_ISOMAP);


% calculate average accuracy for PCA
PCA_accurancy=[];
% use pca function from system tool box
[COEFF, SCORE, LATENT, TSQUARED] = pca(zscore(fea)); % LATENT is the eigenvalues
mappedA=SCORE;
for j=1:15
a=randi([0 1],1,size(mappedA,1));
b=find(a==0);
c=find(a==1);
fea_train=mappedA(b,:);
gnd_train=gnd(b,:);
fea_test=mappedA(c,:);
gnd_test=gnd(c,:);
i=4; % dimensions 
[PredictClass,ERR]= classify(fea_test(:,1:i),fea_train(:,1:i),gnd_train,'diaglinear');
PCA_accurancy=[PCA_accurancy,1-ERR];
end
disp(mean(PCA_accurancy));


%calculate average accuracy for LDA
A=fea;
[mappedA, mapping] = lda(A, gnd, 4);
[COEFF, SCORE, LATENT, TSQUARED] = pca(zscore(fea)); % LATENT is the eigenvalues
LDA_accurancy=[];
for j=1:15
a=randi([0 1],1,size(mappedA,1));
b=find(a==0);
c=find(a==1);
fea_train=mappedA(b,:);
gnd_train=gnd(b,:);
fea_test=mappedA(c,:);
gnd_test=gnd(c,:);
i=4; % dimensions 
% use pca function from system tool box
[PredictClass,ERR]= classify(fea_test(:,1:i),fea_train(:,1:i),gnd_train,'diaglinear');
LDA_accurancy=[LDA_accurancy,1-ERR];
end

disp(mean(LDA_accurancy));


