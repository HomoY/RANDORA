%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this file is used to generate the struture from the lammps document, it
%contains  step 1: generate the input document of the 'lammps', save it
%          as the in Au.dat (with format of lammps)
%          step 2:perform the lammps and save the log in log.lap and the position document is saved in pos.xyz
%          step 3:reload the pos.xyz and get optimized atom position 
%          step 4:read the Engergy data from the log.lap  
function AtomNamePositionMatrix = LammpsGenerate(AtomNumber, AtomName, AtomNamePositionMatrix)
%input: 
%     AtomNumber: INPUT atom numbers
%     AtomName: name of the atoms (this is designed for the one atoms)
%     k_max and k_min: the random box max and min random range, box size = k_min + random(0-1)*(k_max-k_min)
%     
%output: 
%     EnergyOutput: energy of the optimized struture
%     AtomNameOutput: name of atoms under lammps runs result
%     AtomsPosition: Atom position after optimization 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %AtomNumber='Au'; % the name of atoms
        
    %step 1:===================================================================
    
    a1 = 'Au'; a2 = 'atoms'; a3 = 'xlo xhi'; a4 = 'ylo yhi'; %Au
    a5 = 'zlo zhi'; a6 ='Atoms'; a7 = 'atom types';
    fp = fopen('Au.dat','wt');
    fprintf(fp,'%s\n',a1);
    fprintf(fp,'%6d %12s\n',AtomNumber,a2);
    fprintf(fp,'%6d %12s\n',1,a7);
    
    fprintf(fp,'%6.2f %6.2f %12s\n',0,30,a3);
    fprintf(fp,'%6.2f %6.2f %12s\n',0,30,a4);
    fprintf(fp,'%6.2f %6.2f %12s\n',0,30,a5);
    
    fprintf(fp,'\n');
    fprintf(fp,'%s\n','Masses');
    fprintf(fp,'\n');
    fprintf(fp,'%d %3.1d',1,197.0);
    fprintf(fp,'\n');
    fprintf(fp,'\n');
    fprintf(fp,'%s\n',a6);
    fprintf(fp,'\n');
    
    for i = 1 : AtomNumber
    fprintf(fp,'%3d %3d %8.5f %8.5f %8.5f\n',AtomNamePositionMatrix(i,:));
    end
    fprintf(fp,'\n');
    fclose(fp);
    
    %step 2:===================================================================
    
    system('lmp_serial < in.Au > log.lap');
    
    %step 3:===================================================================
    
    fid1 = fopen('Au.xyz','r');
    AtomPosition = zeros(AtomNumber,3);
    AtomNameOutput = zeros(1,AtomNumber);
    n=1;
    i=1;
    while ~feof(fid1)
        aline = fgetl(fid1);
    %this is designed for the caculation of the situation with different atoms       
        if n >= 10            %n>10 means only when n >10 you can touch the data
         
           if aline(1) == AtomName(1)&&aline(2) == AtomName(2)
                AtomNameOutput(i) = 1;
           else
               fprintf('generate.m can not get the atoms position,from 84 line')
          end
            AtomPosition(i,:) = str2num(aline(4:end));
            i = i+1;
            continue
        end
    n = n+1;
    end
    fclose(fid1);
    
    %step 4:===================================================================
    
    fid = fopen('log.lammps');
    linenum = 88; % PC is 90, linux is 88
    C = textscan(fid,'%f', 6,'delimiter','\n', 'headerlines',linenum-1);    
    
    if max(size(C{1})) == 6
        EnergyOutput = C{1}(3);
    else
        linenum = 89; % PC is 91
        C = textscan(fid,'%f', 6,'delimiter','\n', 'headerlines',linenum-1);    
        EnergyOutput = C{1}(3);
	%C{1}
    end
    fclose(fid);
    AtomNamePositionMatrix = zeros(AtomNumber,5);
    AtomNamePositionMatrix(1) = EnergyOutput;
    AtomNamePositionMatrix(:,2) = AtomNameOutput;
    AtomNamePositionMatrix(:,3:5) = AtomPosition;
    end
    
    
