close all;
clear all;
%min-max normalization
%x(i)_new = (x(i) - min(x))/(max(x)-min(x)) 
tic;
load('DataC.mat');

fea_new = zeros(size(fea));

% normalize
for j = 1:size(fea,2)
    for i = 1:size(fea,1)
        fea_new(i,j) = (fea(i,j)-min(fea(:,j)))/(max(fea(:,j))-min(fea(:,j)));
    end;
end;

fea_final = [];

for m = 1:8
    
    accuracy_all = [];
    
    for n = 1:size(fea_new,2)
    fea_sets = [fea_final,fea_new(:,n)];
    iter = 7;
    accuracy_temp_total = [];
    % iterate 7 times because 0.3^7 is 0.0002187, 0.3^7 * 2100 <1 all 
    % sample is used
   
        for i = 1:iter
        a=randi(10,1,size(fea_new,1));
        b=a>3;
        c=a<=3;
        fea_train=fea_sets(b,:);
        gnd_train=gnd(b,:);
        fea_test=fea_sets(c,:);
        gnd_test=gnd(c,:);
        predictGroup = classify(fea_test,fea_train,gnd_train,'diaglinear');

        %calculate accuracy
        result_temp = confusionmat(gnd_test,predictGroup);
        accuracy_temp =trace(result_temp)/(sum(sum(result_temp)));
        accuracy_temp_total = [accuracy_temp_total,accuracy_temp];
        end

    accuracy_temp_avg = mean2(accuracy_temp_total);
    accuracy_all = [accuracy_all,accuracy_temp_avg];
    end

fea_best = find(accuracy_all == max(accuracy_all));
fea_final = [fea_final, fea_new(:,fea_best)];
fea_new(:,fea_best) = []; 
end

%disp(size(fea_final));

save('part4_2Data','fea_final');
time = toc;
fprintf('running time=')
disp(time);
