%
% ****算法
% 选取有标签样本比例与分类准确率的关系
%

clc
clear all
close all
% 预处理

R=[10:10:100];      % 有标签样本选取比例

COIL_ac=[70.75 73.18 77.61 83.05 88.25 90.42 95.34 95.87 98.62 100];
PIE_ac=[64.32 68.72 71.22 73.48 76.91 78.00 80.51 85.37 88.35 100];
Yale_ac=[82.57 86.64 89.75 92.64 95.34 97.67 98.46 98.94 99.00 100];

figure(1)
plot(R,COIL_ac,'-*r',R,PIE_ac,'-om',R,Yale_ac,'-xb');
xlabel('选择有标签样本比例（%）');
ylabel('准确率（%）')
legend('COIL','PIE','Yale');