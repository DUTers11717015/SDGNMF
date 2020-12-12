%
% SDNMF算法
% 不同正则化参数值所对应的聚类准确率AC
%

clc
clear all
close all
% 预处理

% Yale数据集上的AC

k=[1e-1 1e0 1e1 1e2 1e3 1e4];

Yale_sdnmf=[80.46 82.94 84.87 86.19 85.87 83.24];  
Yale_dcnmf=[79.95 82.71 84.13 84.44 82.19 80.36];
Yale_dnmf=[79.71 80.68 81.92 82.30 81.66 79.11];
Yale_gnmf=[77.05 77.79 78.37 79.68 78.05 76.86];
Yale_cnmf=[76.95 76.95 76.95 76.95 76.95 76.95];
Yale_nmf=[72.94 72.94 72.94 72.94 72.94 72.94];

figure(1)
plot(k,Yale_sdnmf,'-+b',k,Yale_dcnmf,'-om',k,Yale_dnmf,'-<c',k,Yale_gnmf,'- s g',k,Yale_cnmf,'-*r',k,Yale_nmf,'- d k','LineWidth',1);
xlabel('Regularization parameters \lambda=\mu');
ylabel('Clustering accuracy (ACC)/(%)')
legend('SDNMF','DCNMF','DNMF','GNMF','CNMF','NMF');
title('Yale-32');


% ORL-32数据集上的AC
k=[1e-1 1e0 1e1 1e2 1e3 1e4];

ORL_sdnmf=[81.81 85.00 86.10 87.76 84.07 82.44];
ORL_dcnmf=[81.07 83.12 84.05 85.99 85.75 82.14];
ORL_dnmf=[80.32 81.59 84.10 84.84 83.04 81.43];
ORL_gnmf=[79.15 81.09 82.58 83.23 81.43 79.38];
ORL_cnmf=[80.63 80.63 80.63 80.63 80.63 80.63];
ORL_nmf=[76.74 76.74 76.74 76.74 76.74 76.74];

figure(2)
plot(k,ORL_sdnmf,'-+b',k,ORL_dcnmf,'-om',k,ORL_dnmf,'-<c',k,ORL_gnmf,'- s g',k,ORL_cnmf,'-*r',k,ORL_nmf,'- d k','LineWidth',1);
xlabel('Regularization parameters \lambda=\mu');
ylabel('Clustering accuracy (ACC)/(%)')
legend('SDNMF ','DCNMF','DNMF','GNMF','CNMF','NMF');
title('ORL-32');

% COIL20数据集上的AC

k=[1e-1 1e0 1e1 1e2 1e3 1e4];

COIL_sdnmf=[80.84 84.72 88.02 88.50 85.19 81.39];
COIL_dcnmf=[79.84 81.72 86.02 86.06 84.19 80.39];
COIL_dnmf=[78.12 79.17 80.90 83.39 83.02 81.15];
COIL_gnmf=[77.93 78.33 80.07 81.91 80.50 79.25];
COIL_cnmf=[80.98 80.98 80.98 80.98 80.98 80.98];
COIL_nmf=[76.97 76.97 76.97 76.97 76.97 76.97];

figure(3)
plot(k,COIL_sdnmf,'-+b',k,COIL_dcnmf,'-om',k,COIL_dnmf,'-<c',k,COIL_gnmf,'- s g',k,COIL_cnmf,'-*r',k,COIL_nmf,'- d k','LineWidth',1);
xlabel('Regularization parameters \lambda=\mu');
ylabel('Clustering accuracy (ACC)/(%)')
legend('SDNMF','DCNMF','DNMF','GNMF','CNMF','NMF');
title('COIL20');


% PIE-pose27数据集上的AC

k=[1e-1 1e0 1e1 1e2 1e3 1e4];

PIE_sdnmf=[79.84 82.03 81.82 82.20 81.98 80.96];
PIE_dcnmf=[77.84 80.43 78.72 80.69 79.98 78.96];
PIE_dnmf=[72.54 75.98 76.55 76.76 76.49 75.38];
PIE_gnmf=[68.53 70.33 71.07 72.86 71.50 71.25];
PIE_cnmf=[71.03 71.03 71.03 71.03 71.03 71.03];
PIE_nmf=[63.56 63.56 63.56 63.56 63.56 63.56];

figure(4)
plot(k,PIE_sdnmf,'-+b',k,PIE_dcnmf,'-om',k,PIE_dnmf,'-<c',k,PIE_gnmf,'- s g',k,PIE_cnmf,'-*r',k,PIE_nmf,'- d k','LineWidth',1);
xlabel('Regularization parameters \lambda=\mu');
ylabel('Clustering accuracy (ACC)/(%)')
legend('SDNMF','DCNMF','DNMF','GNMF','CNMF','NMF');
title('PIE-pose27');

