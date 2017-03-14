%% detect any problems in dataset A and show the problems 
%% fix the problems and store the data into DataA_filled.mat and DataA_outlier.mat 
%% running environment£º matlab 2016b, whose library contains hampel() function
function Q1_2()
%% detect missing data and change the missing data with mean
addpath(genpath(pwd));
load('DataA.mat');                % get dataset A: fea
[detect_fea,fea_n]=missing(fea);    
figure(1);
title('Missing values detecting');
bar(fea_n);
xlabel('Feature 1 to Feature 81'),ylabel('Missing Values Percetage');
title('Missing values detecting and repairing');
feafilled=fillmissing(fea);
save('DataA_filled.mat','feafilled');
clear all;
%% after repair all missing datas, detect outliers and repair it
load('DataA_filled.mat'); % get data feafilled
[feaoutlier,I] = hampel(feafilled,20);
save('DataA_outlier.mat','feaoutlier');
fea_n=sum(I);
figure(2);
bar(fea_n);
xlabel('Feature 1 to Feature 81'),ylabel('Outliers Numbers');
title('Outliers detecting');
end

%% detect missing values in datasetA
function [detect_fea,fea_n]=missing(fea)
detect_fea=isnan(fea);
fea_n=sum(detect_fea)/size(fea,1);% return the numbers of missing data in every colum 
end

%% fill in the missing data with mean data
function fea=fillmissing(fea)
[~,fea_n]=missing(fea);
mean_matrix=repmat(mean(fea_n),1,size(fea,2));
fea_m=fea_n./mean_matrix;
fea_mpos1= fea_m>2;
fea(:,fea_mpos1)=0;% delete the colums with two many anafe
[detect_fea,fea_n]=missing(fea);
pos=detect_fea==1;
mean_matrix2=repmat(fea_n,size(fea,1),1);
fea(pos)=mean_matrix2(pos);
end


