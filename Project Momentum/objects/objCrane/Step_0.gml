switch(state)
{
	//IDLE
	case CraneState.Idle:
		if (keyboard_check_pressed(vk_lcontrol))
		{
			state = CraneState.Moving;
			position*=-1;
		}
		
		if (craneActive)
		{
			//reset player back to normal state
			objPlayer.playerState = PlayerState.Normal;
			objPlayer.movementLock=false;
			
			//send player to right
			if (position==1) objPlayer.xspd = objPlayer.maxSpeedNormal;

			//send player to left
			if (position==-1) objPlayer.xspd = -objPlayer.maxSpeedNormal;
			
			//shoot player up farther the faster yourre going
			objPlayer.zspd=-4-(objPlayer.maxSpeedNormal/8);
			
			//increase max speed
			objPlayer.maxSpeedNormal += 0.33;
			
			craneActive=false;
		}
	break;
	//MOVING
	case CraneState.Moving:
	
		//move crane L & R
		x+=xspd*position;
		if (x>iX+maxDistance) 
		{
			x=iX+maxDistance;
			state = CraneState.Idle;
		}
		if (x<iX-maxDistance) 
		{
			x=iX-maxDistance;
			state = CraneState.Idle;
		}
		
		//player related
		if (craneActive)
		{
			objPlayer.x=x;
			objPlayer.y=y;
			objPlayer.z=z+24;
			objPlayer.yspd=0;
			//objPlayer.xspd=xspd*position;
			objPlayer.zspd=0;
		}
	break;
}

xspd = objPlayer.maxSpeedNormal;
dist = (x-iX)/96;

//player related
if (objPlayer.playerState == PlayerState.ActionHookLine && objPlayer.closestTarget == self && !craneActive)
{
	craneActive = true;
	state = CraneState.Moving;
	position*=-1;
}


event_inherited();