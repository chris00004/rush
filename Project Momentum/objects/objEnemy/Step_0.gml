
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

if (hp != pointer_null && hp<=0 && active)
{

	active = false;
}

//movement
x+=xspd;
y+=yspd;
z+=zspd;
if (z!=zFloor-24) 
{
	grounded=false;
	zspd+=grav;
}


//collision
if (z>zFloor-24)
{
	z=zFloor-24;
	zspd=0;
	grounded=true;
}

if (place_meeting(x+xspd+1,y,objWall) || place_meeting(x+xspd-1,y,objWall)) wallToSide=true;
else wallToSide=false;

if (place_meeting(x+xspd+1,y,objWall)) wallToRight=true;
else wallToRight=false;
if (place_meeting(x+xspd-1,y,objWall)) wallToLeft=true;
else wallToLeft=false;

//slide launching
if (grounded && place_meeting(x,y,objPlayer) && objPlayer.playerState == PlayerState.Sliding)
{
	enemyState = EnemyState.SlideLaunched;
	xspd=objPlayer.xspd*1.1;
	yspd=objPlayer.yspd*1.1;
	xDecceleration = xspd/25;
	yDecceleration = yspd/25;
	zspd=-3;
}

//STATES
switch(enemyState)
{
	case EnemyState.Kicked:
	
	
	/*if (beenHit) {
	hp = hp - objPlayer.damage; 
	
	}*/
	
	//apply direction and speed from player reverse kick attack
	if (!kickedMovementApplied)
	{
		xspd = lengthdir_x(newSpeed, movementDirection);
		yspd = lengthdir_y(newSpeed, movementDirection);
		xDecceleration = xspd/75;
		yDecceleration = yspd/75;
		kickedMovementApplied=true;
	}
	else
	{
		//apply decceleration
		xspd-=xDecceleration;
		yspd-=yDecceleration;
		
		//stop moving if speed close to 0
		if (abs(xspd) < 0.1) xspd = 0;
		if (abs(yspd) < 0.1) yspd = 0;
	
		//reset back to normal state
		if (xspd==0 && yspd==0) 
		{
			enemyState = EnemyState.Normal;
			kickedMovementApplied=false;
		}
	}
	break;
	
	case EnemyState.Launched:
		if (zspd == 0) {
		enemyState = EnemyState.Normal;	
		}
		break;
	
	case EnemyState.SlideLaunched:
	
	//apply direction and speed from player reverse kick attack

if (grounded)
{
		//apply decceleration
		xspd-=xDecceleration;
		yspd-=yDecceleration;
}
		
		//stop moving if speed close to 0
		if (abs(xspd) < 0.1) xspd = 0;
		if (abs(yspd) < 0.1) yspd = 0;
	
		//reset back to normal state
		if (xspd==0 && yspd==0) 
		{
			enemyState = EnemyState.Normal;
		}
	
	break;
}


// PRIORITIZE THE GREATER SPEED COMPONENT TO PREVENT DOUBLE INVERSION

if (abs(xspd) > abs(yspd)) 
{
    // Handle X collision first
    if (place_meeting(x + xspd, y, objWall))
    {
        while (!place_meeting(x + sign(xspd), y, objWall))
        {
            x += sign(xspd);
        }
        if (enemyState == EnemyState.Kicked)
        {
            xspd *= -1;
            xDecceleration *= -1;
        }
        else xspd = 0;
    }

    // Then handle Y collision
    if (place_meeting(x, y + yspd, objWall))
    {
        while (!place_meeting(x, y + sign(yspd), objWall))
        {
            y += sign(yspd);
        }
        if (enemyState == EnemyState.Kicked)
        {
            yspd *= -1;
            yDecceleration *= -1;
        }
        else yspd = 0;
    }
} 
else 
{
    // Handle Y collision first
    if (place_meeting(x, y + yspd, objWall))
    {
        while (!place_meeting(x, y + sign(yspd), objWall))
        {
            y += sign(yspd);
        }
        if (enemyState == EnemyState.Kicked)
        {
            yspd *= -1;
            yDecceleration *= -1;
        }
        else yspd = 0;
    }

    // Then handle X collision
    if (place_meeting(x + xspd, y, objWall))
    {
        while (!place_meeting(x + sign(xspd), y, objWall))
        {
            x += sign(xspd);
        }
        if (enemyState == EnemyState.Kicked)
        {
            xspd *= -1;
            xDecceleration *= -1;
        }
        else xspd = 0;
    }
}


//reset
if (objPlayer.playerState = PlayerState.Dead)
{
	active = true;
	hp = hpInitial;
}





