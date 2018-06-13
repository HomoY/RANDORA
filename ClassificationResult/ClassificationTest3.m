%test the result ClassificationTest3
close all
load gg.mat
gap = 0.5 ;
mind1 = min(DistanceMatrix(:,2));
maxd1 = max(DistanceMatrix(:,2));
index1 = zeros(1,round((maxd1-mind1)/gap));
for i = 1:round((maxd1-mind1)/gap)
    for j = 1: LammpsEffectStructure
        if (DistanceMatrix(j,2) >= (mind1 +gap*(i-1)))&& (DistanceMatrix(j,2) < (mind1+gap*i))
            index1(i) = index1(i)+1;
        end
    end
end
p = index1;
index1 = zeros(1,size(index1,2)+1);
index1(1) = 0;
index1(2:size(index1,2)) = p;
x = 0:19;

values1=spcrv([[x(1) x x(end)];[index1(1) index1 index1(end)]],3);
plot(values1(1,:),values1(2,:))

hold on 
%{
gap = 1;
mind = min(DistanceMatrix(:,2));
maxd = max(DistanceMatrix(:,2));
index = zeros(1,round((maxd-mind)/gap));
%}
mind2 = min(DistanceMatrix2(:,2));
maxd2 = max(DistanceMatrix2(:,2));
index2 = zeros(1,round((maxd2-mind2)/gap));
for i = 1:round((maxd2-mind2)/gap)
    for j = 1: LammpsEffectStructure
        if (DistanceMatrix2(j,2) >= (mind2 +gap*(i-1)))&& (DistanceMatrix2(j,2) < (mind2+gap*i))
            index2(i) = index2(i)+1;
        end
    end
end
p = index2;
index2 = zeros(1,size(index2,2)+1);
index2(1) = 0;
index2(2:size(index2,2)) = p;
x = 0:19;

values2=spcrv([[x(1) x x(end)];[index2(1) index2 index2(end)]],3);
plot(values2(1,:),values2(2,:))
set(gca,'Fontname','SimSun');
set(get(gca, 'XLabel'),'Fontname','SimSun','String', '结构距离(埃)','FontSize',15);
set(get(gca, 'YLabel'),'String', '结构数目','FontSize',15);


figure(2)
plot(DistanceMatrix(:,2),DistanceMatrix2(:,2),'ro')



figure(3)
c1 = round((maxd1-mind1)/gap);
c2 = round((maxd2-mind2)/gap);
index3 = zeros(c1,c2);
for i = 1:round((maxd1-mind1)/gap)
    for j = 1: round((maxd2-mind2)/gap)
        for k =1:LammpsEffectStructure
            if (DistanceMatrix(k,2) >= (mind1 +gap*(i-1)))&& (DistanceMatrix(k,2) < (mind1+gap*i))
                if (DistanceMatrix2(k,2) >= (mind2 +gap*(j-1)))&& (DistanceMatrix2(k,2) < (mind2+gap*j))
                    index3(i,j) = index3(i,j)+1;
                end
            end
        end
    end
end
%sum(sum(index3))
X = mind1:gap:(maxd1-gap);
Y = mind2:gap:(maxd2);

%meshgrid
[X,Y] = meshgrid(Y,X);
size(X)
size(Y)
size(index3)
%color
c = jet(100);




s = surf(X,Y,index3,'FaceAlpha',0.5);
colormap(c)
s.EdgeColor = 'none';
%shading flat
shading interp
grid off
%axis([0 8 0 10])
view(3)
colorbar
%}



count = 0;
for i = 1:LammpsEffectStructure
    if DistanceMatrix(i,2) < 5 && DistanceMatrix(i,2) > 4.7
        count = count+1;
    end
end
count
%}