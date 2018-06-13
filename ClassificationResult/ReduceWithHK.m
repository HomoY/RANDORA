%This file is used to reduce the HKResultAll's number, because this number is so large so we need to reduce the number
load Au.mat
%Reset the DistanceCut 
CopyfilePoint = [pwd,'/K_H/*.m'];
copyfile(CopyfilePoint, pwd);
DistanceCut = 1;
eps = 0.0001;
%Initilazing
LammpsENPAll = LammpsENPCollect;
HKResultAll = zeros(sum(CounterHK),5);

HKResultAll(1:CounterHK(1),:) = HKResultCollect(1:CounterHK(1),:);
SimilarStatisticAll = SimilarStatisticCollect;
%SimilarStatisticAll(:,2) = 1:sum(CounterSim);
All = 1;

%Reset the rank number of the LammpsENPCollect into LammpsENPAll


%Collection
i = 1; % i means current compared class
for i = 1:CoreNumber
    for k = 1:(CounterHK(i)/AtomsNumber) %k means current compared objection
        Distance = 0;
        for j = 1:All %j means number in ALL function
            %[i,j,k]
            %HKResultAll((j-1)*AtomsNumber+1,1)
            %HKResultAll((k-1)*AtomsNumber+1,1)
             %HKResultCollect(((k-1)*AtomsNumber+ sum(CounterHK(1:i-1)))
            %abs(HKResultAll((j-1)*AtomsNumber+1,1)-HKResultAll((k-1)*AtomsNumber+1,1))
            %HKResultCollect(((k-1)*AtomsNumber+ sum(CounterHK(1:i-1)))+1:(k*AtomsNumber+ sum(CounterHK(1:i-1))),:)
            %HKResultCollect(((k-1)*AtomsNumber+ sum(CounterHK(1:i-1)))+1,1)
            %HKResultAll((j-1)*AtomsNumber+1,1)
            if abs(HKResultCollect(((k-1)*AtomsNumber+ sum(CounterHK(1:i-1)))+1,1)-HKResultAll((j-1)*AtomsNumber+1,1)) <= eps
                
                for p = 1:CounterSim(i)
                    if SimilarStatisticAll(sum(CounterSim(1:i-1))+p,2) == k
                        SimilarStatisticAll(sum(CounterSim(1:i-1))+p,2) = j; 
                    end
                end
                break;
            end

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
        if Distance > DistanceCut && abs(HKResultCollect(((k-1)*AtomsNumber+ sum(CounterHK(1:i-1)))+1,1)-HKResultAll((j-1)*AtomsNumber+1,1)) > eps
            All = All +1;
            HKResultAll((All-1)*AtomsNumber+1:All*AtomsNumber,:) = HKResultCollect(((k-1)*AtomsNumber+ sum(CounterHK(1:i-1)))+1:(k*AtomsNumber+ sum(CounterHK(1:i-1))),:);
            %All
                for p = 1:CounterSim(i)
                    
                    if SimilarStatisticAll(sum(CounterSim(1:i-1))+p,2) == k
                         [All k SimilarStatisticAll(sum(CounterSim(1:i-1))+p,2),sum(CounterSim(1:i-1))+p]
                        SimilarStatisticAll(sum(CounterSim(1:i-1))+p,2) = All;
                    end
                end
        end
    end
end
HKResultAll = HKResultAll(1:AtomsNumber*All,:);


save(['Au',num2str(AtomsNumber),'.mat'])
delete('Kabsch.m')
delete('KabschIterateHungarian.m')
delete('Munkres.m')
delete('K_H_48.m')
