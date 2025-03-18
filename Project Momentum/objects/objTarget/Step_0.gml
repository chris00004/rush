if (active)
{
//add to enemy array
if (!added)
{
	ds_list_add(objPlayer.targetList, self);
	added = true;
}

//index in enemy array
index = ds_list_find_index(objPlayer.targetList, self);

inPlayerRange = 0;
if (place_meeting(x,y+zFloor,objPlayerHomingCone)) inPlayerRange = 2;
else if (place_meeting(x,y+zFloor,objPlayerHomingRadius)) inPlayerRange = 1;
else inPlayerRange = 0;

//check distance to player
distanceToPlayer = (sqrt(power(abs(x-objPlayer.x),2) + power(abs((y+zFloor)-objPlayer.y),2)));

//animation
targetAngle += 15;
}


	

