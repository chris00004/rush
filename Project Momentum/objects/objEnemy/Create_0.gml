enum EnemyState {
	Normal,
	Dead,
	Attacking,
	GottenHit,
	OnTheGround,
	JuggleState
}

xspd=0;
yspd=0;
zspd=0;
z=-84;
zHeight = -sprite_height/2;
zFloor = 0;
inPlayerRange = 0;
distanceToPlayer = 0;
added = false;
addedClosest = false;
index = 0;

//animation
targetAngle=0;
targetFrame=0;

//target location
targetDisplacement = 24;
targetType = 1; // 0 - single target location // 1 - can target left or right


hp = 999;
active = true;
weak = false;
isEnemy=true;