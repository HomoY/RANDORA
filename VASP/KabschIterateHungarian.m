 % K-H algorithm
% Function: Munkres, Kabsch 
function Distance = KabschIterateHungarian(atom_number,name1,name2,axis_p,axis_q)
%function d=K_H(cell,name1,name2,axis_p,axis_q,distance)

% This is test for distance
% distance = 1;

%generate the original two contrast structure
number =atom_number;
P=axis_p;
Q=axis_q;

%define the center
P_center=sum(P)/number;
Q_center=sum(Q)/number;
%Plot result
Pplot = {};
Qplot = {};

t = 1;
M = zeros(1,number);
for i = 1 : number
    M(i)=sqrt((P(i,1)-Q(i,1))^2+(P(i,2)-Q(i,2))^2+(P(i,3)-Q(i,3))^2);
end
d(t)=sum(M);
Pplot{t} = [name1,P];
Qplot{t} = [name2, Q];


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


t=t+1; % plot timer
M = zeros(1,number);
for i = 1 : number
    M(i)=sqrt((P(1,i)-Q(1,i))^2+(P(2,i)-Q(2,i))^2+(P(3,i)-Q(3,i))^2);
end
d(t)=sum(M);
Pplot{t} = [P_n', P'];
Qplot{t} = [Q_n' , Q'];

% initial
caculation1=number^2;  % Exit loop 
s=0;  

C = zeros(number,number);                    % input outcome
for i=1:number
    for j=1:number
        if P_n(i)==Q_n(j)  
             C(i,j)=(P(1,i)-Q(1,j))^2+(P(2,i)-Q(2,j))^2+(P(3,i)-Q(3,j))^2;
        else
             C(i,j)=inf; %if they are different atom we can not contrast
        end
    end
end
z_new=Munkres(C); % new assignment matrix
P_n=P_n*z_new; % new P name 
P=P*z_new; % new p position 
%z_new = eye(number);
%main
while s ~= caculation1

% Plot the result
M = zeros(1,number);
for i = 1 : number
    M(i)=sqrt((P(1,i)-Q(1,i))^2+(P(2,i)-Q(2,i))^2+(P(3,i)-Q(3,i))^2);
end
t=t+1; % timer add 1
d(t)=sum(M);
Pplot{t} = [P_n', P'];
Qplot{t} = [Q_n' , Q'];


% K algorithm 
U=Kabsch(P,Q); % best rotation   
Q=U'*Q; % new Q position 
M = zeros(1,number);
for i = 1 : number
    M(i)=sqrt((P(1,i)-Q(1,i))^2+(P(2,i)-Q(2,i))^2+(P(3,i)-Q(3,i))^2);
end
t=t+1; % timer add 1
d(t)=sum(M);
Pplot{t} = [P_n', P'];
Qplot{t} = [Q_n' , Q'];

% Hungarian algorithm 
for i=1:number
    for j=1:number
        if P_n(i)==Q_n(j) 
             C(i,j)=(P(1,i)-Q(1,j))^2+(P(2,i)-Q(2,j))^2+(P(3,i)-Q(3,j))^2;
        else
             C(i,j)=inf;%if they are different atom we can not contrast
        end
    end
end
z_old=z_new; % Exchange for check out 
z_new=Munkres(C); 
P_n=P_n*z_new;
P=P*z_new;

s=sum(sum(z_new == z_old)); % reset s


end

% Calculate the minimum distance
for i=1:number
    M(i)=sqrt((P(1,i)-Q(1,i))^2+(P(2,i)-Q(2,i))^2+(P(3,i)-Q(3,i))^2);
end
Distance = sum(M); %I just want to get the most similiar part 
%d(t+1) = Distance
%plot(d) %plot part
%hold on 
save CdSe.mat



