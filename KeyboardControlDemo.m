global key
InitKeyboard();

while 1
    pause(0.1);
    switch key
        case 'uparrow'
            disp('Up Arrow Pressed')
        case 'q'
            break;
    end
end

CloseKeyboard();