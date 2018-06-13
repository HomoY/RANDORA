%This file is used to reduce the HKResultAll's number, because this number is so large so we need to reduce the number
load Au.mat
%Reset the DistanceCut 
CopyfilePoint = [pwd,'/K_H/*.m'];
copyfile(CopyfilePoint, pwd);
DistanceCut = 2;
eps = 0.01;
%Initilazing
LammpsENPAll = LammpsENPCollect;
HKResultAll = zeros(sum(CounterHK),5);

HKResultAll(1:CounterHK(1),:) = HKResultCollect(1:CounterHK(1),:);
SimilarStatisticAll = SimilarStatisticCollect;

All = 1;

%Reset the rank number of the LammpsENPCollect into LammpsENPAll
SimilarFlag = zeros(1,1);
%for i = 1:CounterSim(1)
%    if SimilarStatisticCollect(i,2) == 1
%        SimilarFlag(1) = SimilarFlag(1)+1;
%    end
%end

%Collection
i = 1; % i means current compared class
for i = 1:CoreNumber
    for k = 1:(CounterHK(i)/AtomsNumber) %k means current compared objection
        
        %Distance = 0;
        for j = 1:All %j means number in ALL function
            %[j,k]
            %SimilarFlag
            Distance = K_H_48(AtomsNumber, HKResultAll(j*AtomsNumber+1-AtomsNumber:j*AtomsNumber,2), HKResultCollect( (k-1)*AtomsNumber+ sum(CounterHK(1:i-1)) +1:(k*AtomsNumber+ sum(CounterHK(1:i-1)) ),2), HKResultAll((j*AtomsNumber+1-AtomsNumber):j*AtomsNumber,3:5), HKResultCollect(((k-1)*AtomsNumber+ sum(CounterHK(1:i-1)) )+1:(k*AtomsNumber+ sum(CounterHK(1:i-1)) ),3:5));
            %Distance
            %abs(HKResultCollect( (k-1)*AtomsNumber+ sum(CounterHK(1:i-1)) +1, 1)-HKResultAll((j-1)*AtomsNumber+1,1))
            if Distance <= DistanceCut || abs(HKResultCollect( (k-1)*AtomsNumber+ sum(CounterHK(1:i-1)) +1, 1)-HKResultAll((j-1)*AtomsNumber+1,1)) <= eps
                for p = 1:CounterSim(i) 
                    if SimilarStatisticCollect(sum(CounterSim(1:i-1))+p,2) == k
                        SimilarFlag(j) = SimilarFlag(j)+1;
                    end
                end
                break;
            end
        end
        %Distance
        if Distance > DistanceCut && abs(HKResultCollect( (k-1)*AtomsNumber+ sum(CounterHK(1:i-1))  +1, 1)-HKResultAll((j-1)*AtomsNumber+1,1)) > eps
            All = All +1;
            HKResultAll((All-1)*AtomsNumber+1:All*AtomsNumber,:) = HKResultCollect(((k-1)*AtomsNumber+ sum(CounterHK(1:i-1)) )+1:(k*AtomsNumber+ sum(CounterHK(1:i-1)) ),:);
            %All
            sc = SimilarFlag;
            SimilarFlag = zeros(1,All);
            SimilarFlag(:,1:(All-1)) = sc;

                for p = 1:CounterSim(i)  
                    if SimilarStatisticCollect(sum(CounterSim(1:i-1))+p,2) == k
                        SimilarFlag(All) = SimilarFlag(All)+1; 
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
