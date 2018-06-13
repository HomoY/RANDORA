%Start From Here
tic
%Parameter Part:
ParameterInput;
%Parallel Work Part:
AtomNamePositionMatrixSeed = RandSeedGenerate(StructuresNumber,AtomsNumber, AtomsName, CenterPoint, InnerBoxMax, InnerBoxMin, BondMin);
CopyfilePoint = [pwd,'/../K_H/*.m'];
copyfile(CopyfilePoint, pwd);

%Lammps
LammpsENP= zeros(StructuresNumber*AtomsNumber,5); %Lammps Energy Name Position Matrix, Although I make so many, but I will not use them all because of selection program 
LammpsEffectStructure = 0;
%Lammps Running

for i = 1 : StructuresNumber
    PerAtomNamePositionMatrix = AtomNamePositionMatrixSeed(1+(i-1)*AtomsNumber:AtomsNumber*i,:);
    PerAtomNamePositionMatrixLammps = LammpsGenerate(AtomsNumber, AtomsName, PerAtomNamePositionMatrix);% this read the file of lammps
    last = structure_fit(PerAtomNamePositionMatrixLammps(1:AtomsNumber,3:5), AtomsNumber, BondMin, BondMax); %This result shows we may don't get the perfect result 
    if min(last(1,:)) <= 1
        continue;
    end
    LammpsENP(1+LammpsEffectStructure*AtomsNumber:AtomsNumber*(LammpsEffectStructure+1),:) = PerAtomNamePositionMatrixLammps;
    LammpsEffectStructure = LammpsEffectStructure+1;
end
save('Au9Test.mat')
%{
NewTypeNo = 1;
SimilarTypeNo = 1;
%CompareEnergy = zeros
%for i = 1:LammpsEffectStructure
%    CompareEnergy = LammpsENP((i-1)*AtomsNumber,1)
%end
CompareName = LammpsENP(:,2);
CompareXYZ = LammpsENP(:,3:5);
DistanceMatrix = zeros(LammpsEffectStructure,2);
%intialzation 
E = LammpsENP(1,1);
N = LammpsENP(1:AtomsNumber,2);
X = LammpsENP(1:AtomsNumber,3:5);
DistanceMatrix(:,1) = [1:LammpsEffectStructure]';
%Compare
for i = 2:LammpsEffectStructure
    
    Distance = K_H_48(AtomsNumber,N,CompareName((i-1)*AtomsNumber+1:i*AtomsNumber),X,CompareXYZ((i-1)*AtomsNumber+1:i*AtomsNumber,:));
    DistanceMatrix(i,2) = Distance;

end

%}