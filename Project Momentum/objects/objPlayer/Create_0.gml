//audio_play_sound(sndTrailerMusic,0,false);
instance_create_layer(x,y,layer_get_id("player"),objPlayerHomingRadius);
instance_create_layer(x,y,layer_get_id("player"),objPlayerHomingCone);
instance_create_layer(x,y,layer_get_id("player"),objPlayerSlideRadius);


///ENUM PlayerState
enum PlayerState
{
	Normal,
	Dead,
	hitByEnemy,
	HomeIn,
	AttachToTarget,
	Sliding,
	Stomping,
	BasicAttack,
	AttackFinish,
	EnemyBounce,
	DialogueNPC,
	Launcher, //launches enemy up in the air (low damage, allows juggling)
	SlamDown, //slams enemy down to the ground (high damage, high enemy recovery time)
	Chuck, //chucks enemy in the direction you attached to it (low damage, high damage to another enemy if it collides)
	Grab, //
	ActionRailGrind,
	ActionDashPanel,
	ActionDashRamp,
	ActionSpringBoard,
	ActionHookLine,
	StageEnd,
	GodMode
}

enum PlayerAnimationDirection
{
	Up,
	Down,
	Left,
	Right
}


enum AttackState
{
	Idle,
	Punch,
	PunchFinisher,	
	Launcher, //launches enemy up in the air (low damage, allows juggling)
	SlamStrike, //slams enemy down to the ground (high damage, high enemy recovery time)
	Chuck, //chucks enemy in the direction you attached to it (low damage, high damage to another enemy if it collides)
	Grab, //Nothing rn
	comboExtender, //extends your combo and resets your punch counter
	suplexSlam, //suplexes the enemy behind you, large cost but big damage 
	BackOff,
	
}

//audio_play_sound(sndTestStageMusic, 1, true);

xspd=0;
yspd=0;
zspd=0;

//speed values that grab from other objects
xspdReturned=0;
yspdReturned=0;
zspdReturned=0;

z=0;
zHeight = -sprite_height/2;
zFloor = 0;
zFloorNext = 0;
zTemp = 0;

jumpSpd = -4; //-4
grav=0.25;
gravNormal = 0.25;

//momentum
landed = true;
momentumLoss = false;
alarmMomentumLoss = 10;

//sliding
alarmSliding = 120;
fenceSliding = false;

//locks
movementLock=false;
alarmMovementLock=14;
jumpLock=false;
inputLock=false;
charLock=false;
armorLockedAnimation = false;


//Enums
playerState = 0;
attackState = 0;

acceleration = 0.4;
accelerationBase = 0.4;
decceleration = 0.2; //0.12
deccelerationBase = 0.2;
maxSpeedNormal = 2.5;
runSpd = 2.5;
image_index=2;

//animation
animYPosActual = false;
alarmAnimSpeedIdle = 6;
alarmAnimSpeedRun = 4;
animFrameIdle=0;
animFrameRun=0;
animDirection=0;
dropShadowRails=0;


//dash panel
alarmDashPanel = 10;
speedDashPanel = 4;

//dash ramp
dashRampActive = true;

//grapple
pX=0;
pY=0;
targetObject=0;
grappleSpd = 0;
connectTarget=false;

//respawn
lastPosX = x;
lastPosY = y;
lastPosZ = -96;
alarmRespawn = 40;

//hit by enemy alarm
alarmInvuln = 100;

//floor and pits
abovePit = false;
grounded = true;

//targets
targetList = ds_list_create();
targetListClosest = ds_list_create();
elevatedPlatformList = ds_list_create();
underPlatform = false;
closestTargetDistance = 99999999;
closestTarget = pointer_null;
tX=0;
tY=0;
tZ=0;
alarmAttachToTarget = 30;
attachSide = 0;

//hookLine
hookLineFalling = false;

//combat
attackBuffer = -1;
punchAnim = 0;
alarmAttack = 12;
damage = 1;
hitStun = 1;
comboMultiplier = 0;
attackEnabled = false;
actionsEnabled = true;
heavyCharges = 0;
lightAttackCount = 0;
attackFinishType=-1;
heavyChargeCounter = 0;

//health
hp = 5;

//moving plat
movingPlatLock=false;
movingPlatSpdX = 0;
movingPlatSpdY = 0;

//switches
switchAttachSet = -1;

//gamepad
deadZone = 0.35;
gamepadActive = false;

//collectibles
tris = 0;

//stage end
alarmStageEnd = 200;
alpha = 0;

//new movement
angleAccelerationX = 0;
angleAccelerationY = 0;
joystickAngle = 0;
movementDirection = 0;
currentSpeed = 0;
speedScale = 0;

//NPC
characterNPC = 0;

//god mode
godMode=-1;






