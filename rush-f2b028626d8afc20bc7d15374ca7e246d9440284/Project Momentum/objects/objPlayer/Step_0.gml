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
	alarmMovementLock--;
	if (alarmMovementLock<0)
	{
		movementLock=false;
	}
	
	//reduces the combo multiplier if the player is on the ground
	if (grounded && comboMultiplier > 0.0) {
	comboMultiplier = comboMultiplier - 0.01;	
	}
	if (comboMultiplier < 0.0) {
	comboMultiplier = 0.0;	
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

//SLIDING STATE
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
		if (x<=tX && !closestTarget.wallToLeft) scrMoveTowardsPoint3D(tX-closestTarget.targetDisplacement,tY,tZ,maxSpeedNormal);
		else if (!closestTarget.wallToRight) scrMoveTowardsPoint3D(tX+closestTarget.targetDisplacement,tY,tZ,maxSpeedNormal);
		
		else if (x>tX && !closestTarget.wallToRight) scrMoveTowardsPoint3D(tX+closestTarget.targetDisplacement,tY,tZ,maxSpeedNormal);
		else if (!closestTarget.wallToLeft) scrMoveTowardsPoint3D(tX-closestTarget.targetDisplacement,tY,tZ,maxSpeedNormal);
	}
	else if (targetType==0)
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



//ATTACH TO TARGET STATE
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
			attackType = 0;
			playerState = PlayerState.BasicAttack;
		}

		
			//set state to stomping
		if (!grounded && !closestTarget.weak)
		{
			if (inputStomp)
			{
				playerState = PlayerState.Stomping;
				//movementLock=true;
			}
		}
		
		if (inputJump)
		{
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


//ATTACK STATE
if (playerState == PlayerState.BasicAttack)
{
	alarmAttachToTarget--;
	zspd=0;
	z=closestTarget.z;

		//INPUT LIGHT ATTACK (X)
		if (inputAction && attackEnabled && attackType < 3)
		{
			
			//increases damage by multiplier and adds the hit to the multiplier
			damage = 1 * comboMultiplier;
			comboMultiplier += 0.05;
			
			/*if (!closestTarget.beenHit){
			closestTarget.beenHit = true;	
			
			}*/
			//closestTarget.hp -= damage;
			alarmAttack=24;
			alarmAttachToTarget=alarmAttack+40;
			attackState = AttackType.Punch;
			attackType++;
			attackEnabled=false;
			actionsEnabled=false;
			if (heavyCharges<4) lightAttackCount++;
			
			//if the enemy is armored
			if (closestTarget.isArmored) {
 				closestTarget.armorHealth -= damage; 
 				}
			
			if (closestTarget.enemyState == EnemyState.Launched) {
			
			//!!
			//This is the line where you can enable/disable the hitstop on enemies when they're juggled
			//!!
			
			closestTarget.zspd = 0;	
			}
		}
		
		else if (inputAction && attackEnabled && attackType == 3) {
			//reverse kick
			if (movementDirection<270 && movementDirection>90  
			&& (inputLeft || inputUp || inputDown)) 
			{
				attackState = AttackType.ReverseKick;
				
				//increases damage by multiplier and adds the hit to the multiplier
				damage = 1 * comboMultiplier;
				comboMultiplier += 0.1;
				
				//if the target is armored, deals damage to their armor
				if (closestTarget.isArmored) {
 				closestTarget.armorHealth -= damage; 
				armorLockedAnimation = true;
 				}
				else {
 					closestTarget.enemyState = EnemyState.Kicked;
 					closestTarget.newSpeed = maxSpeedNormal*2;
 				closestTarget.zspd=8;
 				closestTarget.movementDirection = movementDirection;
 				alarmMovementLock=12;
 				
 				}
				attackEnabled=false;
				actionsEnabled=false;
					
			}
			

			//slam strike
			else /* if ((movementDirection<90 && movementDirection >= 0) || 
			(movementDirection<=360 && movementDirection>270) && (inputRight || inputUp || inputDown))*/
			{
				attackState = AttackType.SlamStrike;
				closestTarget.enemyState = EnemyState.Slammed;
				
				//increases damage by multiplier and adds the hit to the multiplier
				damage = 1 * comboMultiplier;
				comboMultiplier += 0.1;
				
				//if the target is armored, deals damage to their armor
				if (closestTarget.isArmored) {
 				closestTarget.armorHealth -= damage;
				armorLockedAnimation=true;
 				}
				else {
					//launches the target in the direction and deals damage
				if (!closestTarget.wallToSide) closestTarget.xspd= 1.5 * maxSpeedNormal;
				alarmAttachToTarget=12;
				
				}
				attackEnabled=false;
				actionsEnabled=false;
			}
		}
		
		if (lightAttackCount>4)
		{
			lightAttackCount=0;
			if (heavyCharges<4) heavyCharges++;
		}
		
		// LIGHT ATTACK STATE
		if (attackState==AttackType.Punch)
		{
			
			//if (attackType>1) attackType=0;
			alarmAttack--;
			if (alarmAttack < 14) 
			{
				attackEnabled=true;
				actionsEnabled=true;
			}
			if (alarmAttack <= 0) {
			playerState = PlayerState.AttachToTarget;	
			armorLockedAnimation = false;
			}
		}
		
		// REVERSE KICK STATE
		if (attackState==AttackType.ReverseKick)
		{
			attackType = 0;
			alarmAttack--;
			if (alarmAttack<15 && !armorLockedAnimation) {
			actionsEnabled=true;
			}
		}
		
		// SLAM STRIKE STATE
		if (attackState==AttackType.SlamStrike)
		{
			attackType = 0;
			alarmAttack--;
			if (alarmAttack<18 && !armorLockedAnimation) {
				actionsEnabled=true;
			}
		}
		
		//INPUT HEAVY ATTACK (Y)
		if (inputActionSecondary && attackEnabled /*&& heavyCharges>0*/)
		{
			//Combo Extender
			if (((movementDirection<90 && movementDirection >=0) || 
			(movementDirection<=360 && movementDirection>270)) && (inputRight || inputUp || inputDown) && heavyCharges > 0)
			{
				attackState = AttackType.ComboExtender;
				
				//increases damage by multiplier and adds the hit to the multiplier
				damage = 2 * comboMultiplier;
				comboMultiplier += 0.1;
				
				//resets the attack type counter
				attackType = 0;
				
				//if the target is armored, deals damage to their armor
				if (closestTarget.isArmored) {
 				closestTarget.armorHealth -= damage;
				armorLockedAnimation=true;
 				}
				heavyCharges--;
				attackEnabled=false;
				actionsEnabled=false;
			}
			
			//Grab !!! Currently in the works
			/*
			else if (movementDirection<270 && movementDirection>90  
			&& (inputLeft || inputUp || inputDown) && heavyCharges > 0) {
				attackState = AttackType.Grab;
				heavyCharges--;
			}  */
			
			//launcher
			else if (closestTarget.enemyState != EnemyState.Launched)
			{
				//increases damage by multiplier and adds the hit to the multiplier
				damage = 1 * comboMultiplier;
				comboMultiplier += 0.01;
				//sets their zTemp to z for later in the launcher state
				zTemp = z;
				attackState = AttackType.Launcher;
				
				if (closestTarget.isArmored) {
					//if the target is armored, deals damage to their armor
				closestTarget.armorHealth -= damage;
				//this is also for the launcher state; if it's true, you cannot cancel the animation
				armorLockedAnimation=true;
				}
				else {
					//otherwise the enemy is considered launched and their speed is set for such
					closestTarget.enemyState = EnemyState.Launched;
				closestTarget.zspd=-5;
				//playerState = PlayerState.Normal;
				alarmMovementLock=12;
				zspd=-4;
				}
				
				
				attackEnabled=false;
				actionsEnabled=false;
			}
			else if (heavyCharges >= 2 && closestTarget.enemyState == EnemyState.Launched) {
				//increases damage by multiplier and adds the hit to the multiplier
				damage = 1 * comboMultiplier;
				comboMultiplier += 0.01;
				//sets their zTemp to z for later in the launcher state
				zTemp = z;
				attackState = AttackType.Launcher;
				
					//enemy is considered launched and their speed is set for such
					closestTarget.enemyState = EnemyState.Launched;
				closestTarget.zspd=-5;
				//playerState = PlayerState.Normal;
				alarmMovementLock=12;
				zspd=-4;
				heavyCharges = heavyCharges - 2;
			}
			
			alarmAttack=30;
			alarmAttachToTarget=alarmAttack;
			//heavyCharges--;
			attackEnabled=false;
		}
		
		/*
		// GRAB STATE !!! STILL IN THE WORKS
		if (attackState==AttackType.Grab)
		{
			alarmAttack--;
			if (alarmAttack<10) {
			actionsEnabled = true;	
			
			//Chuck Back 
			if (movementDirection<225 && movementDirection>=135  
			&& inputLeft && heavyCharges > 0) {
				attackState = AttackType.GrabChuckBack;
				
				var tempClosestTarget = pointer_null;
				var tempClosestTargetDist = 99999;
				
				for (var i = 1; i < ds_list_size(targetList); i++) {
					if (/*(targetList[i].inPlayerRange == 1 || targetList[i].inPlayerRange == 2) && targetList[| i].active && targetList[| i] != closestTarget) {
						
						var tempDist = targetList[| i].distanceToPlayer;
						if (tempDist < tempClosestTargetDist) {
							tempClosestTargetDist = tempDist;
							tempClosestTarget = targetList[| i];
						}
					}
				}
				if (tempClosestTarget == pointer_null) {
				closestTarget.enemyState = EnemyState.Slammed;
				
				//increases damage by multiplier and adds the hit to the multiplier
				damage = 3 * comboMultiplier;
				comboMultiplier += 0.3;
				
				//if the target is armored, deals damage to their armor
				if (closestTarget.isArmored) {
 				closestTarget.armorHealth -= damage;
				armorLockedAnimation=true;
 				}
				else {
					//launches the target in the direction and deals damage
				if (!closestTarget.wallToSide) closestTarget.xspd= 1.5 * maxSpeedNormal;
				alarmAttachToTarget=12;
				
				}
				attackEnabled=false;
				actionsEnabled=false;
				heavyCharges--;
				}
				else {
						
				var tempX = (tempClosestTarget.x - x);
				var tempY = (tempClosestTarget.y - y);
				var tempZ = (tempClosestTarget.z - z);
	
				var tempLen = sqrt(sqrt(abs(tempX)) + sqrt(abs(tempY)) + sqrt(abs(tempZ)));
	
				tempX = tempX / tempLen;
				tempY = tempY / tempLen;
				tempZ = tempZ / tempLen;
				closestTarget.chuckedAtX = tempX;
				closestTarget.chuckedAtY = tempY;
				closestTarget.chuckedAtZ = tempZ;
				
				closestTarget.enemyState = EnemyState.Chucked;
				zTemp = z;
				}
				
				
			}
			//Chuck 
			else if (movementDirection<315 && movementDirection>=225 && inputRight && heavyCharges > 0) {
				attackState = AttackType.GrabChuck;
				var tempClosestTarget = pointer_null;
				var tempClosestTargetDist = 99999;
				
				for (var i = 0; i < ds_list_size(targetList); i++) {
					if (/*(targetList[i].inPlayerRange == 1 || targetList[i].inPlayerRange == 2) && targetList[| i].active && targetList[| i] != closestTarget) {
						
						var tempDist = targetList[| i].distanceToPlayer;
						if (tempDist < tempClosestTargetDist) {
							tempClosestTargetDist = tempDist;
							tempClosestTarget = targetList[| i];
						}
					}
				}
				if (tempClosestTarget == pointer_null) {
				closestTarget.enemyState = EnemyState.Slammed;
				
				//increases damage by multiplier and adds the hit to the multiplier
				damage = 3 * comboMultiplier;
				comboMultiplier += 0.3;
				
				//if the target is armored, deals damage to their armor
				if (closestTarget.isArmored) {
 				closestTarget.armorHealth -= damage;
				armorLockedAnimation=true;
 				}
				else {
					//launches the target in the direction and deals damage
				if (!closestTarget.wallToSide) closestTarget.xspd= 1.5 * maxSpeedNormal;
				alarmAttachToTarget=12;
				
				}
				attackEnabled=false;
				actionsEnabled=false;
				heavyCharges--;
				}
				else {
					
				var tempX = (tempClosestTarget.x - x);
				var tempY = (tempClosestTarget.y - y);
				var tempZ = (tempClosestTarget.z - z);
	
				var tempLen = sqrt(sqrt(tempX) + sqrt(tempY) + sqrt(tempZ));
	
				tempX = tempX / tempLen;
				tempY = tempY / tempLen;
				tempZ = tempZ / tempLen;
				closestTarget.chuckedAtX = tempX;
				closestTarget.chuckedAtY = tempY;
				closestTarget.chuckedAtZ = tempZ;
				
				
				closestTarget.enemyState = EnemyState.Chucked;
				zTemp = z;
				}
			}
			//Toss Up
			else if (movementDirection<45 && movementDirection>=315 && inputUp) {
				attackState = AttackType.GrabToss;
			}
			//Suplex
			/*
			else if (movementDirection>=45 && movementDirection<135 && inputDown && heavyCharges >= 2) {
				attackState = AttackType.GrabSuplex;
			}
			
			
			}
		} 
		
		if (attackState == AttackType.GrabChuck) {
			z = zTemp;
			attackType = 0;
			alarmAttack--;
			if (alarmAttack < 10) {
			actionsEnabled = true;	
			}
		}
		
		if (attackState == AttackType.GrabChuckBack) {
			z = zTemp;
			attackType = 0;
			alarmAttack--;
			if (alarmAttack < 10) {
			actionsEnabled = true;	
			}
		}
		
		if (attackState == AttackType.GrabToss) {
			z = zTemp;
			attackType = 0;
			alarmAttack--;
			if (alarmAttack < 10) {
			actionsEnabled = true;	
			}
		} */
		
		// COMBO EXTENDER STATE
		if (attackState==AttackType.ComboExtender)
		{

			alarmAttack--;
			if (alarmAttack<30) {
				attackEnabled = true;
				actionsEnabled=true;
			}
		} 
		
		// LAUNCHER STATE
		if (attackState==AttackType.Launcher)
		{
			//sets z to ztemp so you stay in spot while launching rather than following them up
			z = zTemp;
			attackType = 0;
			alarmAttack--;
			//if the enemy isn't armored, you can cancel the launcher animation immediately
			//allowing you to follow up with whatever
			if (alarmAttack<30 && !armorLockedAnimation) {
			actionsEnabled=true;
			if (inputAction) { //if the player inputs a basic attack during the animation, 
				//cancels it allowing them to go straight into either regrappling to the enemy or jumping to something else
				playerState = PlayerState.Normal;
				zspd += -6;
			}
			
			}
			
		}
	

	if (actionsEnabled)
	{
		//set state to stomping
		if (!grounded)
		{
			if (inputStomp)
			{
				playerState = PlayerState.Stomping;
				//movementLock=true;
			}
		}
		
		if (inputJump)
		{
			playerState = PlayerState.Normal;
			zspd=-5;
		}
		
		
	}
	
	/*
	//set state to BackOff
	if (attachSide == 0 && inputActionSecondary) || (attachSide == 1 && inputActionSecondary)
	{
		alarmAttachToTarget=30;
		zspd = 2;
		playerState = PlayerState.BackOff;
	}*/
	
	//end attack state, return to Normal state
	if (alarmAttachToTarget<0)
	{
		attackType=0;
		alarmAttack = 10;
		movementLock = false;
		attackEnabled=true;
		actionsEnabled=true;
		playerState = PlayerState.Normal;
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
	//maxSpeedNormal = 2;
	zspd = zspd - 3;
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
