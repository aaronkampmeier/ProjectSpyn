if false
    brick.MoveMotorAngleRel('A',20, 200, 'Brake');
    brick.MoveMotorAngleRel('B',-20, 150, 'Brake');
    brick.WaitForMotor('AB');

else
    finalAngle = brick.GyroAngle(GYRO_PORT) + 90;
    finalAngle = brick.GyroAngle(GYRO_PORT) + 90;
    while brick.GyroAngle(GYRO_PORT) <= finalAngle - 20
        brick.MoveMotor('A',15);
        brick.MoveMotor('B',-15);
    end
    while brick.GyroAngle(GYRO_PORT) < finalAngle
        brick.MoveMotor('A',10);
        brick.StopMotor('B','Brake');
        %brick.MoveMotor('B',-6);
    end
    Brake;
end