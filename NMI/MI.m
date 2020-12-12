%
% SDNMF算法
% 互信息MI
%

clc
clear all
close all
% 预处理

% Yale-32数据集上的互信息
k=[2:10];

Yale_sdnmf=[93.47 90.25 84.31 85.81 81.18 83.01 79.33 78.05 73.94];   % 最高值
Yale_dcnmf=[90.57 84.61 85.43 82.05 74.96 78.34 76.62 75.88 72.48];
Yale_dnmf=[89.09 82.73 83.92 79.58 74.96 71.71 70.66 72.94 70.16];
Yale_gnmf=[86.83 78.35 81.01 78.84 70.81 74.28 70.64 64.88 62.94];
Yale_cnmf=[86.36 74.28 75.03 70.05 73.28 68.89 69.35 62.25 61.38];
Yale_nmf=[82.53 73.02 70.96 68.60 65.40 67.75 66.67 61.51 60.60];

figure(1)
plot(k,Yale_sdnmf,'-+b',k,Yale_dcnmf,'-om',k,Yale_dnmf,'-<c',k,Yale_gnmf,'- s g',k,Yale_cnmf,'-*r',k,Yale_nmf,'- d k','LineWidth',1);
xlabel('\itk');
ylabel('Normalized mutual information (NMI)/(%)')
legend('SDNMF','DCNMF','DNMF','GNMF','CNMF','NMF');
title('Yale-32');            


% ORL-32数据集上的互信息
k=[2:10];

ORL_sdnmf=[94.41 92.90 90.08 87.25 85.71 80.50 83.09 76.52 73.27];   % 最高值
ORL_dcnmf=[93.33 89.23 90.22 85.89 83.09 80.01 79.58 75.94 73.05];
ORL_dnmf=[92.48 88.48 90.47 85.36 81.12 79.59 77.74 74.64 72.66];
ORL_gnmf=[91.90 89.86 86.99 83.50 79.59 77.25 74.40 70.31 72.75];
ORL_cnmf=[90.68 84.28 86.29 81.19 78.84 73.28 69.45 70.01 66.60];
ORL_nmf=[85.94 81.67 83.26 79.65 76.43 67.54 64.20 66.16 62.52];

figure(2)
plot(k,ORL_sdnmf,'-+b',k,ORL_dcnmf,'-om',k,ORL_dnmf,'-<c',k,ORL_gnmf,'- s g',k,ORL_cnmf,'-*r',k,ORL_nmf,'- d  k','LineWidth',1);
xlabel('\itk');
ylabel('Normalized mutual information (NMI)/(%)')
legend('SDNMF','DCNMF','DNMF','GNMF','CNMF','NMF');
title('ORL-32');


% COIL20数据集上的MI
k=[2:10];

COIL_sdnmf=[95.08 90.94 91.42 87.44 87.75 83.49 81.58 78.09 81.02];
COIL_dcnmf=[92.73 89.50 91.70 86.03 83.09 81.57 77.67 75.40 74.75];
COIL_dnmf=[91.54 86.95 88.28 81.40 83.31 79.12 74.35 75.12 73.51];
COIL_gnmf=[89.31 82.98 85.28 80.81 78.47 77.95 72.22 74.71 72.83];
COIL_cnmf=[87.23 80.66 80.90 77.78 74.97 76.23 69.87 73.60 71.31];
COIL_nmf=[85.78 77.03 79.91 73.60 70.21 62.91 66.86 62.74 64.47];

figure(3)
plot(k,COIL_sdnmf,'-+b',k,COIL_dcnmf,'-om',k,COIL_dnmf,'-<c',k,COIL_gnmf,'- s g',k,COIL_cnmf,'-*r',k,COIL_nmf,'- d k','LineWidth',1);
xlabel('\itk');
ylabel('Normalized mutual information (NMI)/(%)')
legend('SDNMF','DCNMF','DNMF','GNMF','CNMF','NMF');
title('COIL20');


% PIE-pose27数据集上的互信息
k=[2:10];

PIE_sdnmf=[91.67 87.66 88.03 83.68 81.24 75.35 70.03 74.95 71.17];  % 最高值
PIE_dcnmf=[90.45 83.19 88.90 81.10 76.32 74.11 67.34 69.00 65.17];
PIE_dnmf=[85.89 77.14 80.02 79.33 73.71 68.99 64.58 63.02 62.85];
PIE_gnmf=[80.85 74.51 71.64 74.05 69.38 70.35 69.21 67.25 65.48];
PIE_cnmf=[75.12 71.45 65.37 68.15 68.85 69.30 70.61 65.91 66.72];
PIE_nmf=[70.13 63.30 66.17 65.89 60.54 61.29 58.00 60.02 58.46];

figure(4)
plot(k,PIE_sdnmf,'-+b',k,PIE_dcnmf,'-om',k,PIE_dnmf,'-<c',k,PIE_gnmf,'- s g',k,PIE_cnmf,'-*r',k,PIE_nmf,'- d k','LineWidth',1);
xlabel('\itk');
ylabel('Normalized mutual information (NMI)/(%)')
legend('SDNMF','DCNMF','DNMF','GNMF','CNMF','NMF');
title('PIE-pose27');

