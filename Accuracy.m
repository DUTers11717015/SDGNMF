function [AC]=Accuracy(label,gnd)

% ������ı�ǩ��ԭ��ǩ�����ƶ�
% -label �����ı�ǩ
% -gnd ���ݼ��е�ԭ��ǩ
% 
[m,n]=size(label);
[M,N]=size(gnd);
delta=0;
if M==m   
    for i=1:m
        if label(i,1)==gnd(i,1)
            delta=delta+1;
        end
    end
else
    disp('�����ǩ�д���');
end
AC=delta/m;