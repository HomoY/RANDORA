
dis=distance;
dis2=[];
k=1;
p=1;
for p=1:10
for i=1:20000
    energy=(-60-p*0.3);
    if Eng(i)<=energy
        dis2(k)=dis(i);
        k=k+1;
    end
end
j=80;
   put=zeros(1,j);
    for m=1:max(size(dis2))
        for c=1:j
          cc=100/j*c;
          cd=100/j*(c-1);
        if (dis2(m)>cd) && (dis2(m)<=cc)
            put(c)=put(c)+1;
        end
        end
    end
plot(put)


hold on
end
 


