close all;
clear all;
load('DataC.mat');
%min-max normalization
%x(i)_new = (x(i) - min(x))/(max(x)-min(x))
tic;
fea_new = zeros(size(fea));

for j = 1:size(fea,2)
    for i = 1:size(fea,1)
        fea_new(i,j) = (fea(i,j)-min(fea(:,j)))/(max(fea(:,j))-min(fea(:,j)));
    end;
end;

num_c1 = length(find(gnd==1));
num_c2 = length(find(gnd==2));
num_c3 = length(find(gnd==3));
%objective function:sum of squared euclidean distance
%define class
c_1 = [];
c_2 = [];
c_3 = [];
for i = 1:2100
    if gnd(i) == 1;
        c_1 = [c_1; fea_new(i,:)];
    elseif gnd(i) == 2;
        c_2 = [c_2; fea_new(i,:)];
    elseif gnd(i) == 3;
        c_3 = [c_3; fea_new(i,:)];
         
    end 
end

fea_final = [];
for m = 1:8
%distance between class1 and class2
class_dist12 = [];
for j = 1:size(fea_new,2)
     class_dist12= [class_dist12,  (1/(num_c1*num_c2))*sum(sum(dist(c_1(:,j),c_2(:,j).')))];
end       

%distance between class2 and class3
class_dist23 = [];
for j = 1:size(fea_new,2)
     class_dist23= [class_dist23, (1/(num_c2*num_c3))*sum(sum(dist(c_2(:,j),c_3(:,j).')))];
end       

%distance between class1 and class3
class_dist13 = [];
for j = 1:size(fea_new,2)
     class_dist13= [class_dist13,  (1/(num_c1*num_c3))*sum(sum(dist(c_1(:,j),c_3(:,j).')))];
end
%sum of distance between classes
class_dist = class_dist12+class_dist23+class_dist13;

fea_best = find(class_dist == max(class_dist));
fea_final = [fea_final, fea_new(:,fea_best)];
class_dist(:,fea_best) = []; 
fea_new(:,fea_best) = [];
c_1(:,fea_best)=[];
c_2(:,fea_best)=[];
c_3(:,fea_best)=[];

end

save('part4_1Data','fea_final');
%disp(size(fea_final));
time = toc;
fprintf('running time=')
disp(time);