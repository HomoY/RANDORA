%K-H algorithm for 48 Rotation
function d=K_H_48(atom_number,name1,name2,axis_p,axis_q)
%function d=K_H(cell,name1,name2,axis_p,axis_q,distance)

% This is test for distance
% distance = 1;

%generate the original two contrast structure
number =atom_number;
P=axis_p; % P is [x,y,z] format
Q=axis_q;
%define the center
P_center=sum(P)/number;
Q_center=sum(Q)/number;

%move the atom into center
P(:,1)=P(:,1)-P_center(1);
P(:,2)=P(:,2)-P_center(2);
P(:,3)=P(:,3)-P_center(3);
Q(:,1)=Q(:,1)-Q_center(1);
Q(:,2)=Q(:,2)-Q_center(2);
Q(:,3)=Q(:,3)-Q_center(3);

%a small rotate step to satisfied the next caculation
P=P';
Q=Q';
P_n=name1';
Q_n=name2';

%Rotate Method for 48 posibility
p{1}=[1 0 0;0 1 0;0 0 1];p{2}=[1 0 0;0 1 0;0 0 -1];p{3}=[1 0 0;0 -1 0;0 0 1];p{4}=[1 0 0;0 -1 0;0 0 -1];
p{5}=[1 0 0;0 0 1;0 1 0];p{6}=[1 0 0;0 0 1;0 -1 0];p{7}=[1 0 0;0 0 -1;0 1 0];p{8}=[1 0 0;0 0 -1;0 -1 0];
p{9}=[-1 0 0;0 1 0;0 0 1];p{10}=[-1 0 0;0 1 0;0 0 -1];p{11}=[-1 0 0;0 -1 0;0 0 1];p{12}=[-1 0 0;0 -1 0;0 0 -1];
p{13}=[-1 0 0;0 0 1;0 1 0];p{14}=[-1 0 0;0 0 1;0 -1 0];p{15}=[-1 0 0;0 0 -1;0 1 0];p{16}=[-1 0 0;0 0 -1;0 -1 0];
p{17}=[0 1 0;1 0 0;0 0 1];p{18}=[0 1 0;1 0 0;0 0 -1];p{19}=[0 1 0;-1 0 0;0 0 1];p{20}=[0 1 0;-1 0 0;0 0 -1];
p{21}=[0 1 0;0 0 1;1 0 0];p{22}=[0 1 0;0 0 1;-1 0 0];p{23}=[0 1 0;0 0 -1;1 0 0];p{24}=[0 1 0;0 0 -1;-1 0 0];
p{25}=[0 -1 0;1 0 0;0 0 1];p{26}=[0 -1 0;1 0 0;0 0 -1];p{27}=[0 -1 0;-1 0 0;0 0 1];p{28}=[0 -1 0;-1 0 0;0 0 -1];
p{29}=[0 -1 0;0 0 1;1 0 0];p{30}=[0 -1 0;0 0 1;-1 0 0];p{31}=[0 -1 0;0 0 -1;1 0 0];p{32}=[0 1 0;0 0 -1;-1 0 0];
p{33}=[0 0 1;1 0 0;0 1 0];p{34}=[0 0 1;1 0 0;0 -1 0];p{35}=[0 0 1;-1 0 0;0 -1 0];p{36}=[0 0 1;-1 0 0;0 1 0];
p{37}=[0 0 1;0 1 0;1 0 0];p{38}=[0 0 1;0 1 0;-1 0 0];p{39}=[0 0 1;0 -1 0;-1 0 0];p{40}=[0 0 1;0 -1 0;1 0 0];
p{41}=[0 0 -1;1 0 0;0 1 0];p{42}=[0 0 -1;1 0 0;0 -1 0];p{43}=[0 0 -1;-1 0 0;0 -1 0];p{44}=[0 0 -1;-1 0 0;0 1 0];
p{45}=[0 0 -1;0 1 0;1 0 0];p{46}=[0 0 -1;0 1 0;-1 0 0];p{47}=[0 0 -1;0 -1 0;-1 0 0];p{48}=[0 0 -1;0 -1 0;1 0 0];


%the caculation of the distance
C=zeros(number,number);
M=zeros(1,number);


d1=1./zeros(1,48);
for matrix=1:48

    P=p{matrix}*P;
 
caculation1=number^2;  % make sure circle can get out of if match well
s=0;    %input outcome

for i=1:number
    for j=1:number
        if P_n(i)==Q_n(j)  
             C(i,j)=(P(1,i)-Q(1,j))^2+(P(2,i)-Q(2,j))^2+(P(3,i)-Q(3,j))^2;
        else
            C(i,j)=inf;%if they are different atom we can not contrast
        end
    end
end

z_new=Munkres(C);
%z_old=z_new;


P_n=P_n*z_new;
P=P*z_new;


%main
while s~=caculation1

U=Kabsch(P,Q);  
	Q=U'*Q;

for i=1:number
    for j=1:number
        if P_n(i)==Q_n(j) 
             C(i,j)=(P(1,i)-Q(1,j))^2+(P(2,i)-Q(2,j))^2+(P(3,i)-Q(3,j))^2;
        else
             C(i,j)=inf;%if they are different atom we can not contrast
        end
    end
end


z_old=z_new;
z_new=Munkres(C);

P_n=P_n*z_new;
P=P*z_new;

s=sum(sum(z_new == z_old));


end


for i=1:number
    M(i)=sqrt((P(1,i)-Q(1,i))^2+(P(2,i)-Q(2,i))^2+(P(3,i)-Q(3,i))^2);
end
  
  d1(matrix)=sum(M);
  %if d1(matrix)<=distance
     % d=d1(matrix);
 %     break;
 % end
 % plot(matrix,d1(matrix),'ro')
  %hold on
end
%d01
%d1
d=min(d1); %I just want to get the most similiar part
%plot(d1)
%hold on
end
