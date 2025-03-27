z+=zspd;
x+=xspd;
y+=yspd;
zspd+=grav;

if (z>zfloor)
{
	zspd=0;
	z=zfloor;
	grounded=true;
}
if (z<zfloor) grounded=false;

alarmFrame--;
if (alarmFrame<0)
{
	alarmFrame=alarmFrameTiming;
	frame++;
}

//chnage framerate based on animation
if (currentSprite==sprIntroGuardWalk) alarmFrameTiming=7;
else if (currentSprite==sprIntroGuardShootHook 
|| currentSprite==sprIntroGuardHoldPlayer
|| currentSprite==sprIntroGuardPunch)alarmFrameTiming = 5;
else alarmFrameTiming = 4;

switch (currentSprite)
{
	case sprIntroGuardIdleDown:
	
	break;
	
	case sprIntroGuardIdleSide:

	break;
	
	case sprIntroGuardWalk:

	break;

	case sprIntroGuardGrab:
	if (frame>8) frame=8;
	break;
	
	case sprIntroGuardFired:
	if (frame>3) frame=3;
	break;
	
	case sprIntroGuardReFired:
	if (frame>3) frame=3;
	break;
	
	case sprIntroGuardHit:
	if (frame>2) frame=2;
	break;
	
	case sprIntroGuardShootHook:
	if (frame>12) frame=12;
		if (frame==10 && !instance_exists(objIntroHookShot)) 
		instance_create_layer(x+27,y,layer_get_id("objectsFG"),objIntroHookShot);
	break;
	
	case sprIntroGuardHoldPlayer:
	if (frame>2) frame=2;
	break;
	
	case sprIntroGuardPunch:
	if (frame>13) frame=13;
	break;
}