%Control Program
%VestaLammpsXYZ; %Generate the Lammps.xyz for Vesta readr Vesta read

%Au.mat process
close all

p = [pwd,'/../Au9.mat'];
% p = ['Au7mat.mat'];
%p = [pwd,'\..\Vasp\Au10V.mat'];
load(p)

%p2 = [pwd,'/../Vasp/Au20V.mat'];
%load(p2)
%{
%figure(1)
NewType = size(HKResultAll,1)/AtomsNumber;

for i = 1:NewType-1
    for j = i:NewType
    if HKResultAll((i-1)*AtomsNumber+1,1) < HKResultAll((j-1)*AtomsNumber+1,1)
        c1 = HKResultAll((i-1)*AtomsNumber+1:i*AtomsNumber,:);
        HKResultAll((i-1)*AtomsNumber+1:i*AtomsNumber,:) = HKResultAll((j-1)*AtomsNumber+1:j*AtomsNumber,:);
        HKResultAll((j-1)*AtomsNumber+1:j*AtomsNumber,:) = c1;
        c2 = SimilarFlag(i);
        SimilarFlag(i) =SimilarFlag(j);
        SimilarFlag(j) = c2;
    end
    end
end

%PlotAu9;
%HKResultAll


%}


%{
%plot the classification map 

x = 1:size(HKResultAll,1)/AtomsNumber; % HK number

c1 = zeros(1,size(HKResultAll,1)/AtomsNumber);
c2 = zeros(1,size(HKResultAll,1)/AtomsNumber);
for i =1:(size(HKResultAll,1)/AtomsNumber-1)
    for j = i:size(HKResultAll,1)/AtomsNumber
        if HKResultAll(1,:)
            
        end
    end
end
c1
c2
for i = 1:size(HKResultAll,1)/AtomsNumber-1
    for j = i:size(HKResultAll,1)/AtomsNumber
        if c1(i)>=c1(j) 
            p = c1(i);
            c1(i) =c1(j);
            c1(j) = p;
            h = HKResultAll((i-1)*AtomsNumber+1:i*AtomsNumber,:);
            HKResultAll((i-1)*AtomsNumber+1:i*AtomsNumber,:) = HKResultAll((j-1)*AtomsNumber+1:j*AtomsNumber,:);
            HKResultAll((j-1)*AtomsNumber+1:j*AtomsNumber,:) = h;
        end
    end
end
%c = barh(x,c1,'FaceColor',[0.2863    0.6667    0.8353], 'EdgeColor', [0.2863    0.6667    0.8353]);
c = barh(x,c1,'FaceColor',[0.1255    0.3137    0.4078], 'EdgeColor', [0.1255    0.3137    0.4078]);


%grid on
ax = gca;
ax.XGrid = 'on';
%ax.GridColor = 'w';
ax.Color = 'none';
ax.Box = 'off';
ax.XColorMode  = 'auto';

ax.XAxisLocation = 'top';
save(['Au',num2str(AtomsNumber),'mat']);
%}
%figure(1)
%AuMatProcess(29,HKResultAll,AtomsNumber,3,2);%No1 must less than No2
%figure(2)
%AuMatProcess(8,HKResultAll,AtomsNumber,3,2);%No1 must less than No2

%xlabel(['Total Energy =',HKResultAll(1)])

figure(1)
k = 1;
for i = 1:17
    subplot(3,6,k);
    AuMatProcess(i,HKResultAll,AtomsNumber,2,1);
    k = k+1;
    
end
%}
%{
p2 = [pwd,'/../Vasp/Au10V.mat'];
load(p2)
figure(2)
k = 1;
for i = 1:29
    subplot(5,6,k);
    AuMatProcess(i,HKResultAll,AtomsNumber,2,1);
    k = k+1;
    
end
%set(gcf,'color','none'); %ͼ�α�����Ϊ��ɫ
%set(gca,'color','none'); %�����ᱳ����Ϊ��ɫ����������Ҫ��ͨ��ͼ�α����İ�ɫʵ��Ϊ�����ᱳ��ɫ
%}
%{
p = [pwd,'\..\Vasp\Au10V.mat'];
load(p)
figure(2)

AuMatProcess(22,HKResultAll,AtomsNumber,3,2);%No1 must less than No2
%}

%{

%       xlabel(['Total Energy =',HKResultAll(1)])
j = 1;
for i = 1:8
    
    subplot(2,4,j);
    AuMatProcess(i,HKResultAll,AtomsNumber,4,3);
    j = j+1;
end
%}

%



%{
%plot the CdSe.mat
p = [pwd,'\..\K_HTestInRandom\CdSe.mat'];
load(p);

for i = 1:6 %which result
    
    figure(i)
    %xlabel('x')
    %ylabel('y')
    %zlabel('x')
    %set(gca,'xtick',[],'xticklabel',[])
    %set(gca,'ytick',[],'yticklabel',[])
    %set(gca,'ztick',[],'zticklabel',[])
    %title(['Distance =',sprintf('%5.2f',d(i)),'ANG']);
    
    %axis off

    axis equal
    box off
    hold on
    view(3)
    c1 = Pplot{i};
    c2 = Qplot{i};
    name1 = c1(:,1);
    name2 = c2(:,1);
    position1 = c1(:,2:4);
    position2 = c2(:,2:4);
    

    for j = 1:number
        plot3([position1(j,1),position2(j,1)],[position1(j,2),position2(j,2)],[position1(j,3),position2(j,3)], '--k')
        if name1(j) == 1
            plot3(position1(j,1),position1(j,2),position1(j,3),'b*')
        end
        
        if name1(j) == 2
            plot3(position1(j,1),position1(j,2),position1(j,3),'b+')
        end
        
        if name2(j) == 1
            plot3(position2(j,1),position2(j,2),position2(j,3),'r*')
        end

        if name2(j) == 2
            plot3(position2(j,1),position2(j,2),position2(j,3),'r+')
        end
    end
end
%}