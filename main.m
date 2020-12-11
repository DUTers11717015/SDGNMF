function main(dataset,KClass,algo)

%
% main.m 
% SDGNMF
% Sparse dual graph-regularized NMF for image co-clustering[J]. Neurocomputing, 2018, 316(NOV.17):156-165.
% dataset   - 'COIL20'  'PIE_pose27'  'Yale_32' or 'ORL_32'
% KClass = 2 3 4 5 6 7 8 9 10������    Ҫ��ԭʼ���ݼ���ѡȡ����������ʵ��
% algo - 'Binary' 'HeatKernel' 'Cosine'   ��ͼ����ĺ˺���
%    
dataset='ORL_32';
KClass=36;
algo='Binary';
tic

% ѭ�� 20/50 ����ƽ��
HXac=[];    % Ԥ����
HXmi=[];    % Ԥ����

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

% ����������--- ��ԭ���ݼ���ȡ�� KClass ��Ϊԭʼ�ֽ���� X ---������������ %

All=length(gnd);        % ������
Per=All/nClass;         % ÿ�����к��е�������
Kmix=randperm(nClass);  % ���ұ�ǩ��˳��
Klei=Kmix(1:KClass);    % ȡ��������� Klei ��(��Ҫ������Klei=2,3��������10)

% ȡ���� Klei ��������ͱ�ǩ���ԭʼ�ֽ���� X

% ���磺
% ����� KClass=2,��ȡ�������������£�
% TempFea=[fea(1+(Klei(1)-1)*Per:Klei(1)*Per,:);fea(1+(Klei(2)-1)*Per:Klei(2)*Per,:)];

TempFea=[fea(1+(Klei(1)-1)*Per:Klei(1)*Per,:)];
for i=2:KClass
    TempFea=cat(1,TempFea,fea(1+(Klei(i)-1)*Per:Klei(i)*Per,:));
end
fea=TempFea;        % ����µ���������
fea = NormalizeFea(fea);
TempGnd=[gnd(1+(Klei(1)-1)*Per:Klei(1)*Per,:)];
for i=2:KClass
    TempGnd=cat(1,TempGnd,gnd(1+(Klei(i)-1)*Per:Klei(i)*Per,:));
end
gnd=TempGnd;        % ����µı�ǩ����

% ���¹涨 gnd �еı�ǩ
for i=1:KClass
    gnd((1+Per*(i-1):Per*i),:)=i;
end

%  ===========================  ��ලԼ��  ==============================%

%����  �����ѡÿ�����е�10%�����߸��ࣩ������Ϊ�б�ǩ������  ����%

Xnew=[fea,gnd];     % �ϲ���������ͱ�ǩ�������һ��Ϊ��ǩ

X=fea;          %  ---������������������������������������������������
[nSmp,mFea]=size(X);    % mFea������ά�� nSmp��������

SmpNumPerClass=nSmp/KClass;     % ÿ������������������

if strcmp(dataset,'ORL')        % �ж������ַ�����ȣ���������ݼ�ORL��ÿ������ȡ��������
    NumP=ceil(SmpNumPerClass*0.2);
else
    NumP=ceil(SmpNumPerClass*0.1);     % ÿ������ȡ 10% ��������Ϊÿ�����������ı�ǩ������
end

% ѡȡÿ���е�10%������
temp=[];            % Ԥ����,���ѡȡ������
NumRow=[];          % Ԥ���䣬��Ҫѡȡ�������к�
for i=1:KClass      % ����� 
    rowrank=randperm(NumP);    % ������ɣ�1��2��������n��������������(��һ��������)
    rowrank=rowrank+(i-1)*SmpNumPerClass;
    temp=cat(1,temp,Xnew(rowrank,:));       % ��������
    
    % �洢�Ѿ���ȡ�������к���ɾ���NumRow,�þ���ĳ��ȣ���С����Ϊ�б�ǩ�����ĸ���
    NumRow=cat(2,NumRow,rowrank);
end

% �б�ǩ������ѡȡ��������������ѡȡ10%���������ܸ���
gndSmpNum=length(NumRow);

% temp �б�����ȡ�������б�ǩ������,�����ձ�ǩ��˳��1 2 3�����ֱ�����

%  =======================  ���¹���ԭʼ���� X  =======================  %
% Ϊ�˵õ�������Ҫ�ľ���X������Ҫ��ɾ���Ѿ���ȡ�������У���������Ȼ���ٽ���ȡ�����������ŵ������ǰ�棬����������ǰ���NumSmp�о�����֪��ǩ������
Xnew(NumRow,:)=[];      % ����ȡ�������м��뵽 Xnew �����ԭʼ���� X
X=cat(1,temp,Xnew);     % ���Ӻ�����������temp�ŵ�Xnew���������γ�������Ҫ�ľ���

% ======== ȥ���Ѿ���ȡ�������б�ǩ��������ʣ���Ϊδ֪��ǩ������ ======= %
XSmpgnd=X(:,end);
X(:,end)=[];            % ɾ�����һ�У���ǩ�У�����ʱ��ǩ��������
 
X=X';                   % ȡ����ת�ã�һ��Ϊһ��������һ��Ϊ����������һ������
% ======================== < ԭʼ���� X ��ʼ����� > =================== %

[mFea,nSmp]=size(X);    % mFea������ά�� nSmp��������

%  ====================  ����ָʾ���� C ===================  %
C=zeros(gndSmpNum,KClass);     % ���б�ǩ����������������
for j=1:KClass                 % ���������������
    for i=1:gndSmpNum          % ����������������
        if XSmpgnd(i,1)==j     % ���X����֪��ǩ�����ı�ǩ��������
            C(i,j)=1;
        end
    end
end
% =================  < ����ָʾ���� C ��� > ==============  %

I=eye(nSmp-gndSmpNum);         % ��λ����ά��Ϊ(������-��֪��ǩ��������)

% ================  �����ǩԼ������ A =================== %
A=zeros(nSmp,nSmp-gndSmpNum+KClass);
A(1:gndSmpNum,1:KClass)=C;
A(gndSmpNum+1:end,KClass+1:end)=I;
% ==================  ������� A ��ϣ� ================== %

%  ==========================  Լ �� �� �ϣ�  ==========================  %

% =============================   ϡ��Լ��   ============================ %
sU=0.6; % ����ϡ��ϵ��
sV=[];% ����ϡ��ϵ��
% =============================   ϡ��Լ�����   =======================  %

% =============================  ͼ������  ===========================  %

%-------------------------------------------------------------------------
%                            algo ���� Binary��HeatKernel and Cosine
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


maxIter = 300;          % ����������
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

% ====================  ͼ�������  =============================== %

% ����SDGNMF����
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
%=================== ��ʾ������ =====================%
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
%=================== ��ʾ���������� ========================%
 figure(2)
 load(fname);
 
 plot(obj(3:end));
 title(fname);
 xlabel('Iteration');
 ylabel('Objective function value')
 legend('SDGNMF')
 
 %=================== ��ʾϡ��� ========================%
 
[sp1F,sp12,sp2F,sp22,sp3F,sp32]=sp1(U)

 %=================== ��ʾ������ AC and NMI ========================%

        label = litekmeans(V,KClass,'Replicates',20);
        save('label','label');
        MIhat = MutualInfo(gnd,label);      %  �����ı�ǩ��ԭ��ǩ�Ļ���Ϣ
        HXmi(h)=MIhat;                      % �洢
        disp(['Clustering in the SDGNMF subspace. MIhat: ',num2str(MIhat)]);
    
        disp(['KClass=',num2str(KClass),'  ������ϣ�']); 
        
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

toc  %  ��ʾ����ʱ��
