if (!active)
{
	if (point_distance(x,y,objPlayer.x,objPlayer.y)<32) inRange =true;
	else inRange = false;
	if (inRange && objPlayer.inputActionSecondary)
	{
		active=true;
		//objPlayer.switchAttachSet;
	}
}
if (active)
{
	if (point_distance(x,y,objPlayer.x,objPlayer.y)>240) active = false;
}

//animation
alarmAnimation--;
if (alarmAnimation<0) alarmAnimation=10;
