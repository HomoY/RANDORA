function [resultarr]=enumspmd(indata,nsize,workers) 
 
spmd (workers)   
outdata=zeros(nsize,1);        
slice=nsize/numlabs();      
i1=(labindex()-1)*slice+1;      
i2=i1-1+slice;      
for i=i1:i2           
    rank=1;            
    for j=1:nsize                
        if (indata(j)<indata(i))                  
            rank=rank+1;                 
        end            
    end            
    outdata(rank)=indata(i);       
end 
end 
 
resultarr=outdata{1}; 
for i=2:workers      
    resultarr=max(resultarr,outdata{i}); 
end 
