if (active)
{
//add to enemy array
if (!added)
{
	ds_list_add(objPlayer.targetList, self);
	added = true;
}

//index in enemy array
index = ds_list_find_index(objPlayer.targetList, self);

if (place_meeting(x,y+zFloor,objPlayerHomingCone)) inPlayerRange = 2;
else if (place_meeting(x,y+zFloor,objPlayerHomingRadius)) inPlayerRange = 1;
else inPlayerRange = 0;

//check distance to player
distanceToPlayer = (sqrt(power(abs(x-objPlayer.x),2) + power(abs((y+zFloor)-objPlayer.y),2)));

//animation
targetAngle += 15;
}

//HP

if (hp != pointer_null && hp<=0)
{
	active = false;
	objPlayer.maxSpeedNormal += 0.5;
}

//reset
if (objPlayer.playerState = PlayerState.Dead)
{
	active = true;
	hp = hpInitial;
}

/*
if (objPlayer.playerState==PlayerState.HomeIn)
{
	objPlayer.boosting=false;
	if (place_meeting(x,y,objPlayer))
	{
		if (active)
		{
			objPlayer.movementLock=true;
			objPlayer.grav = objPlayer.gravNormal;
			objPlayer.xspd=0;
			objPlayer.yspd=0;
			objPlayer.zspd=-3;
			active=false;
		}
	}
	//return player to normal state after peak of launch
	if (objPlayer.zspd>-4 && !active)
	{
		objPlayer.movementLock=false;
		active=true;
		objPlayer.playerState=PlayerState.Normal;
	}
} */


