close all;
clear all;
% calculate accuracy for data1
load('part4_1Data.mat');
load('Datac.mat');
tic;
data1 = fea_final;

% retrain classifier for 5 times
iter = 7;
accuracy_total = [];
for n = 1:iter

a=randi(10,1,size(data1,1));
b=a>3;
c=a<=3;
data_train=data1(b,:);
gnd_train=gnd(b,:);
data_test=data1(c,:);
gnd_test=gnd(c,:);

predictGroup = classify(data_test,data_train,gnd_train,'diaglinear');

%calculate accuracy
result=confusionmat(gnd_test,predictGroup);
accuracy=trace(result)/(sum(sum(result)));
accuracy_total = [accuracy_total,accuracy];
end

accuracy_avg_data1 = mean2(accuracy_total);
fprintf('case1 accuracy=')
disp(accuracy_avg_data1);
t1 = toc;
fprintf('case1 running time=')
disp(t1);

% calculate accuracy for data2
load('part4_2Data.mat');

tic;
data2 = fea_final;

iter = 7;
accuracy_total = [];
for n = 1:iter

a=randi(10,1,size(data1,1));
b=a>3;
c=a<=3;
data_train=data2(b,:);
gnd_train=gnd(b,:);
data_test=data2(c,:);
gnd_test=gnd(c,:);

predictGroup = classify(data_test,data_train,gnd_train,'diaglinear');

%calculate accuracy
result=confusionmat(gnd_test,predictGroup);
accuracy=trace(result)/(sum(sum(result)));
accuracy_total = [accuracy_total,accuracy];
end
accuracy_avg_data2 = mean2(accuracy_total);
fprintf('case2 accuracy=')
disp(accuracy_avg_data1);
t2 = toc;
fprintf('case2 running time=')
disp(t2);


% calculate accuracy for data3
load('part4_3Data.mat');
tic;
data3 = fea_final;

iter = 7;
accuracy_total = [];
for n = 1:iter

a=randi(10,1,size(data3,1));
b=a>3;
c=a<=3;
data_train=data3(b,:);
gnd_train=gnd(b,:);
data_test=data3(c,:);
gnd_test=gnd(c,:);

predictGroup = classify(data_test,data_train,gnd_train,'diaglinear');

%calculate accuracy
result=confusionmat(gnd_test,predictGroup);
accuracy=trace(result)/(sum(sum(result)));
accuracy_total = [accuracy_total,accuracy];
end

accuracy_avg_data3 = mean2(accuracy_total);
fprintf('case3 accuracy=')
disp(accuracy_avg_data3);
t3 = toc;
fprintf('case3 running time=')
disp(t3);


% calculate accuracy for all data
load('DataC.mat');
tic;
data4 = fea;

iter = 7;
accuracy_total = [];
for n = 1:iter

a=randi(10,1,size(data4,1));
b=a>3;
c=a<=3;
data_train=data4(b,:);
gnd_train=gnd(b,:);
data_test=data4(c,:);
gnd_test=gnd(c,:);

predictGroup = classify(data_test,data_train,gnd_train,'diaglinear');

%calculate accuracy
result=confusionmat(gnd_test,predictGroup);
accuracy=trace(result)/(sum(sum(result)));
accuracy_total = [accuracy_total,accuracy];
end

accuracy_avg_data4 = mean2(accuracy_total);
fprintf('case4 accuracy=')
disp(accuracy_avg_data4);
t4 = toc;
fprintf('case4 running time=')
disp(t4);



