% This file is used to generate the mesurments 
function PictureDistance(PicXYZ,No1,No2)

    P1 = PicXYZ(No1,:);
    P2 = PicXYZ(No2,:);


    plot3([P1(1),P2(1)],[P1(2),P2(2)],[P1(3),P2(3)],'--',...
    'color',[.5 .5 .5],...%bond
    'LineWidth',10);
    hold on
    plot3([P1(1),P2(1)],[P1(2),P2(2)],[P1(3),P2(3)],'o',...
    'MarkerEdgeColor',[1,0.7608,0.0549],... %edge 
    'MarkerFaceColor',[0.8275,0.6588,0.0353],...%inner
    'LineWidth',10,...
    'MarkerSize',12);
    hold on
    plot3([P1(1),P2(1)],[P1(2),P2(2)],[P1(3),P2(3)],'+',...
    'color',[1,0.7608,0.0549],...
    'LineWidth',12);
    

end
