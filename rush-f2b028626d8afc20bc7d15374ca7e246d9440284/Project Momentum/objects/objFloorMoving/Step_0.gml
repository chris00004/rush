x+=xspd;
y+=yspd;

//Y
if (yspd>spdCapY) yspd=spdCapY;
if (yspd<-spdCapY) yspd=-spdCapY;

if (y<initialY-rangeY) dirY = 1; //flip direction to down Y
if (y>initialY+rangeY) dirY = 0; //flip direction to up Y

if (dirY==1 && y<initialY-rangeY) yspd+=accelerationY; //accelerate downward
if (dirY==0 && y>initialY+rangeY) yspd-=accelerationY; //accelerate upward

//X
if (xspd>spdCapX) xspd=spdCapX;
if (xspd<-spdCapX) xspd=-spdCapX;

if (x<initialX-rangeX) dirX = 1; //flip direction to right X
if (x>initialX+rangeX) dirX = 0; //flip direction to left X

if (dirX==1 && x<initialX-rangeX) xspd+=accelerationX; //accelerate right
if (dirX==0 && x>initialX+rangeX) xspd-=accelerationX; //accelerate left

//PLAYER
if (place_meeting(x,y,objPlayer)) && (objPlayer.grounded)
{
	addToPlayerSpd=true;
}

if ((!place_meeting(x,y,objPlayer)) || (!objPlayer.grounded)) && (addToPlayerSpd)
{
	addToPlayerSpd=false;  
	objPlayer.xspd+=xspd;
	objPlayer.yspd+=yspd;
	objPlayer.movingPlatSpdX = 0;
	objPlayer.movingPlatSpdY = 0;
}


if (addToPlayerSpd)
{
	objPlayer.movingPlatSpdX = xspd;
	objPlayer.movingPlatSpdY = yspd;
}


