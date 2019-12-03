finalAngle = brick.GyroAngle(GYRO_PORT) - 90;
finalAngle = brick.GyroAngle(GYRO_PORT) - 90;
while brick.GyroAngle(GYRO_PORT) > finalAngle + 20
    brick.MoveMotor('A',-15);
    brick.MoveMotor('B',15);
end
while brick.GyroAngle(GYRO_PORT) > finalAngle
    brick.MoveMotor('B',10);
    brick.StopMotor('A','Brake');
end
Brake;