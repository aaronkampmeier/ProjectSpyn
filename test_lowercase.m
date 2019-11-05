ConnectToBrick;

mylego = legoBrick;

mymotor1 = motor(mylego, 'A');              % Set up motor
mymotor2 = motor(mylego, 'B');

mymotor1.Speed = 40;                     % Set motor speed
mymotor2.Speed = -40;

start(mymotor1);
start(mymotor2);

touchsensor = touchSensor(mylego)

pause(5);

stop(mymotor1);
stop(mymotor2);

readTouch(touchsensor);