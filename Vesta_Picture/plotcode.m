%搜寻算法的示意图
bond_max=inf;
n=20;
flag=0;
g_max=0.8;
g_min=1.2;
atoms=20;
cell=20;
k_max=8.7937*(atoms/20/g_max).^(1/3);% this is designed for generation of structures 
k_min=8.7937*(atoms/20/g_min).^(1/3);

k=k_min+rand(1,3)*(k_max-k_min);
k1=k(1);k2=k(2);k3=k(3);
m=zeros(cell,3);
m(:,1) = rand(cell,1)*k1+10.6032;% 13??×?
m(:,2) = rand(cell,1)*k2+10.6032;%
m(:,3) = rand(cell,1)*k3+10.6032;%
x=m(:,1);y=m(:,2);z=m(:,3);
plot3(x,y,z,'ro',...
    'LineWidth',1,...
    'MarkerSize',12,...
    'MarkerEdgeColor',[1.0000    0.9843    0.9412],...
    'MarkerFaceColor',[0.933 0.7804 0.0627])
grid on
hold on

%below is the searching

bond_min=2.25;
pos=m;
n=cell;
last=zeros(2,n);
check=zeros(1,n);
delete=zeros(1,n);
flag=0;
i=1;
delete(i)=1;

for j=2:n
    d=sum((pos(i,:)-pos(j,:)).^2);
    if d<=bond_max
        last(1,i)=last(1,i)+1;
        last(1,j)=last(1,j)+1;
        check(j)=1;
    if d<=bond_min
        last(2,i)=last(2,i)+1;
        last(2,j)=last(2,j)+1;
    end
    end

end

%position=find(check);

while flag==0

    check=check&(~delete);
    check_sum=sum(check);
   if check_sum==0
       break;
   end
   position=find(check);
   
   check=zeros(1,n);
   
   for i=1:check_sum
        j=position(i);
        delete(j)=1;

        for c=1:n
            if c~=j
                d=sum((pos(j,:)-pos(c,:)).^2);
                if d<=bond_max
                    check(c)=1;
                    last(1,c)=last(1,c)+1;
                    last(1,j)=last(1,j)+1;
                 if d<=bond_min
                     last(2,c)=last(2,c)+1;
                     last(2,j)=last(2,j)+1;
                 end
                end

           
            end
        end
   end
end
last=last/2;