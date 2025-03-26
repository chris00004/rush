maxSpeed = 5;
z = 0;
targetX = objPlayer.x;
targetY = objPlayer.y;
targetZ = objPlayer.z;
desiredXspd= targetX - self.x;
desiredYspd= targetY - self.y;
desiredZspd= targetZ - self.z;

len = sqrt(sqr(desiredXspd) + sqr(desiredYspd) + sqr(desiredZspd));

desiredXspd = desiredXspd/len;
desiredYspd = desiredYspd/len;
desiredZspd = desiredZspd/len;

xspd = desiredXspd * maxSpeed;
yspd = desiredYspd * maxSpeed;
zspd = desiredZspd * maxSpeed;

zHeight = -sprite_height/2;
zFloor = 0;