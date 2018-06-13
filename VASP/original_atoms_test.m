% test for K-H algorithm atoms generate
% function: 
% 1: rand_atom
% 2: rands_atom: rand and store with vesta .xyz format
% 3: read file: read file with .xyz
% 4: read L file: read file with lammps outcome format 
% 5: op1: optimized the exist the pos1.xyz pos2.xyz to pox1, pox2 
% 6: op2: optimize the random result and optimized it
% global parameter: number, box and aname
% Currently this file is only work for the single atom = = two atom is a
% hard work
function [test_p,test_q,name_p,name_q] = original_atoms_test(fname,number,box,aname)

    if fname == 1
        [test_p,test_q,name_p,name_q] = rand_atom;
    elseif fname == 2
        [test_p,test_q,name_p,name_q] = rands_atom;
    elseif fname == 3
        [test_p,test_q,name_p,name_q] = readfile;
    elseif fname == 4
        [test_p,test_q,name_p,name_q] = readLfile;
    elseif fname == 5
        [test_p,test_q,name_p,name_q] = op1;
    elseif fname == 6
        [test_p,test_q,name_p,name_q] = op1;
    end
    
%%
    % Rand atom with specific parameter
    function [p1,p2,n1,n2] = rand_atom

        %box = 10; % enter the box size
        p1 = box*rand(3,number);
        p2 = box*rand(3,number);
        n1 = ones(1,number);
        n2 = ones(1,number);
    end
%% 
    % Rand atom and store the information with vesta xyz format 
    % *This is only make sense to single atoms 
    function [p1,p2,n1,n2] = rands_atom
        [p1,p2,n1,n2] = rand_atom;
        
        
        
    end
%%
    % Read the files information, pos1, pos2, this method is only suit to
    % lammps document !!!!
    function [p1,p2,n1,n2] = read_file
        [p1,n1]=step4('pos1');
        [p2,n2]=step4('pos2');
    end
    % generate -> store -> optimize -> read 
    % documents: pos1.xyz, pos2.xyz, pos1, pos2 
    
%%
    % this is used to read the file 
    function [p,name_in]=step4(filename)
        fid1=fopen(filename,'r');
        n=1;
        p=zeros(number,3);
        name_in=zeros(1,number);
        i=1;
        while ~feof(fid1)
            aline=fgetl(fid1);
        %this is designed for the caculation of the situation with different atoms       
            if n>=10            %n>10 means only when n >10 you can touch the data
               if aline(1)==name(1)&&aline(2)==name(2)
                    name_in(i)=1;
               else
                   fprintf('generate.m can not get the atoms position,from 84 line')
              end
                p(i,:)=str2num(aline(4:end));
                i=i+1;
                continue
            end
            n=n+1;
        end
        fclose(fid1);
        p=p';
    end
%% Writing .xyz can be read by vesta 
    function [p,name_in]=generate_vesta_xyz(pos,na,filename)
        
        fp = fopen(filename,'wt');
        fprintf(fp,'%6d\n',number);
        fprintf(fp,'%s\n',aname);
        for i=1:max(sizeof(na))
            fprintf(fp,'%s %8.5f %8.5f %8.5f\n',na,pos(:,i)');
        end
        fclose(fp);
    end


end