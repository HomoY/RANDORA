% use for test execute the program
% ParameterInput;
% t1 = clock;
% AtomNamePositionMatrixSeed = RandSeedGenerate(StructuresNumber,AtomsNumber, AtomsName, CenterPoint, InnerBoxMax, InnerBoxMin);
% t2 = clock;
% TimeCost = etime(t2,t1);
% disp(['Seed Generate time:', num2str(TimeCost)])
% CopyfilePoint = [pwd,'/K_H/*.m'];
% copyfile(CopyfilePoint, pwd);
% [LammpsENP, HKResult, SimilarStatistic] = PerCoreWork(AtomNamePositionMatrixSeed, AtomsName, AtomsNumber, StructuresNumber, DistanceCut, BondMax);
 
%Desgin for the Parallel test
% parpool('local',2);
% %c = Composite();
% 
% n = 3;
% c = 1;
% delete(gcp('nocreate'))
% 

% Vasp Collection test 
%{
fileId = fopen([pwd,'\1'],'r'); % This opens a file
LineBegin = 9;
LineEnd = LineBegin+AtomsNumber;
line_num = 0; 
for i = 1:LineEnd
    line_num = line_num+1;
    lineData=fgetl(fileId); % read a line     
    if i >= LineBegin
    disp(['Line ',num2str(line_num) , ': ' lineData ]);
    end
end
%}
% test CdSe lammps
p = rand(20,3)*2;
name = zeros(20,1);
for i = 1:20
    if mod(i,2) == 0
        name(i) = 1;
    else
        name(i) = 2;
    end
end
k = [1:20]';
result = [k,name,p];