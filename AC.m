%
% SCNMFS�㷨
% ׼ȷ��AC
%

clc
clear all
close all
% Ԥ����

% COIL���ݼ��ϵ�AC
k=[2:10];

COIL_scnmfs=[99.21 98.00 95.12 92.81 90.37 89.86 89.08 88.23 84.40];
COIL_cnmf=[93.00 90.33 87.04 85.60 83.20 80.86 79.25 77.89 76.05];
COIL_nmf=[90.23 86.99 85.39 80.20 76.50 73.86 70.75 69.01 67.00];
COIL_orig=[77.96 75.91 69.00 67.40 60.96 58.00 55.26 53.33 50.02];

figure(1)
plot(k,COIL_scnmfs,'-*r',k,COIL_cnmf,'-om',k,COIL_nmf,'-xb',k,COIL_orig,'- square k');
xlabel('k');
ylabel('׼ȷ�ʣ�%��')
legend('SCNMFS','CNMF','NMF','ԭʼ�ռ�');
title('COIL');

% PIE���ݼ��ϵ�׼ȷ��
k=[2:10];

PIE_scnmfs=[94.00 90.59 86.88 84.24 78.85 73.19 70.76 68.29 67.68];   % ���ֵ
PIE_cnmf=[80.38 74.44 68.75 67.27 65.75 64.46 62.84 61.36 60.47];
PIE_nmf=[73.59 70.92 66.49 63.02 60.86 58.82 58.04 56.85 55.29];
PIE_orig=[64.58 58.29 53.48 46.83 44.68 40.28 37.72 36.57 31.99];

figure(2)
plot(k,PIE_scnmfs,'-*r',k,PIE_cnmf,'-om',k,PIE_nmf,'-xb',k,PIE_orig,'- square k');
xlabel('k');
ylabel('׼ȷ�ʣ�%��')
legend('SCNMFS','CNMF','NMF','ԭʼ�ռ�');
title('PIE');

% Yale���ݼ��ϵ�׼ȷ��
k=[2:10];

Yale_scnmfs=[99.05 98.59 93.88 90.24 89.85 87.95 87.20 86.29 83.05];   % ���ֵ
Yale_cnmf=[98.31 92.57 85.88 82.29 79.55 76.92 74.51 70.65 70.05];
Yale_nmf=[97.28 86.21 72.73 70.24 69.40 68.03 65.89 63.55 62.29];
Yale_orig=[94.85 80.02 69.89 66.00 63.87 60.07 58.82 56.44 55.92];

figure(3)
plot(k,Yale_scnmfs,'-*r',k,Yale_cnmf,'-om',k,Yale_nmf,'-xb',k,Yale_orig,'- square k');
xlabel('k');
ylabel('׼ȷ�ʣ�%��')
legend('SCNMFS','CNMF','NMF','ԭʼ�ռ�');
title('Yale');
