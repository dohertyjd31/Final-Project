function[] = plotVariables()
    
    fig = figure('numbertitle','off','name','Graph');  %what follows is an absurd amount of UI inputs and preemptive variable settings 
    button1 = uicontrol('style','pushbutton','units','normalized','position', [0.425 0.05 0.15 0.1],'string','Plot','callback',{@buttonPressCallback});
    button2 = uicontrol('style','pushbutton','units','normalized','position', [.825 .05 .15 .1],'string','Clear All','callback',{@clearAll});
    bg1 = uibuttongroup(fig,'position',[0.04 0.6 0.15 0.25]); 
    rb1 = uicontrol(bg1,'style','radiobutton','string','Black','Position',[20 70 100 30],'callback',{@blackPress});
    rb2 = uicontrol(bg1,'style','radiobutton','string','Blue','Position',[20 40 100 30],'callback',{@bluePress});
    rb3 = uicontrol(bg1,'style','radiobutton','string','Green','Position',[20 10 100 30],'callback',{@greenPress});
    bg2 = uibuttongroup(fig,'position',[0.04 0.3 0.15 0.25]); 
    rb4 = uicontrol(bg2,'style','radiobutton','string','Solid','Position',[20 70 100 30],'callback',{@solidPress});
    rb5 = uicontrol(bg2,'style','radiobutton','string','Dashed','Position',[20 40 100 30],'callback',{@dashedPress});
    rb6 = uicontrol(bg2,'style','radiobutton','string','Dotted','Position',[20 10 100 30],'callback',{@dottedPress});
    bg3 = uibuttongroup(fig,'position',[0.04 0 0.15 0.25]); 
    rb7 = uicontrol(bg3,'style','radiobutton','string','Star','Position',[20 70 100 30],'callback',{@starPress});
    rb8 = uicontrol(bg3,'style','radiobutton','string','o','Position',[20 40 100 30],'callback',{@oPress});
    rb9 = uicontrol(bg3,'style','radiobutton','string','x','Position',[20 10 100 30],'callback',{@xPress});
    xInput = uicontrol('Style','edit','String',' ','Position',[100,360,120,30],'callback',{@xInputBox});
    yInput = uicontrol('Style','edit','String',' ','Position',[350,360,120,30],'callback',{@yInputBox});
    xInputLabel = annotation('textbox', [0.219 0.9 0.1 0.1], 'String', "x Values");
    yInputLabel = annotation('textbox', [0.67 0.9 0.1 0.1], 'String', "y Values");
    changeTitleInput = uicontrol('Style','edit','String',' ','Position',[425,275,120,30],'callback',{@changeTitle});
    changeTitleLabel = annotation('textbox', [0.78 0.7 0.1 0.1], 'String', "Change Title");
    axisPanel = uipanel(fig, 'Position', [0.25 0.15 0.5 .7], 'BackgroundColor', [0.7 0.7 0.7]);
    mainGraph = axes(axisPanel, 'Position', [0.1 .15 0.8 0.8]);
    titleNameHere = 'Title';
    title(titleNameHere);
    xString = [];
    yString = [];
    xValues = [];
    yValues = [];
    x = 'k';
    y = '-';
    z = '*';
    
  
    function changeTitle(source,event) %changes the title
        newTitle = get(changeTitleInput,'string');
        titleNameHere = newTitle;
        title(titleNameHere)
    end
       
    function blackPress(source,event) %these functions deal with the radio buttons.
        x = 'k';
    end

    function bluePress(source,event)
        x = 'b';
    end

    function greenPress(source,event)
        x = 'g';
    end

    function solidPress(source,event)
        y = '-';
    end
    
    function dashedPress(source,event)
        y = '--';
    end

    function dottedPress(source,event)
        y = ':';
    end
    
    function starPress(source,event)
        z = '*';
    end

    function oPress(source,event)
        z = 'o';
    end

    function xPress(source,event)
        z = 'x';
    end
    
    
    
    function xInputBox(source,event)  %the next two functions compute the string output of the x and y input boxes, and decide whether the input is valid or not. 
        xString = get(xInput,'string');
        if ~isempty(regexp(xString,'\[[\d.,]+\]', 'once'))
            xValues = str2num(xString);
        elseif ~isempty(regexp(xString,'[\d.,]+', 'once'))
            f = errordlg('Add brackets before and after list of values.','Error');
        else
            f = errordlg('Only numerical inputs are accepted.','Error');
        end
    end

    function yInputBox(button1,event)
        yString = get(yInput,'string');
        if ~isempty(regexp(yString,'\[[\d.,]+\]', 'once'))
            yValues = str2num(yString);
        elseif ~isempty(regexp(xString,'[\d.,]+', 'once'))
            f = errordlg('Add brackets before and after list of values.','Error');
        else
            f = errordlg('Only numerical inputs are accepted.','Error');
        end
    end

    function buttonPressCallback(source,event) %takes the array outputs from the above functions and if they are both not empty and equal, it plots them on the figure.
        if (~isempty(xValues) && ~isempty(yValues))
            if length(xValues) == length(yValues)
                p = plot(xValues,yValues);
                p.Color = x;
                p.LineStyle = y;
                p.Marker = z;
            else
                f = errordlg('Ensure x and y have equal amounts of points.','Error');
            end
        else
            f = errordlg('Only numerical inputs are accepted.','Error'); %if the inputs are invalid and a plot is still attempted, an error displays and the inputs are erased.
            set(xInput,'String','');
            set(yInput,'String','');
        end
    end

    function clearAll(source,event) %tied to the clear all button
        set(xInput,'String','');
        set(yInput,'String','');
        set(changeTitleInput,'String','');
        hold off
        plot(0,0)
    end
end