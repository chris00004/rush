///ENUM PlayerState
enum PlayerState
{
	Normal,
	Dead,
	HomeIn,
	AttachToTarget,
	Sliding,
	Stomping,
	QuickStep,
	BasicAttack,
	EnemyBounce,
	DialogueNPC,
	Launcher, //launches enemy up in the air (low damage, allows juggling)
	SlamDown, //slams enemy down to the ground (high damage, high enemy recovery time)
	Chuck, //chucks enemy in the direction you attached to it (low damage, high damage to another enemy if it collides)
	Grab, //
	BackOff,	
	Parry,
	ActionDashPanel,
	ActionDashRamp,
	ActionSpringBoard,
	ActionHookLine,
	StageEnd,
}

enum PlayerAnimationDirection
{
	Up,
	Down,
	Left,
	Right
}


enum AttackType
{
	Punch0,	
	Punch1,
	Kick,	
	Launcher, //launches enemy up in the air (low damage, allows juggling)
	SlamDown, //slams enemy down to the ground (high damage, high enemy recovery time)
	Chuck, //chucks enemy in the direction you attached to it (low damage, high damage to another enemy if it collides)
	Grab, //
	BackOff,	//
	
}


///----[ INPUTS ]---------------------------------------------------------------------------------------------

scrLoadInputsPlayer();

///----[ STATES ]-------------------------------------------------------------------------------------------------------------------------------------------

// Calculate current speed
currentSpeed = sqrt(sqr(xspd) + sqr(yspd));

//reset max speed if walking on ground		
if (playerState == PlayerState.Normal && grounded)
{
	landed=true;
}

//check if player has landed to give some frames before momentum loss
if (landed && playerState == PlayerState.Normal)
{
	alarmMomentumLoss--;
	if (alarmMomentumLoss<0)
	{
		momentumLoss=true;
		alarmMomentumLoss = 15;
	}
}

//lose momentum
if (momentumLoss)
{
	if (maxSpeedNormal!=2.5)
	{
		maxSpeedNormal -= 0.12;
		if (maxSpeedNormal-0.12 <= 2.5) 
		{
			maxSpeedNormal = 2.5;
			momentumLoss = false;
			
		}
	}
}



//NORMAL STATE
if (playerState == PlayerState.Normal)
{	
	hspeed = 0;
	vspeed = 0;
	grav = gravNormal;
	animYPosActual = false;
	
	//set state to stomping
	if (!grounded)
	{
		if (inputStomp)
		{
			playerState = PlayerState.Stomping;
			xspd = 0;
			yspd=0;
			movementLock=true;
		}
	}
	
	//set state to sliding
	if (grounded)
	{
		if (inputStomp)
		{
			playerState = PlayerState.Sliding;
			movementLock=true;
		}	
	}
	
	//falling from hookLine
	if (hookLineFalling && grounded)
	{
		movementLock = false;
		hookLineFalling = false;
	}
	
	
	//set state to home in
		scrTargetObject();
}

//SLIDING STATE
if (playerState == PlayerState.Sliding)
{
	momentumLoss=false;
	alarmMomentumLoss = 1;
	alarmSliding--;
	if (alarmSliding<0) 
	{
		alarmSliding = 45;
		playerState = PlayerState.Normal;
		movementLock=false;
	}
}

//DEAD STATE
if (playerState == PlayerState.Dead)
{
	hspeed=0;
	vspeed=0;
	xspd = 0;
	yspd = 0;
	alarmRespawn--;
	if (alarmRespawn<0)
	{
		x = lastPosX;
		y = lastPosY;
		z = lastPosZ;
		alarmRespawn=40;
		inputLock=false;
		movementLock = false;
		playerState = PlayerState.Normal;
		//boostMeter = boostMeterBase;
	}
}

//STOMPING STATE
if (playerState == PlayerState.Stomping)
{
	xspd=0;
	yspd=0;
	zspd+=3.5;
	if (grounded) 
	{
		playerState = PlayerState.Normal;
		movementLock=false;
	}
}

//HOME IN STATE
if (playerState == PlayerState.HomeIn)
{
	landed = false;
	momentumLoss=false;
	alarmMomentumLoss=15;
	alarmAttachToTarget=30;
	inputLock=false;
	movementLock=true;
	
	tX = closestTarget.x;
	tY = closestTarget.y;
	tZ = closestTarget.z;
	
	if (maxSpeedNormal<5)
	{
		if (maxSpeedNormal+0.15>=5)
		{
			maxSpeedNormal=5
		}
		else maxSpeedNormal += 0.15;
	}
	//increase players max speed
	maxSpeedNormal += grappleSpd;
	
	//grapple speed
	grappleSpd = 0.0175;
	
	if (closestTarget.targetType==1)
	{
		if (x<=tX) scrMoveTowardsPoint3D(tX-closestTarget.targetDisplacement,tY,tZ,maxSpeedNormal);
		else scrMoveTowardsPoint3D(tX+closestTarget.targetDisplacement,tY,tZ,maxSpeedNormal);
	}
	else if (closestTarget.targetType==0)
	{
		 scrMoveTowardsPoint3D(tX,tY,tZ,maxSpeedNormal);
	}
	
	if (place_meeting(x,y,closestTarget)) && (z>closestTarget.z-2 && z<closestTarget.z+2) 
	{
		playerState = PlayerState.AttachToTarget;
	}
	
	//jump out of grapple
	if (inputJump)
	{
		zspd = -5;
		movementLock = false;
		playerState = PlayerState.Normal;
		//xspd=xspdReturned;
		//yspd=yspdReturned;
		//xspdReturned=0;
		//yspdReturned=0;
	}
}



//ATTACH TO TARGET STATE
if (playerState == PlayerState.AttachToTarget)
{
	z=closestTarget.z;
	hspeed = 0;
	vspeed = 0;
	if (closestTarget.targetType==1)
	{
		if (x<=tX) 
		{
			x = tX-closestTarget.targetDisplacement;
			attachSide = 0;
		}
		else 
		{
			x = tX+closestTarget.targetDisplacement;
			attachSide = 1;
		}
	}
	else if (closestTarget.targetType==0)
	{
		x = tX
	}
	
	y = tY;
	
	//decrease time player stays attached
	alarmAttachToTarget--;
	
	//ENEMY RELATED
	if (closestTarget.isEnemy)
	{
		//switch to enemy bounce state
		if (closestTarget.weak && alarmAttachToTarget<26)
		{
			playerState = PlayerState.EnemyBounce;
			closestTarget.hp = 0;
			zspd = -5;
			//grav = gravNormal;
		}

		//set state to Punching (if attached to enemy)
		else if (inputAction && alarmAttachToTarget<26 && closestTarget.hp!=pointer_null)
		{
			alarmAttachToTarget=30;
			alarmAttack=0;
			playerState = PlayerState.BasicAttack;
		}
	
		//set state to BackOff
		if (attachSide == 0 && inputActionLeft) || (attachSide == 1 && inputActionRight)
		{
			alarmAttachToTarget=30;
			zspd = 2;
			playerState = PlayerState.BackOff;
		}
	
		//set state to Parry (if attached to enemy)
		if ((attachSide == 0 && inputActionRight) || (attachSide == 1 && inputActionLeft)) && (closestTarget.hp!=pointer_null)
		{
			alarmAttachToTarget=30;
			playerState = PlayerState.Parry;
		}
		
			//set state to stomping
		if (!grounded && !closestTarget.weak)
		{
			if (inputStomp)
			{
				playerState = PlayerState.Stomping;
				xspd = 0;
				yspd=0;
				movementLock=true;
			}
		}
	}
	
	//OTHER OBJECT REALTED
	else
	{
		if (closestTarget.objectType == ObjectType.TriMachine)
		{
			if (alarmAttachToTarget<26)
			{
				playerState = PlayerState.EnemyBounce;
				closestTarget.hp = 0;
				zspd = -5;
			}
		}
	}
	
	//return to normal state
	if (alarmAttachToTarget<0)
	{
		alarmAttachToTarget = 30;
		movementLock = false;
		playerState = PlayerState.Normal;
	}
}



//QUICK STEP STATE
if (playerState = PlayerState.QuickStep)
{
	
	movementLock=true;
	if (quickStepDirection==1)
	{
		xspd = 6;
		if (x>=quickStepStartingX+32)
		{
			xspd=0;
			x = quickStepStartingX+32;
			movementLock = false;
			playerState = PlayerState.Normal;
		}
	}
	else
	{
		xspd = -6;
		if (x<=quickStepStartingX-32)
		{
			xspd=0;
			x = quickStepStartingX-32;
			movementLock = false;
			playerState = PlayerState.Normal;
		}
	}
}

//PUNCHING STATE
if (playerState == PlayerState.BasicAttack)
{
	if (alarmAttack<34)
	{
		//attack 
		if (inputAction)
		{
			alarmAttack=40;
			attackType++;
			if (closestTarget.hp != pointer_null) closestTarget.hp-=damage;
			
			//reset attack types
			if (attackType>4) attackType = 0;
			
			//decide attack type
			switch(attackType)
			{
				case 0:
				attackState = AttackType.Punch0;
				break;
				case 1:
				attackState = AttackType.Punch1;
				break;
				case 2:
				attackState = AttackType.Punch0;
				break;
				case 3:
				attackState = AttackType.Punch1;
				break;
				case 4:
				attackState = AttackType.Kick;
				break;
			}
		}
	}
	
	if (closestTarget.hp<1)
	{
		movementLock = false;
		playerState = PlayerState.Normal;
	}
	
	//set state to stomping
	if (!grounded)
	{
		if (inputStomp)
		{
			playerState = PlayerState.Stomping;
			xspd = 0;
			yspd=0;
			movementLock=true;
		}
	}
	
	//set state to BackOff
	if (attachSide == 0 && inputActionLeft) || (attachSide == 1 && inputActionRight)
	{
		alarmAttachToTarget=30;
		zspd = 2;
		playerState = PlayerState.BackOff;
	}
	
	//end attack state, return to Normal state
	alarmAttack--;
	if (alarmAttack<0)
	{
		attackType=0;
		alarmAttack = 40;
		movementLock = false;
		playerState = PlayerState.Normal;
	}
}

//ENEMY BOUNCE STATE
if (playerState == PlayerState.EnemyBounce)
{
	inputLock = false;
	movementLock = false;
	acceleration = 0.2;
	maxSpeedNormal = 2;
	grav = gravNormal;

	//allow lock on to target
		scrTargetObject();
	
	//set state to stomping
	if (!grounded)
	{
		if (inputStomp)
		{
			playerState = PlayerState.Stomping;
			xspd = 0;
			yspd=0;
			movementLock=true;
		}
	}
	

	//set state to normal
	if (grounded)
	{
		playerState = PlayerState.Normal;
	}
}

//BACKOFF STATE
if (playerState == PlayerState.BackOff)
{
	movementLock=true;
	grav = gravNormal;
	if (attachSide == 0)
	{
		xspd = -5;
	}
	else
	{
		xspd = 5;
	}
	//end backoff state, return to normal state
	if (grounded) 
	{
		playerState = PlayerState.Normal;
		movementLock=false;
	}
}

//DIALOGUE NPC STATE
if (playerState == PlayerState.DialogueNPC)
{
	inputLock = true;
	if (!objControllerNPCDiaglogue.active)
	{
		playerState = PlayerState.Normal;
		inputLock = false;
	}
}

//STAGE END STATE
if (playerState == PlayerState.StageEnd)
{
	inputLock = true;
	movementLock = true;
	alarmStageEnd--;
	
	if (alarmStageEnd<0)
	{
		//fade handled in camera object
		if (alarmStageEnd<-120)
		{
			room_goto(rmTitleScreen);
			audio_stop_sound(sndTestStageMusic);
		}
	}
}

//ACTION DASH PANEL
if (playerState == PlayerState.ActionDashPanel)
{
	movementLock=true;
	maxSpeedNormal = 5;
	xspd = xspdReturned;
	yspd = yspdReturned;
	alarmDashPanel--;
	if (alarmDashPanel<0 || !grounded)
	{
		alarmDashPanel=10;
		playerState = PlayerState.Normal;
		movementLock= false;
	}
}

//ACTION DASH RAMP
if (playerState == PlayerState.ActionDashRamp)
{
	movementLock=true;
	maxSpeedNormal = abs(xspdReturned);
	xspd = xspdReturned;
	yspd = yspdReturned;
	
	if (zspd>=0.1) dashRampActive = true;

	//set state to stomping
	if (!grounded)
	{
		if (inputStomp)
		{
			playerState = PlayerState.Stomping;
			xspd = 0;
			yspd=0;
			movementLock=true;
		}
	}

	//set state back to normal
	if (grounded && !place_meeting(x,y,objDashRampHorizontal))
	{
		playerState = PlayerState.Normal;
		movementLock= false;
	}
}
else
{
	dashRampActive = true;
}

//ACTION HOOK LINE
if (playerState == PlayerState.ActionHookLine)
{
	hookLineFalling = true;
	movementLock = true;
	if (inputJump)
	{
		movementLock = false;
		playerState = PlayerState.Normal;
	}
}

///----[ MOVEMENT ]-------------------------------------------------------------------------------------------------------------------------------------

for (var i=0; i<ds_list_size(elevatedPlatformList); i++)
{
	if (place_meeting(x,y+12,elevatedPlatformList[|i])) 
	&& (place_meeting(x,y+6,elevatedPlatformList[|i]))
	&& (z>elevatedPlatformList[|i].z)
	{
		underPlatform = true;
	}
	else underPlatform = false;
	
	if (place_meeting(x,y+12,elevatedPlatformList[|i])) 
	&& (place_meeting(x,y+6,elevatedPlatformList[|i]))
	&& (z<=elevatedPlatformList[|i].z)
	{
		zFloor=elevatedPlatformList[|i].z;
		elevatedPlatformList[|i].active = true;
	}
	else
	{
		zFloor=0;
		elevatedPlatformList[|i].active = false;
	}
	
}

//ABOVE A PIT
if (place_meeting(x,y+12,objFloor)) && (place_meeting(x,y+6,objFloor)) abovePit = false;
else abovePit = true;

if (abovePit && z==zFloor && playerState != PlayerState.HomeIn 
&& playerState!=PlayerState.AttachToTarget && playerState!=PlayerState.ActionSpringBoard) playerState = PlayerState.Dead;

//GROUNDED
if (z == zFloor) grounded = true;
else grounded = false;

//ACTIVATE KEYBOARD CONTROLS
if (keyboard_check_pressed(vk_anykey)) gamepadActive = false;

//ACTIVATE GAMEPAD CONTROLS
for (var i = gp_face1; i < gp_axisrv; i++ ) 
{
    if (gamepad_button_check_pressed(0, i)) gamepadActive = true;
}

if (gamepad_axis_value(0, gp_axislh)>deadZone || gamepad_axis_value(0, gp_axislh)<-deadZone 
|| gamepad_axis_value(0, gp_axislv)<-deadZone || gamepad_axis_value(0, gp_axislv)>deadZone) gamepadActive = true;




//HANDLE MOVING
if (!inputLock && !movementLock  && !charLock && playerState != PlayerState.Dead)
{
	//KEYBOARD MOVEMENT
	if (!gamepadActive)
	{
		if (inputRight) movementDirection = 0;
		if (inputLeft) movementDirection = 180;
		if (inputUp) movementDirection = 90;
		if (inputDown) movementDirection = 270;
		if (inputRight && inputUp) movementDirection = 45;
		if (inputLeft && inputUp) movementDirection = 135;
		if (inputRight && inputDown) movementDirection = 315;
		if (inputLeft && inputDown) movementDirection = 225;
	}
	
	//GAMEPAD MOVEMENT
	else if (gamepadActive)
	{
		joystickAngle = point_direction(0,0,gamepad_axis_value(0,gp_axislh),gamepad_axis_value(0,gp_axislv))
		movementDirection = joystickAngle;
	}
	
	//calculate speeds with regard to direction 
	if (inputRight || inputLeft || inputUp || inputDown)
	{
		//cos and sin of acceleration
		angleAccelerationX = acceleration * cos(movementDirection*(pi/180));
		angleAccelerationY = -(acceleration * sin(movementDirection*(pi/180)));
		
		//apply acceleration to player speed
		xspd+=angleAccelerationX;
		yspd+=angleAccelerationY;
	
	/*
		// Calculate current speed
		currentSpeed = sqrt(sqr(xspd) + sqr(yspd));*/

		//CAP SPEED
		if (currentSpeed > maxSpeedNormal) 
		{
			//scale the speed 
			speedScale = maxSpeedNormal / currentSpeed;
			xspd *= speedScale;
			yspd *= speedScale;
		}
	}
}

//DECELERATE X
if ((!inputRight && !inputLeft) || (inputRight && inputLeft) || movementLock) && (playerState!=PlayerState.Sliding)
{
	if (xspd>0)
	{
		if (xspd-acceleration<0)  xspd=0;
		else if (xspd>0) 
		{
			xspd -=decceleration;
		}
	}
	else
	{
		if (xspd+acceleration>0) xspd = 0;
		else if (xspd<0) 
		{
			xspd +=decceleration;
		}
	}
}

//DECELERATE Y
if ((!inputUp && !inputDown) || (inputUp && inputDown) || movementLock) && (playerState!=PlayerState.Sliding)
{
	if (yspd>0)
	{
		if (yspd-acceleration<0)  yspd=0;
		else if (yspd>0) 
		{
			yspd -=decceleration;
		}
	}
	else
	{
		if (yspd+acceleration>0) yspd = 0;
		else if (yspd<0) 
		{
			yspd +=decceleration;
		}
	}
}

//ACCEL / DECCEL VALUES

//increases accelerartion as you get faster
acceleration = maxSpeedNormal/8;

//increases decceleration slowly as you get faster
decceleration = 0.2 + (maxSpeedNormal/200);

//JUMPING
if (inputJump && grounded && !jumpLock && !charLock && !inputLock && playerState != PlayerState.Dead)
{
	zspd = jumpSpd;
}

//GRAVITY
if (z !=zFloor)
{
	zspd+=grav;
}

//GROUND PLAYER
if (z+zspd>zFloor)
{
	zspd=0;
	z = zFloor;
}

//Z MOVEMENT
z+=zspd;

///----[ BOOSTING ]----------------------------------------------------------------------------------------------
/*
if (!boosting) 
{
	boostMeter+=0.5;
}
if (boostMeter>boostMeterBase) boostMeter=boostMeterBase;
if (boostRecovery && boostMeter>100) boostRecovery=false;

if (inputBoost && grounded && !boostRecovery && (xspd!=0 || yspd!=0) && (playerState == PlayerState.Normal || playerState == PlayerState.ActionDashPanel)) boosting = true;
else if ((!inputBoost || (xspd==0 && yspd==0))) boosting = false;

if (boosting)
{
	//decrease boost meter
	if (xspd!=0 || yspd!=0) boostMeter--;
	if (boostMeter<0) 
	{
		boostMeter=0;
		boostRecovery=true;
		boosting=false;
	}
	if (playerState !=PlayerState.Normal && playerState !=PlayerState.ActionDashPanel) boosting = false;
	//set max speed
	if (maxSpeedNormal!=boostSpd)
	{
		if (grounded) maxSpeedNormal-=acceleration/1.5;
		else maxSpeedNormal-=acceleration/3;
	if (maxSpeedNormal<boostSpd) maxSpeedNormal = boostSpd;
	}
}

//reset back to normal speed
if ((!boosting) && maxSpeedNormal!=runSpd)
{
	if (grounded) maxSpeedNormal-=acceleration/1.5;
	else maxSpeedNormal-=acceleration/3;
	
	if (maxSpeedNormal<=runSpd) maxSpeedNormal = runSpd;
}
*/

///----[ WALL COLLISION ]--------------------------------------------------------------------------------------------

// WALL COLLISION X
if (place_meeting(x+xspd+movingPlatSpdX,y,objWall))
{
	while (!place_meeting(x+sign(xspd+movingPlatSpdX),y,objWall))
	{
		x = x + sign(xspd+movingPlatSpdX);
	}
	xspd=0;
	movingPlatSpdX=0;
}

x+=xspd+movingPlatSpdX;

// WALL COLLISION Y
if (place_meeting(x,y+yspd+movingPlatSpdY,objWall))
{
	while (!place_meeting(x,y+sign(yspd+movingPlatSpdY),objWall))
	{
		y = y + sign(yspd+movingPlatSpdY);
	}
	yspd=0;
	movingPlatSpdY=0;
}

y+=yspd+movingPlatSpdY;

///----[ STAGE OBJECTS ]----------------------------------------------------------------------------------

 if (playerState != PlayerState.Dead)
 {
//handle dashpanel
if (place_meeting(x,y,objDashPanel) && grounded) playerState = PlayerState.ActionDashPanel;
	
//handle dashramp
if (place_meeting(x,y,objDashRampHorizontal) && z>=-4) playerState = PlayerState.ActionDashRamp;

//handle springBoard
if (place_meeting(x,y,objSpringBoard) && z>=-6) playerState = PlayerState.ActionSpringBoard;

//handle hookLine
if (place_meeting(x,y,objHook)) && (playerState == PlayerState.AttachToTarget) playerState = PlayerState.ActionHookLine;

//handle goal sign
if (place_meeting(x,y,objGoalSign)) playerState = PlayerState.StageEnd;

//handle dialogue with NPC
if (instance_exists(objNPC))
{
if (objNPC.inPlayerRange && inputActionSecondary && playerState != PlayerState.DialogueNPC) 
{
	objControllerNPCDiaglogue.active = true;
	playerState = PlayerState.DialogueNPC;
}
}
}

///----[ ANIMATION ]--------------------------------------------------------------------------------------

alarmAnimSpeedIdle--;
if (alarmAnimSpeedIdle<0) 
{
	animFrameIdle++;
	alarmAnimSpeedIdle = 6;
}

if (inputRight || inputLeft || inputDown || inputUp) alarmAnimSpeedRun--;
else animFrameRun = 0;
if (alarmAnimSpeedRun<0) 
{
	animFrameRun++;
	if (currentSpeed<3)  alarmAnimSpeedRun = 4;
	else alarmAnimSpeedRun = 4-(currentSpeed/10);
}

//if spd>3
//animspd = 4-(spd/12)


/*
//check last direction pressed
if (keyRight) lastDirPressed = "R";
if (keyLeft) lastDirPressed = "L";
if (keyUp) lastDirPressed = "UP";
if (keyDown) lastDirPressed = "DOWN";

if (xspd>0 && keyRight) image_xscale = 1;
else if (xspd<0 && keyLeft) image_xscale = -1;

if (state=="normal")
{
if (keyRight || keyLeft) sprite_index = sprPlayerRunR;
if (keyUp) sprite_index = sprPlayerRunB;
if (keyDown) sprite_index = sprPlayerRunF;
if ((keyRight && keyUp) || (keyLeft && keyUp)) sprite_index = sprPlayerRunBR;
if ((keyRight && keyDown) || (keyLeft && keyDown)) sprite_index = sprPlayerRunFR;
if (xspd==0 && yspd==0) 
{
	if (sprite_index!=sprPlayerIdleB && sprite_index!=sprPlayerIdleF && sprite_index!=sprPlayerIdleR) image_index =0;
	if (lastDirPressed == "DOWN") sprite_index=sprPlayerIdleF;
	else if (lastDirPressed == "UP") sprite_index=sprPlayerIdleB;
	else if (lastDirPressed == "L" || lastDirPressed == "R") sprite_index=sprPlayerIdleR;
	if (sprite_index==sprPlayerIdleB || sprite_index==sprPlayerIdleF || sprite_index==sprPlayerIdleR) && (image_index>1) image_index =2;
}
}
*/