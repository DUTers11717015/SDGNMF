function main(dataset,KClass,algo)

%
% main.m 
% SDGNMF
% Sparse dual graph-regularized NMF for image co-clustering[J]. Neurocomputing, 2018, 316(NOV.17):156-165.
% dataset   - 'COIL20'  'PIE_pose27'  'Yale_32' or 'ORL_32'
% KClass = 2 3 4 5 6 7 8 9 10。。。    要在原始数据集中选取的类数进行实验
% algo - 'Binary' 'HeatKernel' 'Cosine'   是图正则的核函数
%    
dataset='ORL_32';
KClass=36;
algo='Binary';
tic

% 循环 20/50 次求平均
HXac=[];    % 预分配
HXmi=[];    % 预分配

% for h=1:20
 for h=1:1
    
%--------------------------------------------------------------------------
%                            Dataset
%--------------------------------------------------------------------------
switch dataset,
  
 case 'COIL20',
     load('COIL20.mat');	
     nClass = length(unique(gnd));
     fname='SDGNMF-COIL';      
     fea = NormalizeFea(fea);    % Normalize each data vector to have L2-norm equal to 1  
 
 case 'PIE_pose27',
     load('PIE_pose27.mat');	
     nClass = length(unique(gnd));
     fname='SDGNMF-PIE';  
     fea = NormalizeFea(fea);    % Normalize each data vector to have L2-norm equal to 1  
     
 case 'Yale_32',
     load('Yale_32.mat');	
     nClass = length(unique(gnd));
     fname='SDGNMF-Yale'; 
     fea=NormalizeFea(fea);      % Normalize each data vector to have L2-norm equal to 1  

 case 'ORL_32',
     load('ORL_32.mat');	
     nClass = length(unique(gnd));
     fname='SDGNMF-ORL';
     fea = NormalizeFea(fea);    % Normalize each data vector to have L2-norm equal to 1  
end

% 》》》》》--- 从原数据集中取出 KClass 类为原始分解矩阵 X ---《《《《《《 %

All=length(gnd);        % 样本数
Per=All/nClass;         % 每个类中含有的样本数
Kmix=randperm(nClass);  % 打乱标签的顺序
Klei=Kmix(1:KClass);    % 取随机乱序后的 Klei 类(所要的类数Klei=2,3，……，10)

% 取出这 Klei 类的特征和标签组成原始分解矩阵 X

% 例如：
% 如果是 KClass=2,则取出特征矩阵如下：
% TempFea=[fea(1+(Klei(1)-1)*Per:Klei(1)*Per,:);fea(1+(Klei(2)-1)*Per:Klei(2)*Per,:)];

TempFea=[fea(1+(Klei(1)-1)*Per:Klei(1)*Per,:)];
for i=2:KClass
    TempFea=cat(1,TempFea,fea(1+(Klei(i)-1)*Per:Klei(i)*Per,:));
end
fea=TempFea;        % 获得新的特征矩阵
fea = NormalizeFea(fea);
TempGnd=[gnd(1+(Klei(1)-1)*Per:Klei(1)*Per,:)];
for i=2:KClass
    TempGnd=cat(1,TempGnd,gnd(1+(Klei(i)-1)*Per:Klei(i)*Per,:));
end
gnd=TempGnd;        % 获得新的标签矩阵

% 重新规定 gnd 中的标签
for i=1:KClass
    gnd((1+Per*(i-1):Per*i),:)=i;
end

%  ===========================  半监督约束  ==============================%

%——  随机挑选每个类中的10%（或者更多）样本作为有标签的样本  ——%

Xnew=[fea,gnd];     % 合并特征矩阵和标签矩阵，最后一列为标签

X=fea;          %  ---》》》》》》》》》》》》》》》》》》》》》》》》
[nSmp,mFea]=size(X);    % mFea是特征维数 nSmp是样本数

SmpNumPerClass=nSmp/KClass;     % 每个类中所含的样本数

if strcmp(dataset,'ORL')        % 判断两个字符串相等，如果是数据集ORL则每个类中取两个样本
    NumP=ceil(SmpNumPerClass*0.2);
else
    NumP=ceil(SmpNumPerClass*0.1);     % 每类中提取 10% 的样本作为每个类中所含的标签的样本
end

% 选取每类中的10%个样本
temp=[];            % 预分配,存放选取的样本
NumRow=[];          % 预分配，所要选取的样本行号
for i=1:KClass      % 类别数 
    rowrank=randperm(NumP);    % 随机生成（1，2，……，n）的正整数函数(是一个行向量)
    rowrank=rowrank+(i-1)*SmpNumPerClass;
    temp=cat(1,temp,Xnew(rowrank,:));       % 连接数组
    
    % 存储已经提取出来的行号组成矩阵NumRow,该矩阵的长度（大小）即为有标签样本的个数
    NumRow=cat(2,NumRow,rowrank);
end

% 有标签样本（选取样本——各类中选取10%样本）的总个数
gndSmpNum=length(NumRow);

% temp 中便是提取出来的有标签的样本,并按照标签的顺序1 2 3……分别排列

%  =======================  重新构造原始矩阵 X  =======================  %
% 为了得到我们想要的矩阵X，我们要先删除已经提取出来的行（样本），然后再将提取出来的样本放到矩阵的前面，这样以来，前面的NumSmp行就是已知标签的样本
Xnew(NumRow,:)=[];      % 将提取出来的行加入到 Xnew 中组成原始矩阵 X
X=cat(1,temp,Xnew);     % 连接函数，将矩阵temp放到Xnew矩阵上面形成我们想要的矩阵

% ======== 去掉已经提取出来的有标签的样本，剩余的为未知标签的样本 ======= %
XSmpgnd=X(:,end);
X(:,end)=[];            % 删除最后一列（标签列），此时标签不再有用
 
X=X';                   % 取矩阵转置，一列为一个样本，一行为各个样本的一个特征
% ======================== < 原始矩阵 X 初始化完成 > =================== %

[mFea,nSmp]=size(X);    % mFea是特征维数 nSmp是样本数

%  ====================  构造指示矩阵 C ===================  %
C=zeros(gndSmpNum,KClass);     % （有标签的样本数，类数）
for j=1:KClass                 % 控制列数，类别数
    for i=1:gndSmpNum          % 控制行数，样本数
        if XSmpgnd(i,1)==j     % 如果X中已知标签样本的标签等于类别号
            C(i,j)=1;
        end
    end
end
% =================  < 构造指示矩阵 C 完毕 > ==============  %

I=eye(nSmp-gndSmpNum);         % 单位矩阵，维数为(样本数-已知标签的样本数)

% ================  构造标签约束矩阵 A =================== %
A=zeros(nSmp,nSmp-gndSmpNum+KClass);
A(1:gndSmpNum,1:KClass)=C;
A(gndSmpNum+1:end,KClass+1:end)=I;
% ==================  构造矩阵 A 完毕！ ================== %

%  ==========================  约 束 完 毕！  ==========================  %

% =============================   稀疏约束   ============================ %
sU=0.6; % 定义稀疏系数
sV=[];% 定义稀疏系数
% =============================   稀疏约束完毕   =======================  %

% =============================  图正则处理  ===========================  %

%-------------------------------------------------------------------------
%                            algo —— Binary、HeatKernel and Cosine
%-------------------------------------------------------------------------
options = [];

switch algo
    case 'Binary'
        options.WeightMode = 'Binary';
        
        switch dataset
            case 'COIL20'
                rand('twister',5489);
                fname='SDGNMF-COIL';
            case 'PIE_pose27'
                rand('twister',5489);
                fname='SDGNMF-PIE';
            case 'Yale_32'
                % rng('default');
                fname='SDGNMF-Yale';
            case 'ORL_32'
                rng('default');
                fname='SDGNMF-ORL';
        end
        
    case 'HeatKernel'
        options.WeightMode = 'HeatKernel';
        
        switch dataset
            case 'COIL20'
                rand('twister',5489);
                fname='SDGNMF-COIL';
            case 'PIE_pose27'
                rand('twister',5489);
                fname='SDGNMF-PIE';
            case 'Yale_32'
            %    rng('default');
                fname='SDGNMF-Yale';
            case 'ORL_32'
                rng('default');
                fname='SDGNMF-ORL';
        end

    case 'Cosine'
        options.WeightMode = 'Cosine';
        
        switch dataset
            case 'COIL20'
                rand('twister',5489);
                fname='SDGNMF-Cosine-COIL';
            case 'PIE_pose27'
                rand('twister',5489);
                fname='SDGNMF-Cosine-PIE';
            case 'Yale_32'
                rng('default');
                fname='SDGNMF-Cosine-Yale';
            case 'ORL_32'
                rng('default');
                fname='SDGNMF-Cosine-ORL';
        end
end


maxIter = 300;          % 最大迭代次数
options = [];
options.Metric = 'Euclidean';
options.NeighborMode = 'KNN';
options.k =4;
options.WeightMode = 'Binary';
options.t = 1;

WZ = constructW(fea, options);
for i=1:size(WZ,1)
    WZ(i,i)=0;
end

options = [];
options.Metric = 'Euclidean';
options.NeighborMode = 'KNN';
options.k =4;
options.WeightMode = 'Binary';
options.t = 1;

WU = constructW(fea',options);
for i=1:size(WU,1)
    WU(i,i)=0;
end

% ====================  图正则结束  =============================== %

% 调用SDGNMF函数
Iter = 300;
maxIter=300;
% KClass = length(unique(gnd));
lambda = 100;
mu = lambda;

  [U_final, V_final, obj] = SDGNMF(fea', WU, WZ, KClass, lambda, mu, sU, A, maxIter,gndSmpNum)
  
U=U_final;
V=V_final;
save('V','V');
save('U','U');
%=================== 显示基矩阵 =====================%
figure(1)
 switch dataset
     case 'COIL20'
         visual(U,3,5);
         title(fname);
     case 'PIE_pose27'
         visual(U,3,5);
         %visual(U,3,9);
         title(fname);
     case 'Yale_32'
         visual(U,3,5);
         title(fname);
     case 'ORL_32',
         visual(U,3,6);
         %visual(U,3,10);
        title(fname);
 end
%=================== 显示收敛性曲线 ========================%
 figure(2)
 load(fname);
 
 plot(obj(3:end));
 title(fname);
 xlabel('Iteration');
 ylabel('Objective function value')
 legend('SDGNMF')
 
 %=================== 显示稀疏度 ========================%
 
[sp1F,sp12,sp2F,sp22,sp3F,sp32]=sp1(U)

 %=================== 显示聚类结果 AC and NMI ========================%

        label = litekmeans(V,KClass,'Replicates',20);
        save('label','label');
        MIhat = MutualInfo(gnd,label);      %  聚类后的标签与原标签的互信息
        HXmi(h)=MIhat;                      % 存储
        disp(['Clustering in the SDGNMF subspace. MIhat: ',num2str(MIhat)]);
    
        disp(['KClass=',num2str(KClass),'  运行完毕！']); 
        
        newL2=bestMap(gnd,label);
        AC=Accuracy(newL2,gnd);
        HXac(h)=AC;
        disp(['Clustering in the SDGNMF subspace. AC: ',num2str(AC)]);   

end

save('MIhat','HXmi');
save('AC','HXac');
load('MIhat.mat');
load('AC.mat');
 AverageAC=sum(HXac')/1
AverageMI=sum(HXmi')/1

toc  %  显示运行时间
