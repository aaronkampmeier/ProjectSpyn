%% Set up constants
END_COLOR = 2; %Green: 3, Blue: 2, Red: 5%
COLOR_PORT = 1;
ULTRASONIC_PORT = 2;
ULTRASONIC_LEFT_PORT = 4;
GYRO_PORT = 4;
TOUCH_PORT = 3;
SPEED = 60;

%% Set up sensors
brick.SetColorMode(COLOR_PORT, 2); %Maybe change to Color RGB: 4 instead of Color Code: 2 to get more accurate reading
brick.GyroCalibrate(GYRO_PORT);
pause(1);

%% Just get going
DriveForward;

%% Keep going until the ultrasonic detects a distance greater than specified distance or the touch is pressed or the color detects something
hasAdjusted = 0;
adjustTime = now;

while true

    while brick.ColorCode(COLOR_PORT) ~= END_COLOR

        %Pause at stop sign (red line)
        if brick.ColorCode(COLOR_PORT) == 5
            Brake;
            pause(1);
            DriveForward;
            pause(1);
        end
        
        %Debug outputs
        disp("Right: ")
        brick.UltrasonicDist(ULTRASONIC_PORT)
        %disp("Left: ")
        %brick.UltrasonicDist(ULTRASONIC_LEFT_PORT)
        
        if false
            %Method 1
            %Keep driving forward until hitting a wall
            if brick.TouchPressed(TOUCH_PORT) == 1
                %Check both ultrasonic sides
                StopAndCoast;
                BackItUp;
                pause(1);
                
                if brick.UltrasonicDist(ULTRASONIC_PORT) > brick.UltrasonicDist(ULTRASONIC_LEFT_PORT)
                    %Turn right
                    disp("****Turning Right");
                    TurnRight;
                else
                    disp("****Turning Left");
                    %Turn left
                    TurnLeft;
                end
                pause(1);
                DriveForward;
            end
            
        else
            %Method 2
            if brick.TouchPressed(TOUCH_PORT) == 1
                %Check both ultrasonic sides
                StopAndCoast;
                BackItUp;
                pause(1);
                Brake;
                
                %Check both sides
                TurnRight;
                pause(0.5);
                rightDist = brick.UltrasonicDist(ULTRASONIC_PORT);
                TurnLeft;
                TurnLeft;
                pause(0.5);
                leftDist = brick.UltrasonicDist(ULTRASONIC_PORT);
                
                if leftDist > rightDist
                    DriveForward;
                else
                    TurnRight;
                    TurnRight;
                    DriveForward;
                end
                
            end
        end

    end
    
    StopAndCoast;
    
    beep(brick);
    
    if END_COLOR ~= 3
        KeyboardControl;
        
        SPEED = 60;
        
        %Account for fork in maze
        %Go 1300 deg forward
        brick.MoveMotorAngleRel('AB',SPEED,1200,'Brake');
        brick.WaitForMotor('AB');
        
        brick.GyroCalibrate(GYRO_PORT);
        pause(1);
        TurnLeft;
        pause(0.5);
        brick.MoveMotorAngleRel('AB',SPEED,1200,'Brake');
        brick.WaitForMotor('AB');
        TurnLeft;
        
        brick.MoveMotorAngleRel('AB',SPEED,1200,'Brake');
        brick.WaitForMotor('AB');
        TurnRight;
        
        brick.MoveMotorAngleRel('AB',SPEED,1200,'Brake');
        brick.WaitForMotor('AB');
        TurnLeft;
        
        brick.MoveMotorAngleRel('AB',SPEED,1200,'Brake');
        brick.WaitForMotor('AB');
        TurnLeft;
        
        
        
        DriveForward;
        
        END_COLOR = 3;
    else
        break;
    end
end

