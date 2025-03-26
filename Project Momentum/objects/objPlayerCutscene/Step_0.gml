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
	alarmFrame=4;
	frame++;
}

if (objIntroCutsceneController.animStatePlayer==10)
{
	switch(frame)
	{
		case 0:
		z=-26;
		x=objGuardCutscene.x-30;
		break;
		case 1:
		z=-38;
		x=objGuardCutscene.x-26;
		break;
		case 2:
		z=-40;
		x=objGuardCutscene.x-25;
		break;
		case 3:
		z=-41;
		x=objGuardCutscene.x-24;
		break;
	}
}

if (objIntroCutsceneController.animStatePlayer==11)
{
	switch(objGuardCutscene.frame)
	{
		case 0:
		z=-25;
		x=objGuardCutscene.x-34;
		break;
		case 1:
		z=-18;
		x=objGuardCutscene.x-37;
		break;
		case 2:
		z=-19;
		x=objGuardCutscene.x-37;
		break;
		case 3:

		break;
	}
}

switch (currentSprite)
{
	case sprXIdleDown:
	
	break;
	
	case sprIntroPlayerGrabbed:
		if (frame>4) frame=4;
	break;
	
	case sprIntroPlayerSliding:
		if (frame>2) frame=2;
	break;

	case sprIntroPlayerHandsExclaim:
		if (frame>2) frame=2;
	break;
	
	case sprIntroPlayerCrossedArms:
		if (frame>3) frame=3;
	break;
	
	case sprIntroPlayerThrowing:
		if (frame>9) frame=9;
		if (frame==7 && !instance_exists(objIntroMotherboardThrown)) 
		instance_create_layer(x-8,y,layer_get_id("player"),objIntroMotherboardThrown);
	break;
	
	case sprIntroPlayerIdleing:
		if (frame>3) frame=3;
	break;
	
		case sprIntroPlayerHookedIn:
		if (frame>3) frame=3;
	break;
	
	case sprIntroPlayerHookedAway:
		if (frame>2) frame=2;
	break;
	
	case sprIntroPlayerPunched:
		if (frame>10) frame=10;
	break;
	
}