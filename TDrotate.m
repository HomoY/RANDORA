%roate program
function P_change=TDrotate(p,q,theta,P0)
%syms p q theta
%p=input('��x����ת�ĽǶ�');
%q=input('��y����ת�ĽǶ�');
%theta=input('��z����ת�ĽǶ�');
R_x=[1 0 0;0 cos(p) -sin(p);0 sin(p) cos(p)];
R_y=[cos(q) 0 -sin(q);0 1 0;sin(q) 0 cos(q)];
R_z=[cos(theta) -sin(theta) 0;sin(theta) cos(theta) 0;0 0 1];

R=R_z*R_y*R_x;
P_change=R*P0;

end
