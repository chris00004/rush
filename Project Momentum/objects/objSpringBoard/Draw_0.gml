draw_sprite(sprSpringBoard, 0, x, y+z);
//draw_text(x-24, y+z, $"{inPlayerRange}\n{distanceToPlayer}");
draw_text(x-24,y+z,inPlayerRange);

if (inPlayerRange && objPlayer.closestTarget == self 
&& !collision_line(objPlayer.x,objPlayer.y,x,y,objWall,false,true) 
&& objPlayer.playerState != PlayerState.DialogueNPC)
{
	draw_line(x, y+z, objPlayer.x, objPlayer.y+objPlayer.z);
	draw_sprite_ext(sprTargetLockOn, targetFrame, x, y+z, 1, 1, targetAngle, c_white, 1);
}

