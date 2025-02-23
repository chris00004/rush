


///----[ INPUTS ]---------------------------------------------------------------------------------------------

scrLoadInputsPlayer();

///----[ STATES ]-------------------------------------------------------------------------------------------------------------------------------------------

if (maxSpeedNormal > 11) maxSpeedNormal = 11;
//god mode
if (keyboard_check_pressed(ord("G"))) godMode *=-1;
if (godMode==1) playerState=PlayerState.GodMode;
if (playerState==PlayerState.GodMode && godMode == -1) playerState = PlayerState.Normal;

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
	//if spd greater than base spd, decrease to base spd
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

//GOD MODE
if (playerState == PlayerState.GodMode)
{
	movementLock=false;
	inputLock=false;
	grav = 0;
	zspd=0;
	maxSpeedNormal=8;
	if (keyboard_check(vk_space)) z-=2;
	if (keyboard_check(vk_shift)) z+=2;
	if (z>-12) z =-12;
}

//NORMAL STATE
if (playerState == PlayerState.Normal)
{	
	grav = gravNormal;
	//animYPosActual = false;
	
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
	
	//set state to punching
	if (inputActionLeft) {
		alarmAttack=0;
		playerState = PlayerState.BasicAttack;
		attackState = AttackType.Punch0;
	}
	
	//sets state to kicking
	else if (inputActionRight) {
		alarmAttack=0;
		playerState = PlayerState.BasicAttack;
		attackState = AttackType.Kick;
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
	xspd = 0;
	yspd = 0;
	
	//respawn alarm
	alarmRespawn--;
	
	//set up variables for respawn
	if (alarmRespawn<0)
	{
		x = lastPosX;
		y = lastPosY;
		z = lastPosZ;
		alarmRespawn=40;
		inputLock=false;
		movementLock = false;
		playerState = PlayerState.Normal;
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
	grappleSpd = 0.015;
	
	
	if (closestTarget.targetType==1)
	{
		if (x<=tX) scrMoveTowardsPoint3D(tX-closestTarget.targetDisplacement,tY,tZ,maxSpeedNormal);
		else scrMoveTowardsPoint3D(tX+closestTarget.targetDisplacement,tY,tZ,maxSpeedNormal);
	}
	else if (closestTarget.targetType==0)
	{
		 scrMoveTowardsPoint3D(tX,tY,tZ,maxSpeedNormal);
	}
	
	/*
	if (place_meeting(x,y,closestTarget)) && (z>closestTarget.z-2 && z<closestTarget.z+2) 
	{
		playerState = PlayerState.AttachToTarget;
	}*/
	
	//jump out of grapple
	if (inputJump)
	{
		zspd = -5;
		movementLock = false;
		playerState = PlayerState.Normal;
	}
}



//ATTACH TO TARGET STATE
if (playerState == PlayerState.AttachToTarget)
{
	xspd=0;
	yspd=0;
	zspd=0;
	z=closestTarget.z;
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

/*
		//set state to Punching (if attached to enemy)
		else if (inputAction && alarmAttachToTarget<26 && closestTarget.hp!=pointer_null)
		{
			alarmAttachToTarget=30;
			alarmAttack=0;
			playerState = PlayerState.BasicAttack;
		}*/
	
		//set state to BackOff
		//Set to secondary right now as left and right are being used for attacks
		if (attachSide == 0 && inputActionSecondary) || (attachSide == 1 && inputActionSecondary)
		{
			alarmAttachToTarget=30;
			playerState = PlayerState.BackOff;
		}
	
		//set state to Parry (if attached to enemy)
		if ((attachSide == 0 && inputActionSecondary) || (attachSide == 1 && inputActionSecondary)) && (closestTarget.hp!=pointer_null)
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

//PUNCHING STATE
if (playerState == PlayerState.BasicAttack)
{
	alarmAttack--;

	if (alarmAttack<34)
	{
		//attack 
		//This is the punches started with the left bumper
		if (inputActionLeft)
		{
			alarmAttack=40;
			attackType++;
			//if (closestTarget.hp != pointer_null) closestTarget.hp-=damage;
			
			
			
			if (attackState != AttackType.Punch0) {
			attackState = AttackType.Punch0;	
			}
			else {
			attackState = AttackType.Punch1;	
			}
			
			/*//reset attack types
			if (attackType>3) attackType = 0;
			
			//decide attack type
			switch(attackType)
			{
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
			} */
		}
		//This is the kicks started with the left bumper
		//As it is, if players press both at the same time punch will come out. I plan
		//on changing this later to the burst move. 
		else if (inputActionRight) {
		alarmAttack=40;
			attackType++;
			//commented out as I assume we'll change how damage works later. 
			//if (closestTarget.hp != pointer_null) closestTarget.hp-=damage;
			
			
				attackState = AttackType.Kick;
				
		}
	}
	
	/*if (closestTarget.hp<1)
	{
		movementLock = false;
		playerState = PlayerState.Normal;
	} */
	
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
	if (attachSide == 0 && inputActionSecondary) || (attachSide == 1 && inputActionSecondary)
	{
		alarmAttachToTarget=30;
		zspd = 2;
		playerState = PlayerState.BackOff;
	}
	
	//end attack state, return to Normal state
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
	if (maxSpeedNormal>5) maxSpeedNormal=5;
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
if (place_meeting(x,y+12,objFloor)) && (place_meeting(x,y+4,objFloor)) abovePit = false;
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
decceleration = 0.2 + (maxSpeedNormal/400);

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
if (place_meeting(x,y,objCrane)) && (playerState == PlayerState.AttachToTarget) playerState = PlayerState.ActionHookLine;

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
	else alarmAnimSpeedRun = 4-(currentSpeed/5);
}
