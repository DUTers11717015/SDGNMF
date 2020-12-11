function [sp1F,sp12,sp2F,sp22,sp3F,sp32]=sp1(U)
% 
% 求向量或者矩阵的稀疏度函数
% U是要求的向量或者矩阵
%

% 如果是矩阵，则要进行转换，将矩阵看成是向量。

[m,n]=size(U);
Max=max(m,n);     % 求矩阵的维度
 Nin=min(m,n)
% if Nin~=1       % 矩阵转换为列向量
%     T=U(:);
%     U=T;
% end
    sp1F=(sqrt(n)-(norm(U,1)/norm(U,'fro')))/(sqrt(n)-1);
    sp12=(sqrt(n)-(norm(U,1)/norm(U,2)))/(sqrt(n)-1);
    sp2F=(n-(norm(U,1)/norm(U,'fro'))^2)/(n-1);
    sp22=(n-(norm(U,1)/norm(U,2))^2)/(n-1);
    sp3F=(sqrt(n)-(sum(sum(U)')/norm(U,'fro')))/(sqrt(n)-1);
    sp32=(sqrt(n)-(sum(sum(U)')/norm(U,2)))/(sqrt(n)-1);
    
    % 一二五六方法结果是一样的。三四方法结果是一样的。