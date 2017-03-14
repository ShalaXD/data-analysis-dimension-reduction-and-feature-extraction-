%% doing normalization using min-max method and z-score method
%% and show the data after normalization
%% running environment£º matlab 2016b, whose library contains hampel(),autocorr() function
function Q1_3()
addpath(genpath(pwd));
%% min-max
load('DataA_filled.mat');%fea_out
fea_nm=normalize(feafilled);
save('DataA_norm.mat','fea_nm');
%% z-score
load('DataA_filled.mat');%fea_out
fea_nz=normZ(feafilled);
save('DataA_zcor.mat','fea_nz');
%% plot 9th feature in fig.3
figure(3);
subplot(3,1,1);
histogram(feafilled(:,9));
%xlabel(''),ylabel('Outliers Numbers');
title('Original Data');
subplot(3,1,2);
histogram(fea_nm(:,9));
title('Normalized using min-max method');
subplot(3,1,3);
histogram(fea_nz(:,9));
title('Normalized using z-score method');

%% plot 24th feature in fig.4
figure(4);
subplot(3,1,1);
histogram(feafilled(:,24));
%xlabel(''),ylabel('Outliers Numbers');
title('Original Data');
subplot(3,1,2);
histogram(fea_nm(:,24));
title('Normalized using min-max method');
subplot(3,1,3);
histogram(fea_nz(:,24));
title('Normalized using z-score method');
%% auto-correlation before and after normalization, 9th feature
figure(5);
N=size(feafilled,1);
% autocorr(feafilled(:,9),N-1,2,2);
% figure(7);
[acf1,lags,bounds] = autocorr(feafilled(:,9),N-1,2,2);
plot(acf1,'r');
hold on;
[acf2,lags,bounds] = autocorr(fea_nm(:,9),N-1,2,2);
plot(acf2,'g');
[acf3,lags,bounds] = autocorr(fea_nz(:,9),N-1,2,2);
plot(acf3,'b');
legend('Befor normalization','Normalization:Min-Max','Normalization:Z-score');
xlabel('Lag'),ylabel('AUTOCORRELATION');
title('9th Feature£ºAuto-correlation');
%% auto-correlation before and after normalization, 24th feature
figure(6);
N=size(feafilled,1);
[acf1,lags,bounds] = autocorr(feafilled(:,24),N-1,2,2);
plot(acf1,'r');
hold on;
[acf2,lags,bounds] = autocorr(fea_nm(:,24),N-1,2,2);
plot(acf2,'g');
[acf3,lags,bounds] = autocorr(fea_nz(:,24),N-1,2,2);
plot(acf3,'b');
legend('Befor normalization','Normalization:Min-Max','Normalization:Z-score');
xlabel('Lag'),ylabel('AUTOCORRELATION');
title('24th Feature£ºAuto-correlation');
end

%% do min-max normalize
function fea_nm=normalize(fea)
X=fea;
[M,N]=size(X);
Xmin=repmat(min(X),M,1);
Xmax=repmat(max(X),M,1);
fea_nm=(X-Xmin)./(Xmax-Xmin);
end

%% do Z-score normalization
function fea_zm=normZ(fea)
X=fea;
[M,N]=size(X);
Xmean=repmat(mean(X),M,1);
X_std=std(X);
X_std1=repmat(X_std,M,1);
fea_zm=(X-Xmean)./X_std1;
end