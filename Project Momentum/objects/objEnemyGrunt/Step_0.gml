
if (active)
{
	
	frameAlarm--;
	if (frameAlarm < 0) {
	frame++;
	frameAlarm = 4;
	}
	
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


//ground collision
if (z>zFloor-24)
{
	z=zFloor-24;
	zspd=0;
	grounded=true;
}

//check if walls are in the way
if (place_meeting(x+xspd+1,y,objEnemyWall) || place_meeting(x+xspd-1,y,objEnemyWall)) wallToSide=true;
else wallToSide=false;

if (place_meeting(x+xspd+1,y,objEnemyWall)) wallToRight=true;
else wallToRight=false;

if (place_meeting(x+xspd-1,y,objEnemyWall)) wallToLeft=true;
else wallToLeft=false;

//slide launching
if (grounded && place_meeting(x,y,objPlayer) && objPlayer.playerState == PlayerState.Sliding)
{
	enemyState = EnemyState.SlideLaunched;
	xspd=objPlayer.xspd*1.15;
	yspd=objPlayer.yspd*1.15;
	xDecceleration = xspd/25;
	yDecceleration = yspd/25;
	zspd=-objPlayer.currentSpeed/2.75;
}

//STATES
switch(enemyState)
{
	
	case EnemyState.Normal:
	//if the enemy is active and the player isn't attached to the enemy/attacking the enemy
	if (isActive && 
	!(
	(objPlayer.playerState == PlayerState.AttachToTarget || objPlayer.playerState == PlayerState.HomeIn || objPlayer.playerState == PlayerState.BasicAttack) && objPlayer.closestTarget == self)) {
		//if the change direction timer is counted down
		if (alarmChangeDirection <= 0) {
			randomize();
			var randomVar = random_range(0, 100);
			if (randomVar >= 0 && randomVar < 25) {
				xspd = 2;
				yspd = 0;
			}
			else if (randomVar >= 25 && randomVar < 50) {
				xspd = 0;
				yspd = 2;
			}
			else if (randomVar >= 50 && randomVar < 75) {
				xspd = 0;
				yspd = -2;
			}
			else {
				xspd = -2;
				yspd = 0;
			}
			
			
			alarmChangeDirection = random(100);
		}
		
		alarmChangeDirection--;
		
		if (alarmChooseAction <= 0 && active) {
			var instanceBullet = instance_create_layer(self.x, self.y, "projectileLayer", objBullet);
			
			alarmChooseAction = 150;
		}
		
		alarmChooseAction--;
		
		
		if (distance_to_object(objPlayer) > 1000) {
		isActive = false;	
		}
	}
	else {
		xspd = 0;
		yspd = 0;
		if (distance_to_object(objPlayer) < 1000) {
		isActive = true;	
		}	
	}
	
	
	
	break;
	
	//SLAM STRIKE STATE
	case EnemyState.SlamStrike:
	speed = 0;
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
		//rebound off enemies
		for (var i = 0; i < instance_number(objEnemy); i++) {
		var currentEnemy = instance_find(objEnemy, i); 
		if (place_meeting(x, y, currentEnemy) && currentEnemy.reboundable) {
			if (currentEnemy.isArmored) {
			currentEnemy.armorHealth -= objPlayer.damage;
			reboundable = false;
			
			}
			else if (grounded) {
				currentEnemy.hp -= objPlayer.damage;
				reboundable = false;
				currentEnemy.xspd = self.xspd * 0.5;
				currentEnemy.yspd = self.yspd * 0.5;
				self.xspd*= -0.5;
				self.yspd*=-0.5;
				self.xDecceleration*= -1;
				self.yDecceleration*= -1;
				currentEnemy.xDecceleration = currentEnemy.xspd/150;
				currentEnemy.yDecceleration = currentEnemy.yspd/150;
				}
			}
		}
		
		//apply decceleration
		if (grounded)
		{
		xspd-=xDecceleration;
		yspd-=yDecceleration;
		}
		//stop moving if speed close to 0
		if (abs(xspd) < abs(xDecceleration)+0.2) xspd = 0;
		if (abs(yspd) < abs(yDecceleration)+0.2) yspd = 0;
	
		//reset back to normal state
		if (xspd==0 && yspd==0) 
		{
			enemyState = EnemyState.Normal;
			kickedMovementApplied=false;
		}
	}
	break;
	
	//SHOVED STATE
	case EnemyState.Shoved:
	speed = 0;
	if (!kickedMovementApplied)
	{
		xDecceleration = xspd/40;
		kickedMovementApplied=true;
	}
	else
	{
		//apply decceleration
		xspd-=xDecceleration;
		
		//stop moving if speed close to 0
		if (abs(xspd) < 0.1+xDecceleration) 
		{
			xspd = 0;
			xDecceleration=0;
			enemyState = EnemyState.Normal;
			kickedMovementApplied=false;
		}
	}
	break;
	
	//SPIKED
	case EnemyState.Spiked:
	speed = 0;
	if (!kickedMovementApplied)
	{
		xDecceleration = xspd/40;
		kickedMovementApplied=true;
	}
	else
	{
		//apply decceleration
		xspd-=xDecceleration;
		
		//stop moving if speed close to 0
		if (abs(xspd) < 0.1+xDecceleration) 
		{
			xspd = 0;
			xDecceleration=0;
			enemyState = EnemyState.Normal;
			kickedMovementApplied=false;
		}
		if (grounded)
		{
			xspd=0;
			xDecceleration=0;
			zspd=0;
			yspd=0;
			kickedMovementApplied=false;
			enemyState = EnemyState.Normal;
		}
	}
	break;
	
	//JUGGLING STATE
	case EnemyState.Launched:
	speed = 0;
		if (zspd>=0) 
		{
			grav=0.04;
		}
		if (grounded) 
		{
		enemyState = EnemyState.Normal;	
		grav=0.12;
		}
		break;
	
	//SLIDE LAUNCHING STATE
	case EnemyState.SlideLaunched:
		
		//apply decceleration
		if (grounded)
		{
		xspd-=xDecceleration;
		yspd-=yDecceleration;
		}
		//stop moving if speed close to 0
		if (abs(xspd) < abs(xDecceleration)+0.2) xspd = 0;
		if (abs(yspd) < abs(yDecceleration)+0.2) yspd = 0;

	
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
    if (place_meeting(x + xspd, y, objEnemyWall))
    {
        while (!place_meeting(x + sign(xspd), y, objEnemyWall))
        {
            x += sign(xspd);
        }
        if (enemyState == EnemyState.SlamStrike
		|| enemyState == EnemyState.Spiked)
        {
            xspd *= -1;
            xDecceleration *= -1;
        }
        else if (enemyState == EnemyState.Shoved)
		{
			xspd = 0;
			xDecceleration=0;
		}
		else {
			xspd *= -1;
		}
    }

    // Then handle Y collision
    if (place_meeting(x, y + yspd, objEnemyWall))
    {
        while (!place_meeting(x, y + sign(yspd), objEnemyWall))
        {
            y += sign(yspd);
        }
        if (enemyState == EnemyState.SlamStrike
		|| enemyState == EnemyState.Spiked)
        {
            yspd *= -1;
            yDecceleration *= -1;
        }
        else if (enemyState == EnemyState.Shoved) {
			yspd = 0; }
			else {
			yspd *= -1;	
			}
    }
} 
else 
{
    // Handle Y collision first
    if (place_meeting(x, y + yspd, objEnemyWall))
    {
        while (!place_meeting(x, y + sign(yspd), objEnemyWall))
        {
            y += sign(yspd);
        }
        if (enemyState == EnemyState.SlamStrike
		|| enemyState == EnemyState.Spiked)
        {
            yspd *= -1;
            yDecceleration *= -1;
        }
        else if (enemyState == EnemyState.Shoved) {
			yspd = 0; }
			else {
			yspd *= -1;	
			}
    }

    // Then handle X collision
    if (place_meeting(x + xspd, y, objEnemyWall))
    {
        while (!place_meeting(x + sign(xspd), y, objEnemyWall))
        {
            x += sign(xspd);
        }
        if (enemyState == EnemyState.SlamStrike
		|| enemyState == EnemyState.Spiked)
        {
            xspd *= -1;
            xDecceleration *= -1;
        }
        else if (enemyState == EnemyState.Shoved)
		{
			xspd = 0;
			xDecceleration=0;
		}
		else {
			xspd *= -1;
		}
    }
}


//reset
if (objPlayer.playerState = PlayerState.Dead)
{
	active = true;
	hp = hpInitial;
}


if (xspd>0) xscale=1;
if (xspd<0) xscale=-1;


