%This is used to generate the spmd Js and run it with the Matlab platform

%can generate the important file thati need for my caculation
%and this file is used to generate the spmd document in the next step
%the file i need in the docunment is contain the files 
%structure_fit.m
%LammpsGenerate.m
%Munkres.m
%Kabsch.m
%KabschIterateHungarian.m
%in.Au
%Au.eam.fs
function [pathname,pathname1,pathname2] = CoreSet(CoreNumber)
%function CoreSet(CoreNumber)

%pathname  is .../1/ 
%pathname1 is .../1/Au.dat
%pathname2 is .../1/Au.xyz
    pathname = cell(1,CoreNumber);
    pathname1 = cell(1,CoreNumber);
    pathname2 = cell(1,CoreNumber);
    mkdir('parallel');
    path_all = [pwd,'/parallel/'];%linux is /'windows is \
    %this is designed for the copying file
    for i=1:CoreNumber
      %filename=['lion',num2str(i)];  
      pathname_0 = [pwd,'/parallel/',num2str(i)];
      pathname_1 = [pwd,'/parallel/',num2str(i),'/Au.dat']; 
      pathname_2 = [pwd,'/parallel/',num2str(i),'/Au.xyz'];
      mkdir(path_all,num2str(i))
      copyfile('structure_fit.m',pathname_0);
      copyfile('PerCoreWork.m',pathname_0);
      copyfile('LammpsGenerate.m',pathname_0);
      copyfile([pwd,'/K_H/Munkres.m'],pathname_0);
      copyfile([pwd,'/K_H/Kabsch.m'],pathname_0);
      copyfile([pwd,'/K_H/KabschIterateHungarian.m'],pathname_0);
      
      copyfile('in.Au',pathname_0);
      copyfile('Au.eam.fs',pathname_0)
      pathname{i}=pathname_0;
      pathname1{i}=pathname_1;
      pathname2{i}=pathname_2;
    
    end
    
    %below we will get the spmd.m document
    fp=fopen('myspmd.m','wt');
    fprintf(fp,'%%myspmd\n');
    %fprintf(fp,'spmd(CoreNumber)\n');
    fprintf(fp,'spmd\n');
 %   fprintf(fp,'tic\n');%this is desigened for the time counts
    fprintf(fp,'switch labindex\n');
    
    for c=1:CoreNumber
        fprintf(fp,'case ');
        fprintf(fp,'%d\n',c);
        fprintf(fp,'i=%d;\n',c);
        fprintf(fp,'route1=Path1{i};\n');
        fprintf(fp,'route2=Path2{i};\n');
        fprintf(fp,'cd(Path0{i});\n');
        fprintf(fp,'[LammpsENP, HKResult, SimilarStatistic] = PerCoreWork(AtomNamePositionMatrixSeedPer, AtomsName, AtomsNumber, StructuresNumberPer, DistanceCut, BondMin, BondMax);\n');
    end
    fprintf(fp,'end\n');
%    fprintf(fp,'toc\n');
    fprintf(fp,'end\n');
    fclose(fp);
    end
    