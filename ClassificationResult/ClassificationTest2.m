% ClassificationTest2
load Au9.mat
CopyfilePoint = [pwd,'/../K_H/*.m'];
copyfile(CopyfilePoint, pwd);
LammpsEffectStructure =1000;
%Transfer Data
NewTypeNo = 1;
SimilarTypeNo = 1;
CompareName = LammpsENPCollect(:,2);
CompareXYZ = LammpsENPCollect(:,3:5);
DistanceMatrix = zeros(LammpsEffectStructure,2);
DistanceMatrix2 = zeros(LammpsEffectStructure,2);
%intialzation 
i = 2;
E = HKResultAll((i-1)*AtomsNumber+1,1);
N = HKResultAll((i-1)*AtomsNumber+1:i*AtomsNumber,2);
X = HKResultAll((i-1)*AtomsNumber+1:i*AtomsNumber,3:5);
DistanceMatrix(:,1) = [1:LammpsEffectStructure]';

j = 3;
E1 = HKResultAll((j-1)*AtomsNumber+1,1);
N1 = HKResultAll((j-1)*AtomsNumber+1:j*AtomsNumber,2);
X1 = HKResultAll((j-1)*AtomsNumber+1:j*AtomsNumber,3:5);
DistanceMatrix2(:,1) = [1:LammpsEffectStructure]';
%Compare
for i = 1:LammpsEffectStructure
    Distance = K_H_48(AtomsNumber,N,CompareName((i-1)*AtomsNumber+1:i*AtomsNumber),X,CompareXYZ((i-1)*AtomsNumber+1:i*AtomsNumber,:));
    DistanceMatrix(i,2) = Distance;
end

for i = 1:LammpsEffectStructure
    Distance = K_H_48(AtomsNumber,N1,CompareName((i-1)*AtomsNumber+1:i*AtomsNumber),X1,CompareXYZ((i-1)*AtomsNumber+1:i*AtomsNumber,:));
    DistanceMatrix2(i,2) = Distance;
end

save('gg.mat')
%K_H_48(AtomsNumber,CompareName((j-1)*AtomsNumber+1:j*AtomsNumber),CompareName((i-1)*AtomsNumber+1:i*AtomsNumber),CompareXYZ((j-1)*AtomsNumber+1:j*AtomsNumber,:),CompareXYZ((i-1)*AtomsNumber+1:i*AtomsNumber,:))