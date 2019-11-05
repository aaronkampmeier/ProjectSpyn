global key
InitKeyboard();

SPEED = 100;

while 1
    %pause(0.1);
    display(key);
   switch key
       case 'uparrow'
           brick.MoveMotor('A',SPEED);
           brick.MoveMotor('B',SPEED);
       case 'downarrow'
           brick.MoveMotor('A',-SPEED);
           brick.MoveMotor('B',-SPEED);
       case 'leftarrow'
           brick.MoveMotor('A',-SPEED/3);
           brick.MoveMotor('B', SPEED/3);
       case 'rightarrow'
           brick.MoveMotor('A',SPEED/3);
           brick.MoveMotor('B',-SPEED/3);
       case 0
           brick.StopMotor('A', 'Brake');
           brick.StopMotor('B', 'Brake');
       case 'q'
           break;
   end
   
   if brick.TouchPressed(1) == 1
        brick.playTone(100,300,500);
   end
   
end

CloseKeyboard();