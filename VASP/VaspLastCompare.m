%Reset the DistanceCut 

p = [pwd,'/../Au9.mat'];
load(p)
p2 = [pwd,'/VaspInCaF/'];
p3 = [pwd,'/CollectAu/',num2str(AtomsNumber),'/'];
DistanceCut = 1.0;
VaspBox = 20;

OldType = (size(ls(p3),1)-2)/2;
%Modify the HKResultAll
HKResultAll = zeros(AtomsNumber*OldType,5);
for i = 1: OldType
    c0 = [p3,num2str(i)];
    fid1 = fopen(c0);
    c = [p3,'E',num2str(i)];
    fid2 = fopen(c);

    
    %Read HKResultAll x, y, z 
    LineBegin = 9;
    LineEnd = LineBegin+AtomsNumber; 
    XYZ = zeros(AtomsNumber, 3);
    for j = 1:LineEnd
        lineData=fgetl(fid1); % read a line     
        if j >= LineBegin
            if j < LineEnd
                XYZ(j-8, :) = str2num(lineData);
            else
                break;
            end 
        end
    end
    %size(XYZ)
    %Read HKResultAll Energy
    LineEngBegin = 1;
    
    while ~feof(fid2)
        LineEngBegin = LineEngBegin+1;
        Energy = fgetl(fid2);
        
    end 
    Energy = str2num(Energy(30:44));
    %disp(Energy);
    fclose(fid1);
    fclose(fid2);
    HKResultAll(AtomsNumber*(i-1)+1,1) = Energy;
    HKResultAll(AtomsNumber*(i-1)+1:AtomsNumber*i,2) = ones(AtomsNumber,1);
    HKResultAll(AtomsNumber*(i-1)+1:AtomsNumber*i,3:5) = XYZ*VaspBox;


end
%HKResultAll
%size(HKResultAll)

%Continue the ReduceWithHK.m files 

NewType = 1;
eps = 0.01;
%prepare file
CopyfilePoint = [pwd,'/../K_H/*.m'];
copyfile(CopyfilePoint, pwd);

%another option for Vasp

t1 = clock;
for i = 2:OldType
    Distance = 0;
    for j = 1 : NewType     
        %First delete structures with same energy 
        %[i,j]
        %abs(HKResultAll((i-1)*AtomsNumber+1,1)-HKResultAll((j-1)*AtomsNumber+1,1))
        if abs(HKResultAll((i-1)*AtomsNumber+1,1)-HKResultAll((j-1)*AtomsNumber+1,1)) <= eps
            for p = 1:sum(CounterSim)
                if SimilarStatisticAll(p,2) == i
                    SimilarStatisticAll(p,2) = j;
                end
            end
            break;
        end
        
        %HKResultAll((i-1)*AtomsNumber+1:i*AtomsNumber,:)
        %HKResultAll((j-1)*AtomsNumber+1:j*AtomsNumber,:)
        Distance = K_H_48(AtomsNumber, HKResultAll((j-1)*AtomsNumber+1:j*AtomsNumber,2),HKResultAll((i-1)*AtomsNumber+1:i*AtomsNumber,2),HKResultAll((j-1)*AtomsNumber+1:j*AtomsNumber,3:5), HKResultAll((i-1)*AtomsNumber+1:i*AtomsNumber,3:5));
        if Distance < DistanceCut
            for p = 1:sum(CounterSim)
                if SimilarStatisticAll(p,2) == i
                    SimilarStatisticAll(p,2) = j;
                end
            end
            break;  
        end
    end

    %Distance
    if (Distance > DistanceCut) && abs(HKResultAll((i-1)*AtomsNumber+1,1)-HKResultAll((j-1)*AtomsNumber+1,1)) > eps
        NewType = NewType +1;
        HKResultAll((NewType-1)*AtomsNumber+1:NewType*AtomsNumber,:) = HKResultAll((i-1)*AtomsNumber+1:i*AtomsNumber,:);
    end
end
t2 = clock;
TimeCost = etime(t2,t1);
disp(['Vasp Last Compare Time:', num2str(TimeCost)])

HKResultAll = HKResultAll(1:AtomsNumber*NewType,:);
save(['Au',num2str(AtomsNumber),'V.mat'])
delete('Kabsch.m')
delete('KabschIterateHungarian.m')
delete('Munkres.m')
delete('K_H_48.m')