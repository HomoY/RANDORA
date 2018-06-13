%----------------------------
clear
clear all
%一列x一列y一列z，分别为归一化后的地铁站长度，宽度，以及计算得出的人流密度值
%归一化代码我写的是C++的,不做归一化不影响使用
%载入文件，获取x的值
fidx=fopen('C:\Users\Administrator.SC-201604111342\Desktop\x.txt','r');
x=fscanf(fidx,'%lf');
%载入文件获取y的值
fidy=fopen('C:\Users\Administrator.SC-201604111342\Desktop\y.txt','r');
y=fscanf(fidy,'%lf');
%载入文件，获取z的值
fidz=fopen('C:\Users\Administrator.SC-201604111342\Desktop\z.txt','r');
z=fscanf(fidz,'%lf');
%取x的最大值
maxx=max(x);
%取x的最小值
minx=min(x);
%同x
maxy=max(y);
miny=min(y);
%生成网格
[X,Y]=meshgrid(linspace(minx,maxx),linspace(miny,maxy));
%插入人员密度值
Z=griddata(x,y,z,X,Y,'v4');
subplot(1,2,1);
%生成三维面
mesh(X,Y,Z)
hold on
%在三维面上画出人员密度值，高低峰岁值的大小而改变，颜色也是
plot3(x,y,z,'r.')
hold on
%坐标命名
xlabel('X-地铁站长度');
ylabel('Y-地铁站宽度');
zlabel('Z-人员密度值');
%插入颜色条
colorbar
%二维视角
subplot(1,2,2);
%生成三维面
mesh(X,Y,Z)
hold on
%在三维面上画出人员密度值，高低峰岁值的大小而改变，颜色也是
plot3(x,y,z,'r.')
hold on
view(2);
%坐标命名
xlabel('X-地铁站长度');
ylabel('Y-地铁站宽度');
zlabel('Z-人员密度值');
%插入颜色条
colorbar


