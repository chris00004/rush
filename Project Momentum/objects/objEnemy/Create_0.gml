enum EnemyState {
	Normal,
	Hit,
	Dead,
	Slammed,
	Kicked,
	Launched,
}

event_inherited();
hpInitial = 5;
hp = 5;
weak = false;
isEnemy=true;
xspd=0;
yspd=0;
zspd=0;
newSpeed=0;
movementDirection=0;
xDecceleration = 0;
yDecceleration = 0;
grav = 0.12;
zFloor=16;
attackable=true;
enemyState=0;
kickedMovementApplied=false;
wallToLeft=false;
wallToRight=false;
wallToSide=false;
isArmored=true;
armorHealth=7;
armorTimer=300;
hitStunTimer = 0;
