brick.MoveMotor('A',50);
brick.MoveMotor('B',50);


while brick.TouchPressed(1) == 0 
    
end

%brick.MoveMotor('A',0);
%brick.MoveMotor('B',0);

brick.StopMotor('A');
brick.StopMotor('B');

display('Done!');