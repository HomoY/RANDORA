%the lighting fun
function mylight
    %%%%%%%%%%%%%%%%%%%%light
    h1=camlight('right');%light('Position',[-1 0 0],'Style','infinite','Visible','on');
    h2=camlight('right');%light('Position',[-1 0 0],'Style','infinite');
    h3=camlight('right');%light('Position',[-1 0 0],'Style','infinite');
    %h4=camlight('right');%light('Position',[-1 0 0],'Style','infinite');
    
    lighting flat
    material metal
        h = rotate3d;                 % Create rotate3d-handle
        h.ActionPostCallback = @RotationCallback; % assign callback-function
        h.Enable = 'on';              % no need to click the UI-button
    
        % Sub function for callback
        function RotationCallback(~,~)
            h1 = camlight(h1,'right');
            h2 = camlight(h2,'right');
            h3 = camlight(h3,'right');
           % h4 = camlight(h4,'right');
        end
end
