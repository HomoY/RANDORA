%Control Program
%VestaLammpsXYZ; %Generate the Lammps.xyz for Vesta readr Vesta read

%Au.mat process
close all

%p = [pwd,'/../Au20.mat'];
% p = ['Au7mat.mat'];
%p = [pwd,'\..\Vasp\Au10V.mat'];
%load(p)

p2 = [pwd,'/../Vasp/Au20V.mat'];
load(p2)

%figure(1)
NewType = size(HKResultAll,1)/AtomsNumber;

for i = 1:NewType-1
    for j = i:NewType
    if HKResultAll((i-1)*AtomsNumber+1,1) < HKResultAll((j-1)*AtomsNumber+1,1)
        c1 = HKResultAll((i-1)*AtomsNumber+1:i*AtomsNumber,:);
        HKResultAll((i-1)*AtomsNumber+1:i*AtomsNumber,:) = HKResultAll((j-1)*AtomsNumber+1:j*AtomsNumber,:);
        HKResultAll((j-1)*AtomsNumber+1:j*AtomsNumber,:) = c1;
        %c2 = SimilarFlag(i);
        %SimilarFlag(i) =SimilarFlag(j);
        %SimilarFlag(j) = c2;
    end
    end
end
figure(2)
AuMatProcess(40,HKResultAll,AtomsNumber,3,2);%No1 must less than No2
%{
figure(1)
Energy = zeros(1,NewType);
for i = 1:NewType
    Energy(i) = HKResultAll((i-1)*AtomsNumber+1,1);
end

c = 0;
for i = 1:(NewType-1)
    for j = i+1:NewType-2
        if Energy(i) <= Energy(j)
            c = Energy(j);
            Energy(j) = Energy(i);
            Energy(i) = c;
        end
    end
end

c1 = [    0.8706    0.3961    0.2980];
c2 = [0.5843    0.8039    0.9647];
c3 = [ 0.5255    0.7647    0.4784];
c4 = [    0.4941    0.4549    0.9686];
i = 0.5; j = 1.5; k = 1;
patch([i j j i],[-52 -52 Energy(k) Energy(k)],c1,'EdgeColor',c1);
hold on
i = i+1; j = j+1;k = k+1;
patch([i j j i],[-52 -52 Energy(k) Energy(k)],c1,'EdgeColor',c1);
i = i+1; j = j+1;k = k+1;
patch([i j j i],[-52 -52 Energy(k) Energy(k)],c1,'EdgeColor',c1);



plot(Energy,'b--',...
'LineWidth',1)
hold on 
plot(Energy,'ro',...
'MarkerSize',6,'LineWidth',1)
%axis([1 9 -17.5 -16.6])
%text(1.3,-16.7,'9-I')
%set(get(gca, 'Title'), 'String', '组');
%set(gca,'FontWeight','bold')
set(gca,'Fontname','SimSun');
set(get(gca, 'XLabel'),'Fontname','SimSun','String', '特征构型','FontSize',15);
set(get(gca, 'YLabel'),'String', '能量(eV)','FontSize',15);

%PlotAu9;
%HKResultAll
%}

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
%AuMatProcess(1,HKResultAll,AtomsNumber,3,2);%No1 must less than No2
%figure(2)
%figure(2)
%AuMatProcess(80,HKResultAll,AtomsNumber,3,2);%No1 must less than No2

%xlabel(['Total Energy =',HKResultAll(1)])
%{
figure(1)
k = 1;
for i = 1:30
    subplot(5,6,k);
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