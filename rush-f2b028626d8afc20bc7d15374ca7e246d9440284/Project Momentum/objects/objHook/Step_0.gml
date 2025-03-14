// Inherit the parent event
event_inherited();
xspd= path_speed * cos(direction*(pi/180));
yspd= -(path_speed * sin(direction*(pi/180)));

if (place_meeting(x,y,objPlayer)) 
&& (objPlayer.playerState == PlayerState.ActionHookLine)
{
	if (!hookLineActive)
	{
		path_start(hookPath, 7, path_action_stop, false);
		hookLineActive = true;
	}

	objPlayer.x = x;
	objPlayer.y = y;

	if (path_position == 1)
	{
	path_end();
	path_position = 0;
	//hookLineActive = false;
	objPlayer.playerState = PlayerState.Normal;
	objPlayer.xspd= xspd;
	objPlayer.yspd= yspd;
	}	
}

//animation
sparkFrameAlarm--;
if (sparkFrameAlarm<0)
{
	sparkFrameAlarm = 3;
	sparkFrame++;
}

//hookline movement
/*
if (hookLineActive)
{
if (place_meeting(x,y,objHookLineDown)) 
{
	yspd = hookSpeed;
	xspd = 0;
}
if (place_meeting(x,y,objHookLineDownRight)) 
{
	yspd = hookSpeed;
	xspd = hookSpeed;
}
if (place_meeting(x,y,objHookLineDownLeft)) 
{
	yspd = hookSpeed;
	xspd = -hookSpeed;
}
if (place_meeting(x,y,objHookLineLeft)) 
{
	xspd = -hookSpeed;
	yspd = 0;
}
if (place_meeting(x,y,objHookLineUpLeft)) 
{
	yspd = -hookSpeed;
	xspd = -hookSpeed;
}
if (place_meeting(x,y,objHookLineRight)) 
{
	xspd = hookSpeed;
	yspd = 0;
}
if (place_meeting(x,y,objHookLineUpRight)) 
{
	yspd = -hookSpeed;
	xspd = hookSpeed;
}
if (place_meeting(x,y,objHookLineUp)) 
{
	yspd = -hookSpeed;
	xspd = 0;
}
if (place_meeting(x,y,objHookLineExit))
{
	objPlayer.playerState = PlayerState.Normal;
	objPlayer.movementLock = false;
	if (objPlayer.playerState == PlayerState.Normal)
	{
		xspd = 0;
		yspd = 0;
		hookLineActive = false;
	}
}
}

x+=xspd;
y+=yspd;
*/
if (objPlayer.playerState == PlayerState.Dead)
{
	path_end();
	hookLineActive = false;
	xspd=0;
	yspd=0;
	x=initialX;
	y=initialY;
}




