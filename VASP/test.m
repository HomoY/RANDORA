mai%test for K_H_48
load Au6V.mat
x = 1;
y =3;
x_n = HKResultAll((x-1)*AtomsNumber+1:x*AtomsNumber,2)
x_pos = HKResultAll((x-1)*AtomsNumber+1:x*AtomsNumber,3:5)
y_n = HKResultAll((y-1)*AtomsNumber+1:y*AtomsNumber,2)
y_pos = HKResultAll((y-1)*AtomsNumber+1:y*AtomsNumber,3:5)
CopyfilePoint = [pwd,'/../K_H/*.m'];
copyfile(CopyfilePoint, pwd);
 Distance = K_H_48(AtomsNumber,x_n,y_n,x_pos,y_pos)