data = [20.457, 45.578; 12.016, 22.422];
b = bar(data);
ch = get(b,'children');
set(gca,'XTickLabel',{'ѵ������','���Թ���'})
legend('�������ĵ������ķ����㷨','���bigram�����ĵ����������㷨');
% ylabel('����ʱ��(��λ:��)');
ylabel('����ʱ��/s');

% figure(1)
% % ORL���ݼ��ϵ�ƽ������ʱ��
% 30.39;15.50;14.42;14.50;14.58
% data=[30.39;15.50;14.42;14.50;14.58];
% b = bar(data);
% ch = get(b,'children');
% set(gca,'XTickLabel',{'nmf','gnmf','inmf','ignmf','ginmfsc'})
% 
% xlabel('�Ա��㷨');
% ylabel('ƽ������ʱ��(��λ:��)');
% title('ORL');

figure(1)
% Yale-32���ݼ��ϵ�ƽ������ʱ��
30.39;14.90;15.50;14.50;14.68
data=[30.39;14.90;15.50;14.50;14.68];
b = bar(data);
ch = get(b,'children');
set(gca,'XTickLabel',{'nmf','gnmf','cnmfs','gcnmfs','mcnmfff'})

xlabel('�Ա��㷨');
ylabel('ƽ������ʱ��/s');
title('Yale-32');


figure(2)
% COIL20���ݼ��ϵ�ƽ������ʱ��
205.63;107.96;109.77;104.19;105.59
data=[205.63;107.96;109.77;104.19;105.59];
b = bar(data);
ch = get(b,'children');
set(gca,'XTickLabel',{'nmf','gnmf','cnmfs','gcnmfs','mcnmfff'})

xlabel('�Ա��㷨');
ylabel('ƽ������ʱ��/s');
title('COIL20');

% figure(3)
% % PIE-pose27���ݼ��ϵ�ƽ������ʱ��
% 305.63;154.30;150.48;151.60;152.84
% data=[305.63;154.30;150.48;151.60;152.84];
% b = bar(data);
% ch = get(b,'children');
% set(gca,'XTickLabel',{'nmf','gnmf','inmf','ignmf','ginmfsc'})
% 
% xlabel('�Ա��㷨');
% ylabel('ƽ������ʱ��(��λ:��)');
% title('PIE-pose27');
