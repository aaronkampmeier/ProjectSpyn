%% Set up constants
END_COLOR = 2; %Green: 3, Blue: 2, Red: 5%
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

while true

    while brick.ColorCode(COLOR_PORT) ~= END_COLOR

        if brick.ColorCode(COLOR_PORT) == 5
            Brake;
            pause(1);
        end

        if (second(now) - second(adjustTime)) > 1
            hasAdjusted = 0;
        end
        brick.UltrasonicDist(ULTRASONIC_PORT)
        if brick.UltrasonicDist(ULTRASONIC_PORT) < (HUGGING_DISTANCE + 4) && brick.UltrasonicDist(ULTRASONIC_PORT) > (HUGGING_DISTANCE - 4)
            %Just keep driving
            DriveForward;
            hasAdjusted = 0;
        elseif brick.UltrasonicDist(ULTRASONIC_PORT) > HUGGING_DISTANCE
            %Veer towards the right until a wall is found
    %         brick.MoveMotor('B',;
    %         brick.MoveMotorAngleRel('A', SPEED/1.2, 60, 'Coast');
    %         brick.WaitForMotor('A');
    %         DriveForward;
            %brick.MoveMotorAngleRel('B', SPEED/1.2,
            if hasAdjusted ~= 1 
                brick.MoveMotor('A', SPEED/1.1);
                brick.MoveMotor('B',SPEED/2);
                pause(0.7);
                DriveForward;
                hasAdjusted = 1;
                adjustTime = now;
            end

        elseif brick.UltrasonicDist(ULTRASONIC_PORT) < HUGGING_DISTANCE
            hasAdjusted = 0;
            brick.MoveMotor('A',SPEED/1.4);
            brick.MoveMotor('B',SPEED/1.1);
            %brick.MoveMotor('A', -SPEED/2, 10, 'Brake')
            %brick.MoveMotor('AB', SPEED/1.5, 360, 'Brake')
        end

        %Check the touch sensor
        if brick.TouchPressed(TOUCH_PORT) == 1
            %Then back back back it up
            StopAndCoast;
            BackItUp;
            pause(1);
            %Then turn it out (to the left)
    %         brick.MoveMotorAngleRel('A',-SPEED/2, 220, 'Brake');
    %         brick.MoveMotorAngleRel('B',SPEED/2, 180, 'Brake');
    %         brick.WaitForMotor('AB');
    %         %brick.MoveMotor('A', -SPEED/3);
    %         %brick.MoveMotor('B', SPEED/3);
    %         DriveForward;
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
    
    if END_COLOR ~= 3
        KeyboardControl;
        
        END_COLOR = 3;
    else
        break;
    end
end

