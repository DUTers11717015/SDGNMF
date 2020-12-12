data = [20.457, 45.578; 12.016, 22.422];
b = bar(data);
ch = get(b,'children');
set(gca,'XTickLabel',{'训练过程','测试过程'})
legend('基于类文档排名的分类算法','结合bigram的类文档排名分类算法');
% ylabel('所用时间(单位:秒)');
ylabel('所用时间/s');

% figure(1)
% % ORL数据集上的平均运行时间
% 30.39;15.50;14.42;14.50;14.58
% data=[30.39;15.50;14.42;14.50;14.58];
% b = bar(data);
% ch = get(b,'children');
% set(gca,'XTickLabel',{'nmf','gnmf','inmf','ignmf','ginmfsc'})
% 
% xlabel('对比算法');
% ylabel('平均运行时间(单位:秒)');
% title('ORL');

figure(1)
% Yale-32数据集上的平均运行时间
30.39;14.90;15.50;14.50;14.68
data=[30.39;14.90;15.50;14.50;14.68];
b = bar(data);
ch = get(b,'children');
set(gca,'XTickLabel',{'nmf','gnmf','cnmfs','gcnmfs','mcnmfff'})

xlabel('对比算法');
ylabel('平均运行时间/s');
title('Yale-32');


figure(2)
% COIL20数据集上的平均运行时间
205.63;107.96;109.77;104.19;105.59
data=[205.63;107.96;109.77;104.19;105.59];
b = bar(data);
ch = get(b,'children');
set(gca,'XTickLabel',{'nmf','gnmf','cnmfs','gcnmfs','mcnmfff'})

xlabel('对比算法');
ylabel('平均运行时间/s');
title('COIL20');

% figure(3)
% % PIE-pose27数据集上的平均运行时间
% 305.63;154.30;150.48;151.60;152.84
% data=[305.63;154.30;150.48;151.60;152.84];
% b = bar(data);
% ch = get(b,'children');
% set(gca,'XTickLabel',{'nmf','gnmf','inmf','ignmf','ginmfsc'})
% 
% xlabel('对比算法');
% ylabel('平均运行时间(单位:秒)');
% title('PIE-pose27');
