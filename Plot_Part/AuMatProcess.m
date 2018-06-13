%We use this file to process the Au*v.mat HKResultAll files, the only this is about WhitchStructure
function AuMatProcess(WhitchStructure,HKResultAll,AtomsNumber,No1,No2,bond,vector)

warning('off');

PicName = HKResultAll((WhitchStructure-1)*AtomsNumber+1:WhitchStructure*AtomsNumber,2);
PicXYZ = HKResultAll((WhitchStructure-1)*AtomsNumber+1:WhitchStructure*AtomsNumber,3:5);
Energy = HKResultAll((WhitchStructure-1)*AtomsNumber+1,1);
my_pos(PicXYZ,PicName,No1,No2); %Picture Atoms Not include the Arrows

my_pos2(PicXYZ,PicName,No1,No2);

my_bond(PicXYZ,PicName,No1,No2);
my_eng(WhitchStructure,Energy)
shading flat
grid off
axis equal
axis off
mylight
view(3)
%hold off

function my_pos(position,name,No1,No2) %function for atoms
    %mymap=[0.8275,0.6588,0.0353]; % Au color 
    mymap = [0.9961,0.6980,0.2196]; % Au color 
    %mymap =  [0.8275,0.6588,0.0353];
    colormap(mymap);
    %a=importdata(name,' ',2);
    %a=a.data;
    a = position;
    b = name;
    r=0.5;% atoms sizes
    
    [x,y,z]=sphere(100);
    for i=1:max(size(a)) 
        if i == No1 || i == No2
            %PictureDistance(position,No1,No2);
            continue;
        end 
      
        surf(a(i,1)+r*x,a(i,2)+r*y,a(i,3)+r*z);
        hold on
    end
    freezeColors;
end
    function my_pos2(position,name,No1,No2)
        %mymap=[0.8275,0.6588,0.0353]; % Au color 
        mymap = [0.9961,0.6980,0.2196]; % Au color 
        if No1 < No2
        mymap =  [0.8275,0.6588,0.0353];
        end
        colormap(mymap);
        %a=importdata(name,' ',2);
        %a=a.data;
        a = position;
        b = name;
        r=0.5;% atoms sizes
        
        [x,y,z]=sphere(100);
        for i=1:max(size(a)) 
            if i == No1 || i == No2
                %PictureDistance(position,No1,No2);
                
            
            surf(a(i,1)+r*x,a(i,2)+r*y,a(i,3)+r*z);
            hold on
            end
        end
        freezeColors;
    end


function my_bond(position, name, No1, No2)
    
    %mymap=[0.8275,0.6588,0.0353]; % Au color
    mymap=[0.9961,0.6980,0.2196];
    colormap(mymap);
    distance=9.0;
    a=position;
    R=0.1;
    for i=1:max(size(a))-1
        for j=i+1:max(size(a))
            %[i j]
            
            if (i == No1 && j == No2)
                plot3([a(i,1),a(j,1)], [a(i,2),a(j,2)], [a(i,3),a(j,3)], ':','color',[0.5,0.5,0.5], 'LineWidth', 6);
                sqrt((a(i,1)-a(j,1))^2+(a(i,2)-a(j,2))^2+(a(i,3)-a(j,3))^2)
                continue;
            end 
                if (((a(i,1)-a(j,1))^2+(a(i,2)-a(j,2))^2+(a(i,3)-a(j,3))^2)<distance)
                    [X, Y, Z] = cylinder2P(R,100,a(i,:),a(j,:));
                    surf(X,Y,Z)
                    hold on
                end
        end
    end
    freezeColors;
end

function my_eng(WhitchStructure,energy)
    [WhitchStructure,energy]
    %text(1,1,1,[energy, 'eV']);
end

end 