%
% 参数选择
% 惩罚函数c与AC的关系，AC图1
% 核函数g与AC的关系，AC图2
%

clc
clear all
close all
% 预处理完成

% 惩罚函数c的取值范围
c=[2:5:97];

% 三个数据集的平均准确率

AC_c_COIL=[0.81 0.67 0.68 0.76 0.53 0.70 0.61 0.54 0.63 0.68 0.52 0.73 0.64 0.59 0.62 0.73 0.61 0.58 0.77 0.67];
AC_c_PIE=[0.76 0.651 0.54 0.58 0.49 0.45 0.56 0.68 0.73 0.51 0.64 0.72 0.65 0.58 0.53 0.65 0.54 0.67 0.40 0.57];
AC_c_Yale=[0.90 0.73 0.64 0.85 0.67 0.52 0.61 0.48 0.58 0.68 0.73 0.84 0.67 0.61 0.48 0.58 0.61 0.73 0.64 0.37];

figure(1)
plot(c,AC_c_COIL,'-.o r',c,AC_c_PIE,'--*k',c,AC_c_Yale,'- diamond b')
xlabel('惩罚函数c');
ylabel('准确率（%）');
legend('COIL','PIE','Yale');
% axis([0 1 0.45 1]);
% set(gca,'position',[0.1 0.1 .845 .845]);

% 核函数g的取值范围
g=[1:5:96];

% 三个数据集的平均准确率
AC_g_COIL=[0.85 0.74 0.62 0.67 0.71 0.82 0.65 0.72 0.64 0.57 0.54 0.68 0.80 0.72 0.61 0.63 0.72 0.64 0.59 0.62];
AC_g_PIE=[0.80 0.69 0.61 0.70 0.58 0.67 0.62 0.53 0.63 0.70 0.77 0.71 0.73 0.63 0.48 0.58 0.61 0.76 0.66 0.57];
AC_g_Yale=[0.94 0.81 0.72 0.78 0.67 0.59 0.67 0.72 0.80 0.63 0.75 0.81 0.90 0.79 0.74 0.83 0.88 0.72 0.68 0.77 ];

figure(2)
plot(g,AC_g_COIL,'-.o r',g,AC_g_PIE,'-- * k',g,AC_g_Yale,'- diamond b');
xlabel('核函数g');
ylabel('准确率（%）');
legend('COIL','PIE','Yale');

% axis([0 1 0.45 1]);
% set(gca,'position',[0.1 0.1 .845 .845]);
