if (image_angle==0) 
{
	yspd=-spd;
	xspd=0;
}
if (image_angle==45) 
{
	yspd=(-spd * ((sqrt(2))/2));
	xspd=(-spd * ((sqrt(2))/2));
}
if (image_angle==90) 
{
	yspd=0;
	xspd=-spd;
}
if (image_angle==135) 
{
	yspd=(spd * ((sqrt(2))/2));
	xspd=(-spd * ((sqrt(2))/2));
}
if (image_angle==180) 
{
	yspd=spd;
	xspd=0;
}
if (image_angle==225) 
{
	yspd=(spd * ((sqrt(2))/2));
	xspd=(spd * ((sqrt(2))/2));
}
if (image_angle==270) 
{
	yspd=0;
	xspd=spd;
}
if (image_angle==315) 
{
	yspd=(-spd * ((sqrt(2))/2));
	xspd=(spd * ((sqrt(2))/2));
}

if ((place_meeting(x,y,objPlayer)) && (objPlayer.playerState = PlayerState.ActionDashPanel) && (objPlayer.grounded))
{
	if (!posLock)
	{
		objPlayer.x=x;
		objPlayer.y=y-6;
		posLock=true;
	}
	objPlayer.xspdReturned = xspd;
	objPlayer.yspdReturned = yspd;
	objPlayer.alarmDashPanel = alarm0;
}
else posLock=false;