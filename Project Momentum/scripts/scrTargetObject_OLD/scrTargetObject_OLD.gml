// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrTargetObjectOLD()
{
	
	//check for nearest target
	closestTargetDistance = 999999;
	inPriorityRange = false;
	
	//check if target is in cone range
	for (i=0; i<ds_list_size(targetList); i++)
	{
		if (targetList[| i].inPlayerRange == 2)
		{
			inPriorityRange = true;
		}
	}
	if (!inPriorityRange)
	{
		for (i=0; i<ds_list_size(targetList); i++)
		{
			if (targetList[| i].inPlayerRange==1)
			{
			
				if (targetList[| i].distanceToPlayer<closestTargetDistance && targetList[| i].active) //&& (abs(abs(z)-abs(targetList[| i].z))<80)
				{
				closestTargetDistance = targetList[| i].distanceToPlayer;
				closestTarget = targetList[| i];
				
				//set state to HomeIn
				if (inputAction) 
				{
					playerState = PlayerState.HomeIn;
					grav = 0;
					zspd = 0;
					xspd = 0;
					yspd = 0;
					inputLock=true;
					alarmAttachToTarget=30;
					attachSpd = ((closestTarget.y+closestTarget.z)-(y+z))/(closestTarget.x-x);
			
				}
			}
		}
	}
	}
	else
	{
		for (i=0; i<ds_list_size(targetList); i++)
	{
		if (targetList[| i].inPlayerRange==2)
		{
			
			if (targetList[| i].distanceToPlayer<closestTargetDistance && targetList[| i].active) //&& (abs(abs(z)-abs(targetList[| i].z))<80)
			{
				closestTargetDistance = targetList[| i].distanceToPlayer;
				closestTarget = targetList[| i];
				
				//set state to HomeIn
				if (inputAction) 
				{
					playerState = PlayerState.HomeIn;
					grav = 0;
					zspd = 0;
					xspd = 0;
					yspd = 0;
					inputLock=true;
					alarmAttachToTarget=30;
					attachSpd = ((closestTarget.y+closestTarget.z)-(y+z))/(closestTarget.x-x);
			
				}
			}
		}
	}
	}

}