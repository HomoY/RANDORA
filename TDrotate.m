%roate program
function P_change=TDrotate(p,q,theta,P0)
%syms p q theta
%p=input('绕x轴旋转的角度');
%q=input('绕y轴旋转的角度');
%theta=input('绕z轴旋转的角度');
R_x=[1 0 0;0 cos(p) -sin(p);0 sin(p) cos(p)];
R_y=[cos(q) 0 -sin(q);0 1 0;sin(q) 0 cos(q)];
R_z=[cos(theta) -sin(theta) 0;sin(theta) cos(theta) 0;0 0 1];

R=R_z*R_y*R_x;
P_change=R*P0;

end
