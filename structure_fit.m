% this is the algorithm of mine only fucking mine
% it was desinged for the searching the atoms nearby and we record the
% information of the surrounds atoms
%
function last = structure_fit(pos, n, bond_min, bond_max)
%
%           last=structure_fit(pos,n,bond_min,bond_max)
%           last: it contains the information about the max linking and
%           minima linking (if last is less than atom numbers it means this struture is bad, or if some atoms distance is very small we will cut it.)
%           pos:position of the  structure
%           bond_min: the shortest allowed bond
%           bond_max: the longgest allowed bond 
%*this slogrithm is desigened by myself

last=zeros(2,n);
check=zeros(1,n);
delete=zeros(1,n);
flag=0;
i=1;
delete(i)=1;  

for j=2:n
    d=sqrt(sum((pos(i,:)-pos(j,:)).^2));
    if d <= bond_max
        last(1,i)=last(1,i)+1;
        last(1,j)=last(1,j)+1;
        check(j)=1;
    if d <= bond_min
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
                d=sqrt(sum((pos(j,:)-pos(c,:)).^2));
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


end

