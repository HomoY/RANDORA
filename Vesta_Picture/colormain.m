%this is desinged for the example
function colormain
warning('off')
mymap=[0.8275,0.6588,0.0353];
%colormap(mymap);
name1=['pos.xyz'];
name2=['pos1.xyz'];
my_pos(name1,mymap)
%my_c(name1,mymap)

my_pos(name2,[192,192,192]/255)
%my_c(name2,[192,192,192]/255)

myvec(name1,name2)
shading flat
grid off
axis equal
%axis off
mylight
view(3)
end

function my_pos(name,mymap)
%mymap=[0.8275,0.6588,0.0353];
colormap(mymap);
a=importdata(name,' ',2);
a=a.data;
r=0.5;% atoms sizes

[x,y,z]=sphere(100);
for i=1:max(size(a)) 
surf(a(i,1)+r*x,a(i,2)+r*y,a(i,3)+r*z);
hold on
end
freezeColors;
end

function my_c(name,mymap)
colormap(mymap);
distance=9.0;
a=importdata(name,' ',2);
a=a.data;
R=0.1;
for i=1:max(size(a))-1
    for j=i+1:max(size(a))
            if (((a(i,1)-a(j,1))^2+(a(i,2)-a(j,2))^2+(a(i,3)-a(j,3))^2)<distance)
                [X, Y, Z] = cylinder2P(R,100,a(i,:),a(j,:));
                surf(X,Y,Z)
                hold on
            end
    end
end
freezeColors;
end
%the lighting fun
function mylight
%%%%%%%%%%%%%%%%%%%%light
h1=camlight('right');%light('Position',[-1 0 0],'Style','infinite','Visible','on');
h2=camlight('right');%light('Position',[-1 0 0],'Style','infinite');
h3=camlight('right');%light('Position',[-1 0 0],'Style','infinite');
%h4=camlight('right');%light('Position',[-1 0 0],'Style','infinite');

lighting flat
material metal
    h = rotate3d;                 % Create rotate3d-handle
    h.ActionPostCallback = @RotationCallback; % assign callback-function
    h.Enable = 'on';              % no need to click the UI-button

    % Sub function for callback
    function RotationCallback(~,~)
        h1 = camlight(h1,'right');
        h2 = camlight(h2,'right');
        h3 = camlight(h3,'right');
       % h4 = camlight(h4,'right');
    end
end
function myvec(name1,name2)
mymap=[0,0,1];
colormap(mymap);
a1=importdata(name1,' ',2);
a1=a1.data;
a2=importdata(name2,' ',2);
a2=a2.data;

for i=1:max(size(a1))
len=sqrt((a2(i,1)-a1(i,1))^2+(a2(i,2)-a1(i,2))^2+(a2(i,3)-a1(i,3))^2);
a0=a1(i,1);b0=a1(i,2);c0=a1(i,3);k0=(a2(i,1)-a1(i,1));k1=(a2(i,2)-a1(i,2));k2=(a2(i,3)-a1(i,3));
h=arrow3D([a0,b0,c0],[k0,k1,k2]*0.8,'b',1/len);
%set(h,'maxheadsize',2.5/len);
%set(h,'LineWidth',2);
%set(h,'color',[0 0 0]/255)
hold on
end
freezeColors;
end