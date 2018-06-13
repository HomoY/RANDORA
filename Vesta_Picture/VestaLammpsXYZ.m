copyfile('../Au.xyz',pwd);
fid = fopen([pwd,'/Au.xyz']);   
fout = fopen([pwd,'/Au_Vesta.xyz'],'wt'); 
number = -9;
while ~feof(fid)
    aline = fgetl(fid);
number = number+1;
end

i = 1;
line_number=1;
fprintf(fout,'%d\n',number);%here to modify the atoms numbers
fprintf(fout,'%s\n','Au');
frewind(fid)
while 1
nextline = fgetl(fid); %read a line 
if i >= 10
    fprintf(fout,'%7s\n',nextline);
end

   if ~ischar(nextline)
      break;
   else
      line_number = line_number + 1;
   end  
  i=i+1;
end
%!fprintf(fout,'\n');

fclose(fid);  
fclose(fout);
delete('Au.xyz')