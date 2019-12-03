%% Set up constants
END_COLOR = 2; %Green: 2, Blue: 2, Red: 5%
COLOR_PORT = 3;
ULTRASONIC_PORT = 2;
TOUCH_PORT = 1;
SPEED = 60;

%% Set up sensors
brick.SetColorMode(COLOR_PORT, 2); %Maybe change to Color RGB: 4 instead of Color Code: 2 to get more accurate reading

%% Just get going
DriveForward;

%% Keep going until the ultrasonic detects a distance greater than specified distance or the touch is pressed or the color detects something
HUGGING_DISTANCE = 24;
hasAdjusted = 0;
adjustTime = now;

while brick.ColorCode(COLOR_PORT) ~= END_COLOR
    
    if brick.ColorCode(COLOR_PORT) == 5
        Brake;
        pause(1);
        DriveForward;
    end
    
    if (second(now) - second(adjustTime)) > 1
        hasAdjusted = 0;
    end
    brick.UltrasonicDist(ULTRASONIC_PORT)
    
    
    %Check the touch sensor
    if brick.TouchPressed(TOUCH_PORT) == 1
        %Then back back back it up
        StopAndCoast;
        BackItUp;
        pause(1);
        %Then turn it out (to the left)
        if (brick.UltrasonicDist(ULTRASONIC_PORT) < 40)
            brick.MoveMotorAngleRel('A',-SPEED/2, 200, 'Brake');
            brick.MoveMotorAngleRel('B',SPEED/2, 170, 'Brake');
            brick.WaitForMotor('AB');
        else
            brick.MoveMotorAngleRel('A',SPEED/2, 200, 'Brake');
            brick.MoveMotorAngleRel('B',-SPEED/2, 170, 'Brake');
            brick.WaitForMotor('AB');
        end
        DriveForward;
        
    end
end

StopAndCoast;

beep(brick);

