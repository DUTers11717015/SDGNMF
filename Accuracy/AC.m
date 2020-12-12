%
% DSNMFC算法
% 准确率AC
%

clc
clear all
close all
% 预处理

% Yale-32数据集上的准确率
k=[2:10];

Yale_sdnmf=[95.46 93.94 91.17 90.91 87.87 83.24 81.05 78.78 73.33];   % 最高值
Yale_dcnmf=[94.00 92.71 90.93 89.62 85.19 80.36 79.27 76.25 71.65];
Yale_dnmf=[92.71 90.08 88.22 87.29 83.66 79.11 76.08 73.16 70.43];
Yale_gnmf=[90.35 88.79 85.37 82.20 80.05 76.86 75.01 69.71 68.83];
Yale_cnmf=[89.23 86.31 82.42 79.91 76.63 72.58 70.82 69.55 65.06];
Yale_nmf=[85.02 80.49 81.03 75.86 71.01 69.17 65.74 66.67 61.51];

figure(1)
plot(k,Yale_sdnmf,'-+b',k,Yale_dcnmf,'-om',k,Yale_dnmf,'-<c',k,Yale_gnmf,'- s g',k,Yale_cnmf,'-*r',k,Yale_nmf,'- d k','LineWidth',1);
%plot(k,Yale_mcnmfff,'- diamond k',k,Yale_gcnmfs,'-*k',k,Yale_cnmfs,'-^k',k,Yale_gnmf,'-ok',k,Yale_nmf,'- square k','LineWidth',2);
xlabel('\itk');
ylabel('Clustering accuracy (ACC)/(%)')
legend('DSNMFC','DCNMF','DNMF','GNMF','CNMF','NMF');
title('Yale-32');


% ORL-32数据集上的AC
k=[2:10];

ORL_sdnmf=[97.81 94.00 93.10 91.42 87.07 85.44 84.29 80.20 76.53];
ORL_dcnmf=[96.07 93.12 92.95 89.60 86.05 84.14 80.38 77.25 74.40];
ORL_dnmf=[95.32 91.59 93.10 87.68 85.04 81.43 79.25 76.29 73.82];
ORL_gnmf=[94.85 91.09 89.08 86.21 81.43 80.38 78.85 74.51 72.65];
ORL_cnmf=[92.57 89.15 88.95 83.88 80.02 79.55 73.51 69.35 70.65];
ORL_nmf=[89.20 85.49 87.89 80.21 78.65 72.53 68.03 65.30 63.34];

figure(2)
plot(k,ORL_sdnmf,'-+b',k,ORL_dcnmf,'-om',k,ORL_dnmf,'-<c',k,ORL_gnmf,'- s g',k,ORL_cnmf,'-*r',k,ORL_nmf,'- d k','LineWidth',1);
xlabel('\itk');
ylabel('Clustering accuracy (ACC)/(%)')
legend('SDNMF ','DCNMF','DNMF','GNMF','CNMF','NMF');
title('ORL-32');

% COIL20数据集上的AC
k=[2:10];

COIL_sdnmf=[97.87 94.42 91.28 90.51 88.86 86.05 85.19 83.50 78.89];
COIL_dcnmf=[95.64 91.59 89.74 88.21 86.90 84.95 84.42 77.85 75.26];
COIL_dnmf=[92.89 90.22 89.85 86.93 85.49 81.28 77.45 75.80 70.64];
COIL_gnmf=[90.26 89.75 88.97 86.01 84.26 80.75 76.27 71.78 69.22];
COIL_cnmf=[89.85 88.07 87.26 85.90 83.07 79.41 75.50 69.41 70.37];
COIL_nmf=[86.88 85.28 80.09 79.47 78.15 75.27 71.64 69.04 66.92];

figure(3)
plot(k,COIL_sdnmf,'-+b',k,COIL_dcnmf,'-om',k,COIL_dnmf,'-<c',k,COIL_gnmf,'- s g',k,COIL_cnmf,'-*r',k,COIL_nmf,'- d k','LineWidth',1);
xlabel('\itk');
ylabel('Clustering accuracy (ACC)/(%)')
legend('SDNMF','DCNMF','DNMF','GNMF','CNMF','NMF');
title('COIL20');


% PIE-pose27数据集上的AC
k=[2:10];

PIE_sdnmf=[94.31 90.09 87.14 85.19 80.48 79.93 76.59 74.17 71.90];
PIE_dcnmf=[92.84 89.72 85.43 83.89 78.58 77.06 75.21 73.38 70.14];
PIE_dnmf=[88.54 85.42 80.95 77.95 75.49 73.38 72.45 69.94 66.72];
PIE_gnmf=[80.38 78.85 76.68 73.19 72.44 70.03 70.92 68.75 64.46];
PIE_cnmf=[78.00 74.88 75.59 72.24 70.85 70.00 69.76 67.29 60.68];
PIE_nmf=[75.31 67.57 65.88 64.29 63.25 61.32 59.51 56.27 58.65];

figure(4)
plot(k,PIE_sdnmf,'-+b',k,PIE_dcnmf,'-om',k,PIE_dnmf,'-<c',k,PIE_gnmf,'- s g',k,PIE_cnmf,'-*r',k,PIE_nmf,'- d k','LineWidth',1);
xlabel('\itk');
ylabel('Clustering accuracy (ACC)/(%)')
legend('SDNMF','DCNMF','DNMF','GNMF','CNMF','NMF');
title('PIE-pose27');

