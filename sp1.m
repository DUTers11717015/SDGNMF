function [sp1F,sp12,sp2F,sp22,sp3F,sp32]=sp1(U)
% 
% ���������߾����ϡ��Ⱥ���
% U��Ҫ����������߾���
%

% ����Ǿ�����Ҫ����ת���������󿴳���������

[m,n]=size(U);
Max=max(m,n);     % ������ά��
 Nin=min(m,n)
% if Nin~=1       % ����ת��Ϊ������
%     T=U(:);
%     U=T;
% end
    sp1F=(sqrt(n)-(norm(U,1)/norm(U,'fro')))/(sqrt(n)-1);
    sp12=(sqrt(n)-(norm(U,1)/norm(U,2)))/(sqrt(n)-1);
    sp2F=(n-(norm(U,1)/norm(U,'fro'))^2)/(n-1);
    sp22=(n-(norm(U,1)/norm(U,2))^2)/(n-1);
    sp3F=(sqrt(n)-(sum(sum(U)')/norm(U,'fro')))/(sqrt(n)-1);
    sp32=(sqrt(n)-(sum(sum(U)')/norm(U,2)))/(sqrt(n)-1);
    
    % һ���������������һ���ġ����ķ��������һ���ġ�