ConnectToBrick;

mylego = legoBrick;
rightmotor = motor(mylego, 'A');
leftmotor = motor(mylego, 'B');

% clearLCD(legoBrick);
% writeLCD(legoBrick, 'Vroom Vroom', 4,6);

%% Set up Sensors

touchsensor = touchSensor(legoBrick, 1);

%% Drive Forward
SPEED = 50;
rightmotor.Speed = SPEED;
leftmotor.Speed = 100;

start(rightmotor);
start(leftmotor);

while (readTouch(touchsensor) ~= 1)
    stop(rightmotor);
    stop(leftmotor);
end