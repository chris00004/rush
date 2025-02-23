draw_sprite(sprSpringBoard, 0, x, y+z);
//draw_text(x-24, y+z, $"{inPlayerRange}\n{distanceToPlayer}");
draw_text(x-24,y+z,inPlayerRange);

if (inPlayerRange && objPlayer.closestTarget == self 
&& !collision_line(objPlayer.x,objPlayer.y,x,y,objWall,false,true) 
&& objPlayer.playerState != PlayerState.DialogueNPC)
{
	if (objPlayer.playerState == PlayerState.HomeIn) 
	{
		angle-=15;
		draw_line_width_colour(x, y+z, objPlayer.x+10, objPlayer.y+objPlayer.z-10, 1.5, c_black, c_red);
		draw_sprite_ext(sprTriHook,0,x,y+z,1.5,1.5,angle,c_white,1);
	}
	else
	{
	draw_sprite_ext(sprTargetLockOn, targetFrame, x, y+z, 1, 1, targetAngle, c_white, 1);
	}
}

