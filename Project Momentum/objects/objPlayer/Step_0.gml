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
		maxSpeedNormal -= 0.075;
		if (maxSpeedNormal-0.05 <= 2.5) 
		{
			maxSpeedNormal = 2.5;
			momentumLoss = false;
			
		}
	}
}

//-----[ GOD MODE ]-----------------------------------------------------------------------------------------------------------------------------
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

//-----[ NORMAL STATE ]-----------------------------------------------------------------------------------------------------------------------------
if (playerState == PlayerState.Normal)
{	
	grav = gravNormal;
	//animYPosActual = false;
	
	//reduces the combo multiplier if the player is on the ground
	if (grounded && comboMultiplier > 0.0) {
	comboMultiplier = comboMultiplier - 0.01;	
	}
	
	
	//set state to stomping
	if (!grounded)
	{
		if (inputStomp)
		{
			playerState = PlayerState.Stomping;
			//movementLock=true;
		}
	}

	//set state to sliding
	if (grounded && currentSpeed>=2.5)
	{
		if (inputStomp)
		{
			playerState = PlayerState.Sliding;
			alarmSliding = 45/(currentSpeed/(4*currentSpeed/3));
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

//-------[ SLIDING STATE ]-----------------------------------------------------------------------------------------------------------------------------
if (playerState == PlayerState.Sliding)
{
	momentumLoss=false;
	alarmMomentumLoss = 1;
	alarmSliding--;

	if (alarmSliding<0) && (!place_meeting(x,y,objSlideWallTrigger))
	{
		alarmSliding = 45/currentSpeed;
		playerState = PlayerState.Normal;
		movementLock=false;
	}
	
	if (place_meeting(x,y,objSlideWallTrigger))
	{
		jumpLock = true;
	}
	else jumpLock = false;
}

//-----[ DEAD STATE ]-----------------------------------------------------------------------------------------------------------------------------
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

//-----[ STOMPING STATE ]-----------------------------------------------------------------------------------------------------------------------------
if (playerState == PlayerState.Stomping)
{

	zspd+=3.5;
	if (grounded) 
	{
		playerState = PlayerState.Normal;
		movementLock=false;
	}
}

//----[ HOME IN STATE ]-----------------------------------------------------------------------------------------------------------------------------
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
		if (x<=tX && !closestTarget.wallToLeft) scrMoveTowardsPoint3D(tX-closestTarget.targetDisplacement,tY,tZ,maxSpeedNormal);
		else if (!closestTarget.wallToRight) scrMoveTowardsPoint3D(tX+closestTarget.targetDisplacement,tY,tZ,maxSpeedNormal);
		
		else if (x>tX && !closestTarget.wallToRight) scrMoveTowardsPoint3D(tX+closestTarget.targetDisplacement,tY,tZ,maxSpeedNormal);
		else if (!closestTarget.wallToLeft) scrMoveTowardsPoint3D(tX-closestTarget.targetDisplacement,tY,tZ,maxSpeedNormal);
	}
	else if (closestTarget.targetType==0)
	{
		 scrMoveTowardsPoint3D(tX,tY,tZ,maxSpeedNormal);
	}
	
	//jump out of grapple
	if (inputJump)
	{
		zspd = -5;
		movementLock = false;
		playerState = PlayerState.Normal;
	}
}



//----[ ATTACH TO TARGET STATE ]-----------------------------------------------------------------------------------------------------------------------------
if (playerState == PlayerState.AttachToTarget)
{
	damage = 1;
	tX = closestTarget.x;
	tY = closestTarget.y;
	tZ = closestTarget.z;
	
	xspd=0;
	yspd=0;
	zspd=0;
	z=tZ;
	y=tY;
	
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
			alarmAttachToTarget=50;
			alarmAttack=20;
			attackEnabled=true;
			lightAttackCount=0;
			playerState = PlayerState.BasicAttack;
		}
		
		//set state to Heavy Attack (if attached to enemy)
		else if (inputActionSecondary && alarmAttachToTarget<26 && closestTarget.hp!=pointer_null)
		{
			alarmAttachToTarget=50;
			alarmAttack=20;
			attackEnabled=true;
			playerState = PlayerState.BasicAttack;
		}
		else if (inputStomp && (inputLeft || inputRight || inputUp || inputDown) 
		&& alarmAttachToTarget<26 && closestTarget.hp!=pointer_null) 
		{
			attackEnabled=true;
			playerState = PlayerState.BasicAttack;
		}

		
			//set state to stomping
		if (!grounded && !closestTarget.weak && !(inputLeft || inputRight || inputUp || inputDown))
		{
			if (inputStomp)
			{
				movementLock=false;
				playerState = PlayerState.Stomping;
				//movementLock=true;
			}
		}
		
		if (inputJump)
		{
			movementLock=false;
			playerState = PlayerState.Normal;
			zspd=-5;
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


//---[ ATTACK STATE ]-----------------------------------------------------------------------------------------------------------------------------
if (playerState == PlayerState.BasicAttack)
{
	alarmAttachToTarget--;
	
	//make sure player stays attatched to target
	tX = closestTarget.x;
	tY = closestTarget.y;
	tZ = closestTarget.z;
	
	xspd=0;
	yspd=0;
	zspd=0;
	z=tZ;
	y=tY;
	
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

		//INPUT LIGHT ATTACK (X)
		if (inputAction && attackEnabled)
		{
			//if fourth punch do punch finisher
			if (lightAttackCount>2)
			{
				damage = 1.5 * comboMultiplier;
				comboMultiplier += 0.07;
				if (attachSide==0 && !closestTarget.wallToSide)
				{
					closestTarget.xspd = 1.5+(maxSpeedNormal/4);
				}
				else if (!closestTarget.wallToSide)
				{
					closestTarget.xspd = -(1.5+(maxSpeedNormal/4));
				}
				//reset grav to normal 
				closestTarget.grav = 0.12;
				movementLock=true;
				closestTarget.enemyState = EnemyState.Shoved;
				attackState = AttackState.PunchFinisher;
				playerState = PlayerState.AttackFinish;
			}
			//punches 1-3
			else
			{
				damage = 1 * comboMultiplier;
				comboMultiplier += 0.05;
				attackState = AttackState.Punch;
				punchAnim++;
			}
			
			attackEnabled=false;
			actionsEnabled=false;
			alarmAttack=32;
			alarmAttachToTarget=alarmAttack+40;
			lightAttackCount++;
			heavyChargeCounter++;
			
		}
		
		// ADD/CAP CHARGES
		if (lightAttackCount>3)
		{
			lightAttackCount=0;
			
		}
		
		if (heavyCharges<5 && heavyChargeCounter > 5) {
			heavyCharges++;
			heavyChargeCounter = 0;
		}
		// LIGHT ATTACK STATE
		if (attackState==AttackState.Punch)
		{
			
			if (punchAnim>1) punchAnim=0;
			alarmAttack--;
			if (alarmAttack < 21) 
			{
				attackEnabled=true;
				actionsEnabled=true;
			}
			if (alarmAttack < 0) {
			playerState = PlayerState.Normal;
			movementLock=false;
			}
		}
		
		// LIGHT ATTACK FINISHER 
		if (attackState==AttackState.PunchFinisher)
		{
			alarmAttack--;
			if (alarmAttack < 28) 
			{
				//attackEnabled=true;
				actionsEnabled=true;
			}
			if (alarmAttack < 0) {
			playerState = PlayerState.Normal;	
			movementLock=false;
			}
		}
		
		//INPUT HEAVY ATTACK (Y)
		if (inputActionSecondary && attackEnabled)
		{
			//combo extender
			if ((inputLeft || inputUp || inputDown || inputRight) && (heavyCharges>0))
			{
				attackState = AttackState.comboExtender;
				
				//increases damage by multiplier and adds the hit to the multiplier
				damage = 2 * comboMultiplier;
				comboMultiplier += 0.1;
				
				lightAttackCount = 0;
				
				if (closestTarget.isArmored) {
				closestTarget.armorHealth -= damage;
				armorLockedAnimation=true;	
				}
				else {
				
				}
				
				
				alarmAttachToTarget=12;
				attackEnabled=false;
				actionsEnabled=false;
				heavyCharges--;
				alarmMovementLock=40;
				alarmAttack=20;
				alarmAttachToTarget=alarmAttack;
			}
			//launcher
			else if (closestTarget.enemyState != EnemyState.Launched)
			{
					
				attackState = AttackState.Launcher;
				
				damage = 1 * comboMultiplier;
				comboMultiplier += 0.01;
				//increases damage by multiplier and adds the hit to the multiplier
				
				
				if (closestTarget.isArmored) {
				closestTarget.armorHealth -= damage;
				armorLockedAnimation=true;	
				}
				else {
					closestTarget.enemyState = EnemyState.Launched;
				closestTarget.zspd=-5;
				alarmMovementLock=12;
				zspd=-4;
				}
				

				
				
				attackEnabled=false;
				actionsEnabled=false;
				alarmAttack=40;
				alarmAttachToTarget=alarmAttack;
				closestTarget.grav=0.12;
				attackEnabled=false;
				playerState=PlayerState.AttackFinish;
				}
				
			else if (heavyCharges >= 2 && closestTarget.enemyState == EnemyState.Launched) {
				//increases damage by multiplier and adds the hit to the multiplier
				attackState = AttackState.Launcher;
				damage = 1 * comboMultiplier;
				comboMultiplier += 0.01;
				if (closestTarget.isArmored) {
				closestTarget.armorHealth -= damage;
				armorLockedAnimation=true;	
				}
				else {
					closestTarget.enemyState = EnemyState.Launched;
				closestTarget.zspd=-5;
				alarmMovementLock=12;
				zspd=-4;
				}
				heavyCharges -= 2;
				attackEnabled=false;
				actionsEnabled=false;
				alarmAttack=40;
				alarmAttachToTarget=alarmAttack;
				closestTarget.grav=0.12;
				attackEnabled=false;
				playerState=PlayerState.AttackFinish;
			}
		}
		
		// COMBO EXTENDER STATE
		if (attackState==AttackState.comboExtender)
		{

			alarmAttack--;
			if (alarmAttack<30) {
				attackEnabled = true;
				actionsEnabled=true;
			}
		} 
		
		if (inputStomp && attackEnabled) {
		//slam strike
			if ((inputLeft || inputUp || inputDown || inputRight) && (heavyCharges>0))
			{
				attackState = AttackState.SlamStrike;
				
				//increases damage by multiplier and adds the hit to the multiplier
				damage = 2 * comboMultiplier;
				comboMultiplier += 0.1;
				
				if (closestTarget.isArmored) {
				closestTarget.armorHealth -= damage;
				armorLockedAnimation=true;	
				}
				else {
				closestTarget.enemyState = EnemyState.SlamStrike;
				closestTarget.newSpeed = maxSpeedNormal*2;
				closestTarget.zspd=8;
				closestTarget.movementDirection = movementDirection;
				closestTarget.grav=0.12;
				xspd = (lengthdir_x(0.1, movementDirection))/2;
				yspd = (lengthdir_y(0.1, movementDirection))/2;
				zspd=-1;
				grav=0.12;
				}
				
				
				alarmAttachToTarget=12;
				attackEnabled=false;
				actionsEnabled=false;
				heavyCharges--;
				alarmMovementLock=40;
				alarmAttack=20;
				alarmAttachToTarget=alarmAttack;
				attackEnabled=false;
				
				
				movementLock=false;
				playerState=PlayerState.AttackFinish;
			}	
		}
		
	// ALLOW FOR JUMPING OUT AND STOMPING
	if (actionsEnabled)
	{
		//set state to stomping
		if (!grounded)
		{
			if (inputStomp && !inputUp && !inputDown 
			&& !inputRight && !inputLeft)
			{
				movementLock=false;
				playerState = PlayerState.Stomping;
			}
		}
		
		if (inputJump)
		{
			movementLock=false;
			playerState = PlayerState.Normal;
			zspd=-5;
		}
	}
	
	//end attack state, return to Normal state
	if (alarmAttachToTarget<0)
	{
		punchAnim=0;
		alarmAttack = 20;
		movementLock = false;
		attackEnabled=true;
		actionsEnabled=true;
		playerState = PlayerState.Normal;
	}
}

//----[ ATTACK FINISH STATE ]--------------------------------------------------------------
if (playerState == PlayerState.AttackFinish)
{
	switch (attackState)
	{
		case AttackState.PunchFinisher:
		movementLock=true;
		
		alarmAttack--;
		
		//base alarm for this attack: 45
		//allows for jumping and stomping after 15 frames
		if (alarmAttack<30 && !armorLockedAnimation)
		{
			actionsEnabled=true;
		}
		
		if (alarmAttack<0)
		{
			grav=gravNormal;
			movementLock=false;
			playerState = PlayerState.Normal;
		}
		break;
		case AttackState.Launcher:
		//set movement lock back to false
		grav=gravNormal;
		alarmMovementLock--;
		if (alarmMovementLock<0 && !armorLockedAnimation)
		{
			movementLock=false;
		}
		alarmAttack--;
		if (alarmAttack<0)
		{
			movementLock=false;
			playerState = PlayerState.Normal;
		}
		scrTargetObject();
		break;
		case AttackState.SlamStrike:

		alarmMovementLock--;
		if (alarmMovementLock<0 && !armorLockedAnimation)
		{
			movementLock=false;
		}
		alarmAttack--;
		if (alarmAttack<0)
		{
			movementLock=false;
			grav=gravNormal;
			playerState = PlayerState.Normal;
		}
		break;
		
		
	}
	
	// ALLOW FOR JUMPING OUT AND STOMPING
	if (actionsEnabled)
	{
		//set state to stomping
		if (!grounded)
		{
			if (inputStomp && !inputUp && !inputDown 
			&& !inputRight && !inputLeft)
			{
				movementLock=false;
				playerState = PlayerState.Stomping;
			}
		}
		
		if (inputJump)
		{
			movementLock=false;
			playerState = PlayerState.Normal;
			zspd=-5;
		}
	}
}

if (playerState == PlayerState.ActionRailGrind)
{
	landed=false;
	momentumLoss=false;
	alarmMomentumLoss=15;
	movementLock=true;
	xspd=maxSpeedNormal*sign(xspd);
	grav=0;
	if (inputJump)
	{
		movementLock=false;
		playerState = PlayerState.Normal;
		zspd=-5;
	}
	
	if (inputAction)
	{
		xspd+=0.3;
		maxSpeedNormal+=0.5;
	}
	
	if (!place_meeting(x,y,objFenceRailTrigger))
	{
		dropShadowRails=false;
		playerState = PlayerState.Normal;
		grav = gravNormal;
		movementLock=false;
	}
}

//COMBO METER
if (maxSpeedNormal>3)
{
	//comboMultiplier+=maxSpeedNormal/5000;
}

//Caps the combo multiplier at 5
if (comboMultiplier>5) {comboMultiplier=5;}

//Keeps the combo multiplier from decreasing below 0
if (comboMultiplier < 0) {
comboMultiplier = 0;	
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
			//movementLock=true;
		}
	}
	

	//set state to normal
	if (grounded)
	{
		playerState = PlayerState.Normal;
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
			//movementLock=true;
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
if (place_meeting(x,y+6,objFloor)) && (place_meeting(x,y+2,objFloor)) abovePit = false;
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


//KEYBOARD DIRECTIONAL INPUT
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
	
	//GAMEPAD DIRECTIONAL INPUT
	else if (gamepadActive)
	{
		joystickAngle  = point_direction(0,0,gamepad_axis_value(0,gp_axislh),gamepad_axis_value(0,gp_axislv))
		movementDirection = joystickAngle;
	}


//HANDLE MOVING
if (!inputLock && !movementLock  && !charLock && playerState != PlayerState.Dead)
{
	
	//calculate speeds with regard to direction 
	if (inputRight || inputLeft || inputUp || inputDown)
	{
		//cos and sin of acceleration
		angleAccelerationX = acceleration * cos(movementDirection*(pi/180));
		angleAccelerationY = -(acceleration * sin(movementDirection*(pi/180)));
		
		//apply acceleration to player speed
		xspd+=angleAccelerationX;
		yspd+=angleAccelerationY;
	
	
		// Calculate current speed
		currentSpeed = sqrt(sqr(xspd) + sqr(yspd));

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
if ((!inputRight && !inputLeft) || (inputRight && inputLeft) || movementLock) 
&& (playerState!=PlayerState.Sliding) && (playerState!=PlayerState.AttackFinish)
&& (playerState!=PlayerState.ActionRailGrind)
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
if ((!inputUp && !inputDown) || (inputUp && inputDown) || movementLock) 
&& (playerState!=PlayerState.Sliding) && (playerState!=PlayerState.AttackFinish)
&& (playerState!=PlayerState.ActionRailGrind)
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

if (inputRight || inputLeft || inputDown || inputUp) 
{
	alarmAnimSpeedRun--;
}
else animFrameRun = 0;

if (alarmAnimSpeedRun<0) 
{
	animFrameRun++;
	if (currentSpeed<3)  alarmAnimSpeedRun = 4;
	else alarmAnimSpeedRun = 4-(currentSpeed/5);
}

if ((inputRight || inputLeft || inputDown || inputUp) && (!movementLock)
&& (playerState == PlayerState.Normal))
{
	animDirection=movementDirection;
}
else if (playerState != PlayerState.Normal)
{
	animDirection=point_direction(0, 0, xspd, yspd);
}