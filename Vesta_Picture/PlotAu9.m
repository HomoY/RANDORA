%This file is used to generate the Au9 plot in application 
close all


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
bar(SimilarFlag,0.2,'FaceColor',[0.1255    0.3137    0.4078], 'EdgeColor', [0.1255    0.3137    0.4078])
hold on 

ha_1 = gca; %%获取当前的坐标轴
pos = get(ha_1,'Position'); %%获取ha_1的位置，以保持两个坐标轴重叠
ha_2 = axes('Position',pos);



plot(ha_2,Energy,'b--',...
'LineWidth',2)
hold on 
plot(ha_2,Energy,'ro',...
'MarkerSize',8,'LineWidth',2)
%axis([1 9 -17.5 -16.6])
%text(1.3,-16.7,'9-I')
%set(get(gca, 'Title'), 'String', '组');
%set(gca,'FontWeight','bold')
set(gca,'Fontname','SimSun');
set(get(ha_2, 'XLabel'),'Fontname','SimSun','String', '特征构型','FontSize',15);
set(get(ha_2, 'YLabel'),'String', '能量(eV)','FontSize',15);
set(get(ha_1, 'YLabel'),'String', '相似构型','FontSize',15);




box(ha_1,'off')
box(ha_2,'off')

set(ha_2,'YAxisLocation','right',... %%Y轴调至右
'Color','none') %%坐标轴背景色为透明，以免覆盖底层图像) 
cc =[0.5 NewType+0.5];

%axis
set(ha_1,'XLim',cc,'XTick', 1 : NewType);
set(ha_1,'xaxislocation','top')
xticklabels(ha_1,[])
set(ha_2,'XLim',cc,'XTick', 1 : NewType);

set(ha_1,'YLim',[0 16000],'YTick',0:2000:18000);
set(ha_2,'YLim',[-22.8 -21],'YTick',-23:0.5:-21);

%Au9
%plot(1,Energy(1),'o', 'MarkerFaceColor',[1,0,0])
%plot(17,Energy(17),'o', 'MarkerFaceColor',[1,0,0])