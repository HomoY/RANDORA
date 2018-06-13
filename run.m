%Start From Here
tic
%Parameter Part:
ParameterInput;
%Parallel Work Part:
AtomNamePositionMatrixSeed = RandSeedGenerate(StructuresNumber,AtomsNumber, AtomsName, CenterPoint, InnerBoxMax, InnerBoxMin, BondMin);

if CoreNumber == 1 % delete latter because it should be included 
    %直接单核运行
    %Path
    CopyfilePoint = [pwd,'/K_H/*.m'];
    copyfile(CopyfilePoint, pwd);
    [LammpsENP, HKResult, SimilarStatistic] = PerCoreWork(AtomNamePositionMatrixSeed, AtomsName, AtomsNumber, StructuresNumber, DistanceCut, BondMin, BondMax); % Lammps generate and clssified
    save('Au.mat')
    delete('Kabsch.m')
    delete('KabschIterateHungarian.m')
    delete('Munkres.m')
    delete('K_H_48.m')

elseif CoreNumber > 1
    %Prepare file
    CopyfilePoint = [pwd,'/K_H/*.m'];
    copyfile(CopyfilePoint, pwd);
    [Path0, Path1, Path2] = CoreSet(CoreNumber);
    %Upload the task and get pid and other information
    parpool('local',CoreNumber);% another Core Used to get the information
    AtomNamePositionMatrixSeedPer = Composite();
    StructuresNumberPer = Composite();
    for i = 1:CoreNumber 
        AtomNamePositionMatrixSeedPer{i} =AtomNamePositionMatrixSeed((i-1)*AtomsNumber*StructuresNumber/CoreNumber+1:i*AtomsNumber*StructuresNumber/CoreNumber,:);

        StructuresNumberPer{i} = StructuresNumber/CoreNumber;
    end
    %CopyfilePoint = [pwd,'/K_H/*.m'];
    %poolobj = gcp; % to share the document
    %addAttachedFiles(poolobj,{'structure_fit.m','PerCoreWork.m','LammpsGenerate.m','Munkres.m','Kabsch.m','KabschIterateHungarian.m','in.Au','Au.eam.fs'});
    myspmd;
    %Collect result, Lammps, HKResult and SimilarStatistic
    
    CounterLammps = zeros(1,CoreNumber);
    CounterHK = zeros(1,CoreNumber);
    CounterSim = zeros(1,CoreNumber);
    for i = 1:CoreNumber
        CounterLammps(i) = size(LammpsENP{i},1);  
        CounterHK(i) = size(HKResult{i},1);
        CounterSim(i) = size(SimilarStatistic{i},1); 
    end

   LammpsENPCollect = zeros(sum(CounterLammps),5);
   HKResultCollect = zeros(sum(CounterHK),5);
   SimilarStatisticCollect = zeros(sum(CounterSim),3);
   n1 = 1;
   n2 = 1;
   n3 = 1;
    for i = 1:CoreNumber
        a = CounterLammps(i);
        b = CounterHK(i);  
        c = CounterSim(i);
        LammpsENPCollect(n1:n1+a-1,:) = LammpsENP{i}; 
        HKResultCollect(n2:n2+b-1,:) = HKResult{i};
        SimilarStatisticCollect(n3:n3+c-1,:) = SimilarStatistic{i}; 
        n1 = n1+a;
        n2 = n2+b;
        n3 = n3+c;
    end
    delete(gcp('nocreate'))
%Collect the result 

%Initilazing
LammpsENPAll = LammpsENPCollect;
HKResultAll = zeros(sum(CounterHK),5);

HKResultAll(1:CounterHK(1),:) = HKResultCollect(1:CounterHK(1),:);
SimilarStatisticAll = SimilarStatisticCollect;
%SimilarStatisticAll(:,2) = 1:sum(CounterSim);
All = CounterHK(1)/AtomsNumber;

%Reset the rank number of the LammpsENPCollect into LammpsENPAll


%Collection
i = 1; % i means current compared class
for i = 2:CoreNumber
    for k = 1:(CounterHK(i)/AtomsNumber) %k means current compared objection
        for j = 1:All %j means number in ALL function
            %[i,j,k]
            %HKResultCollect(((k-1)*AtomsNumber+ sum(CounterHK(1:i-1)))+1:(k*AtomsNumber+ sum(CounterHK(1:i-1))),:)
            Distance = KabschIterateHungarian(AtomsNumber, HKResultAll(j*AtomsNumber+1-AtomsNumber:j*AtomsNumber,2), HKResultCollect(((k-1)*AtomsNumber+ sum(CounterHK(1:i-1)))+1:(k*AtomsNumber+ sum(CounterHK(1:i-1))),2), HKResultAll(j*AtomsNumber+1-AtomsNumber:j*AtomsNumber,3:5), HKResultCollect(((k-1)*AtomsNumber+ sum(CounterHK(1:i-1)))+1:(k*AtomsNumber+ sum(CounterHK(1:i-1))),3:5));
            if Distance <= DistanceCut
                %Reset the Similar statistic
                for p = 1:CounterSim(i)
                    if SimilarStatisticAll(sum(CounterSim(1:i-1))+p,2) == k
                        SimilarStatisticAll(sum(CounterSim(1:i-1))+p,2) = j; 
                    end
                end
                break;
            end
        end
        %Distance
        if Distance >= DistanceCut
            All = All +1;
            HKResultAll((All-1)*AtomsNumber+1:All*AtomsNumber,:) = HKResultCollect(((k-1)*AtomsNumber+ sum(CounterHK(1:i-1)))+1:(k*AtomsNumber+ sum(CounterHK(1:i-1))),:);
        end
    end
end
HKResultAll = HKResultAll(1:AtomsNumber*All,:);
%clear

clear ans
clear HKResult LammpsENP SimilarStatistic StructuresNumberPer route1 route2 AtomNamePositionMatrixSeedPer
delete('Kabsch.m')
delete('KabschIterateHungarian.m')
delete('Munkres.m')
delete('K_H_48.m')
rmdir parallel s
save('Au.mat')
end

    %Vasp run 


toc
