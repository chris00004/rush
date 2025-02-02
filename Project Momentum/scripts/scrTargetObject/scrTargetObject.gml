// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrTargetObject()
{
// Initialize variables
    closestTarget = noone;
    closestTargetDistance = 999999;
    inPriorityRange = false;

    // First, check if any target is in cone range (inPlayerRange == 2)
    for (var i = 0; i < ds_list_size(targetList); i++)
    {
        var target = targetList[| i];
        if (target.inPlayerRange == 2 && target.active)
        {
            inPriorityRange = true;
            var dist = target.distanceToPlayer;
            if (dist < closestTargetDistance)
            {
                closestTargetDistance = dist;
                closestTarget = target;
            }
        }
    }

    // If no targets in cone range, check for targets in semi-circle range (inPlayerRange == 1)
    if (!inPriorityRange)
    {
        for (var i = 0; i < ds_list_size(targetList); i++)
        {
            var target = targetList[| i];
            if (target.inPlayerRange == 1 && target.active)
            {
                var dist = target.distanceToPlayer;
                if (dist < closestTargetDistance)
                {
                    closestTargetDistance = dist;
                    closestTarget = target;
                }
            }
        }
    }
	
	
	
    // If a target is found and the input action is triggered, set the player state to HomeIn
    if (closestTarget != noone && inputAction && !collision_line(x,y,closestTarget.x,closestTarget.y,objWall,false,true))
    {
        playerState = PlayerState.HomeIn;
        grav = 0;
        zspd = 0;
        xspd = 0;
        yspd = 0;
        inputLock = true;
        alarmAttachToTarget = 30;
        attachSpd = ((closestTarget.y + closestTarget.z) - (y + z)) / (closestTarget.x - x);
    }

}