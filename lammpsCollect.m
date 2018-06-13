%Collect the Cores Generate file and Compare to get the summmary
function [LammpsENPAll, HKResultAll, SimilarStatisticAll] = CoreCollection(AtomsNumber, CoreNumber, CounterLammps, CounterHK, CounterSim, LammpsENPCollect, HKResultCollect, SimilarStatisticCollect)

    LammpsENPAll = zeros(sum(CounterLammps),5);
    HKResultAll = zeros(sum(CounterHK),5);
    SimilarStatisticAll = zeros(sum(CounterSim),1);
    %Initilazing
    All = CounterHK(1);
    HKResultAll(1:AtomsNumber*CounterHK,:) = HKResultCollect(1:AtomsNumber*CounterHK,:);
    %Reset the rank number of the LammpsENPCollect into LammpsENPAll
    LammpsENPAll = LammpsENPCollect;
    
    %Collection
    for i = 2:CoreNumber
    for j = 1:All
    for k = 1:CounterHK(i)
        Distance = KabschIterateHungarian(AtomsNumber, HKResultAll(j*AtomsNumber+1-AtomsNumber:j*AtomsNumber,2), HKResultCollect(k*AtomsNumber+1-AtomsNumber:k*AtomsNumber,2), HKResultAll(j*AtomsNumber+1-AtomsNumber:j*AtomsNumber,3:5), HKResultCollect(k*AtomsNumber+1-AtomsNumber:k*AtomsNumber,3:5));
    if Distance <= DistanceCut
        CounterSim(sum())
    end

    end
    end
    end
    
    end
    