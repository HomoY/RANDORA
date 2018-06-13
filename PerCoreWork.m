%This function design the work of per core in the parallel mode
function [LammpsENP, HKResult, SimilarStatistic] = PerCoreWork(AtomNamePositionMatrix, AtomName, AtomNumber, InputStructuresNumber, DistanceCut, BondMin, BondMax)
%   function [LammpsENP] = PerCoreWork(AtomNamePositionMatrix, AtomName, AtomNumber, InputStructuresNumber, DistanceCut, BondMax)
    LammpsENP= zeros(InputStructuresNumber*AtomNumber,5); %Lammps Energy Name Position Matrix, Although I make so many, but I will not use them all because of selection program 
    LammpsEffectStructure = 0;
    %Lammps Running
    t1 = clock;
    for i = 1 : InputStructuresNumber
        PerAtomNamePositionMatrix = AtomNamePositionMatrix(1+(i-1)*AtomNumber:AtomNumber*i,:);
        %PerAtomNamePositionMatrix(:,2:5)
        PerAtomNamePositionMatrixLammps = LammpsGenerate(AtomNumber, AtomName, PerAtomNamePositionMatrix);% this read the file of lammps
        %PerAtomNamePositionMatrixLammps(:,2:5)
        last = structure_fit(PerAtomNamePositionMatrixLammps(1:AtomNumber,3:5), AtomNumber, BondMin, BondMax); %This result shows we may don't get the perfect result 
        if min(last(1,:)) <= 1
            continue;
        end
        LammpsENP(1+LammpsEffectStructure*AtomNumber:AtomNumber*(LammpsEffectStructure+1),:) = PerAtomNamePositionMatrixLammps;
        LammpsEffectStructure = LammpsEffectStructure+1;
    end
    %size(LammpsENP);
    %LammpsENP;

    t2 = clock;
    TimeCost = etime(t2,t1);
    disp(['Lammps generate time:', num2str(TimeCost)])

    %Compare With K_H without the energy cut, I will change this in the future code
    %Distance = 0;
    t1 = clock;
    NewTypeNo = 1;
    SimilarTypeNo = 1;
    HKResult = zeros(LammpsEffectStructure*AtomNumber,5);
    HKResult(1:AtomNumber,:) = LammpsENP(1:AtomNumber,:); %Initialization
    SimilarStatistic = zeros(LammpsEffectStructure,3); %Number, Classification, Distance

    %SimilarStatistic(SimilarTypeNo,:) = [1, 1, 0, 1];
    %SimilarTypeNo = SimilarTypeNo +1;
    for i = 2 : LammpsEffectStructure
        Distance = 0;
        for j = 1 : NewTypeNo     
            %[i, j]  
            % p1=LammpsENP(i*AtomNumber+1-AtomNumber:i*AtomNumber,3:5) 
            % p2=HKResult(j*AtomNumber+1-AtomNumber:j*AtomNumber,3:5)
            Distance = K_H_48(AtomNumber, LammpsENP(i*AtomNumber+1-AtomNumber:i*AtomNumber,2), HKResult(j*AtomNumber+1-AtomNumber:j*AtomNumber,2), LammpsENP(i*AtomNumber+1-AtomNumber:i*AtomNumber,3:5), HKResult(j*AtomNumber+1-AtomNumber:j*AtomNumber,3:5));
            %Distance
            if Distance <= DistanceCut
                SimilarStatistic(SimilarTypeNo,:) =[i, j, Distance]; %i means total number, j means the similiar structure,distance means distance 
                SimilarTypeNo = SimilarTypeNo+1;
                break;
            end
            
        end
        %Distance
        if (Distance > DistanceCut) 
            NewTypeNo = NewTypeNo+1;
            HKResult(1+(NewTypeNo-1)*AtomNumber:AtomNumber*NewTypeNo,:) = LammpsENP(1+(i-1)*AtomNumber:AtomNumber*i,:);
        end
    end
    t2 = clock;
    TimeCost = etime(t2,t1);
    disp(['Compare Time:', num2str(TimeCost)])
    %Result Output
    LammpsENP        = LammpsENP(1:LammpsEffectStructure*AtomNumber,:);
    HKResult         = HKResult(1:NewTypeNo*AtomNumber,:);
    SimilarStatistic = SimilarStatistic(1:(SimilarTypeNo-1),:);
 end


