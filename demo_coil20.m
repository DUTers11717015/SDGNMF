% Graph Dual Regularized Nonnegative Matrix Factorization
% by Fanhua Shang
% Key Laboratory of Intelligent Perception and Image Understanding of Ministry of Education of China,
% Xidian University, Xi'an 710071, China.
%
% References: 
% Fanhua Shang, Licheng Jiao, and Fei Wang,
% Graph Dual Regularization Non-negative Matrix Factorization 
% for Co-clustering, Pattern Recognition, 45(6): 2237-2250, 2012.

clear 
clc
% load('coil20.mat')
load('COIL20.mat')


options = [];
options.Metric = 'Euclidean';
options.NeighborMode = 'KNN';
options.k =4;
options.WeightMode = 'Binary';
options.t = 1;

WV = constructW(data, options);
for i=1:size(WV,1)
    WV(i,i)=0;
end

options = [];
options.Metric = 'Euclidean';
options.NeighborMode = 'KNN';
options.k =4;
options.WeightMode = 'Binary';
options.t = 1;

WU = constructW(data',options);
for i=1:size(WU,1)
    WU(i,i)=0;
end



%%% DNMF
Iter = 300;
c = length(unique(label));
lambda = 200;
mu = lambda;

[U V obj] = DNMF(data', WU, WV, c, lambda,mu, Iter);


figure (1)
subplot(1,2,1)
plot(log(obj)) 
xlabel ('Number of iterations')
ylabel ('Log objective')


idx1 = kmeans(V, c, 'Replicate', 20);
nmi_DNMF = nmi(label, idx1);
acc_DNMF = 1-evalClust_Error(label, idx1);


%%% DNMTF
Iter = 300;
c1 = c;
c2 = c;
lambda = 200;
mu = lambda;
[U S V obj] = DNMTF(data', WU, WV, c1, c2, lambda, mu, Iter);

figure (1)
subplot(1,2,2)
plot(log(obj)) 
xlabel ('Number of iterations')
ylabel ('Log objective')

idx2 = kmeans(V, c,'Replicate', 20);
nmi_DNMTF = nmi(label, idx2);
acc_DNMTF = 1-evalClust_Error(label, idx2);
