%% Go Straight Open-Loop Template %%

% Copyright 2014 The MathWorks, Inc.
ConnectToBrick;

%% Set up %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%------- Change ME -------------------------
% Change based on your communication setting
mylego = legoBrick;                           % Set up MATLAB and EV3 communication

% Change based on your motor port numbers
mymotor1 = motor(mylego, 'A');              % Set up motor
mymotor2 = motor(mylego, 'B');              

% Application parameters
EXE_TIME = 2;                              % Application running time in seconds
SPEED = 100;                                 % Motor speed
%-------------------------------------------

mymotor1.Speed = SPEED;                     % Set motor speed
mymotor2.Speed = SPEED;

start(mymotor1);                            % Start motor
start(mymotor2);

%% Operations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pause(EXE_TIME);                            % Wait

%% Clean up %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

stop(mymotor1);                             % Stop motor 
stop(mymotor2);

