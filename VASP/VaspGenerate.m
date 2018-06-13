% This file can be used to generate the Vasp test documents, So it should not be the function just run is OK
rmdir VaspInCaF s
mkdir VaspInCaF
p = [pwd,'/../Au8.mat'];
p2 = [pwd,'/VaspInCaF/'];
load(p)
for i = 1:(size(HKResultAll,1)/AtomsNumber)
%for i =1:1
    p3 = [p2, num2str(i),'/POSCAR'];
    mkdir(p2,num2str(i));

    fid = fopen(p3,'wt');
    a1 = ['Au',num2str(AtomsNumber)]; a2 = 'Au'; a3 = AtomsNumber; a4 = 'Car'; a5 = 20;
    fprintf(fid,'%s\n',a1);
    fprintf(fid,'%d\n',1);
    fprintf(fid,'%10.5f %10.5f %10.5f\n',a5,0,0);
    fprintf(fid,'%10.5f %10.5f %10.5f\n',0,a5,0);
    fprintf(fid,'%10.5f %10.5f %10.5f\n',0,0,a5);
    fprintf(fid,'%s\n', a2);
    fprintf(fid,'%d\n', a3);
    fprintf(fid,'%s\n', a4);
    for j = 1:AtomsNumber
        fprintf(fid,'%10.5f %10.5f %10.5f\n',HKResultAll(AtomsNumber*(i-1)+j,3:5));
    end

    
    
    fclose(fid);
    

end
