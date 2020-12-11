function [U_final, V_final, obj] = SDGNMF(X, WU, WZ, k, lambda, mu, sU, A, maxIter,gndSmpNum)
%
% Sparse dual graph-regularized NMF for image co-clustering
% by Jing Sun, Dalian University of Technology, Dalian, China.
%
% min ||X-U*Z'*A'||^2+lambda*tr(U'*(DU-WU)*U)+mu*tr(Z'*A'*(DV-WV)*A*Z)+sU*U
% s.t. U>=0, Z>=0.
% X:          NxM input data matrix
% WU:         NxN adjacency matrix of the data graph
% WV:         MxM adjacency matrix of the feature graph
% c:          number of hidden factors
% lambda, mu: Regularization parameters
% T:          number of iterations
%
% References: 
% Sun J , Wang Z , Sun F , et al., 
% Sparse dual graph-regularized NMF for image co-clustering[J],
% Neurocomputing, 2018, 316(NOV.17):156-165.

if ~isempty(WU)
    DU = diag(sum(WU));
    LU = DU - WU;
    LU_P = (abs(LU) + LU)/2;
    LU_N = (abs(LU) - LU)/2;
end

if ~isempty(WZ)
    DZ = diag(sum(WZ));
    LZ = DZ - WZ;
    LZ_P = (abs(LZ) + LZ)/2;
    LZ_N = (abs(LZ) - LZ)/2;
end

[M N] = size(X);
KClass=k;
SmpClass=KClass;        % 变量重命名
NumLab=gndSmpNum;       % 变量重命名
U = abs(randn(M, k));
% V = abs(randn(N, k));
Z = abs(randn(N+SmpClass-NumLab, k));
V=A*Z;


feaSum = full(sum(X, 2));
D_half = (X'*feaSum).^.5;
for i = 1: N
    X(:,i) = X(:,i)/D_half(i);
end

eps = 1e-4; 
maxIter=300;
obj = [];
for iter = 1:maxIter
    
    iter
        
     % ===================== update U ========================
     U = U.*(X*V + lambda*LU_N*U)./((U*V')*V + lambda*LU_P*U + sU*U+eps);

%    % ===================== update V ========================
%      V = V.*(X'*U + mu*LZ_N*V)./((U*V')'*U + mu*LZ_P*V + eps);
     
     % ===================== update Z ========================
              FZ=A'*X'*U+mu*A'*LZ_N*V;
              FM=A'*V*U'*U+mu*A'*LZ_P*V;
        
              Z = Z.*(FZ./max(FM,1e-10));   % 3mk
              
      % ===================== Normalization of U and V ========================         
              norms = sqrt(sum(U.^2, 1));
              U = U./repmat(norms, M, 1);
%             V = V.*repmat(norms, N, 1);
              V=A*Z;
              V = V.*repmat(norms, N, 1);
              
       % ===================== The objective function ========================         
              
     temp = sum(sum((X - U*Z'*A').^2)) + lambda*trace(U'*LU*U) + mu*trace(Z'*A'*LZ*A*Z)+ sU*U;
     if temp < eps
         break;
     end
    
     obj = [obj, temp];
     U_final=U;
     V_final=V;
end
 