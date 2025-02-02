draw_set_color(c_white);
draw_sprite(sprHook, 1, x, y+zFloor);
if (objPlayer.playerState == PlayerState.ActionHookLine) draw_sprite(sprFlameHook, 0, x, y+z-18);
else draw_sprite(sprHook, 0, x, y+z-18);
//sparks
if (hookLineActive)
{
switch (ceil(direction))
{
	case 0: 
	draw_sprite_ext(sprHookSparksHorizontal,sparkFrame,x,y+z-54,1,1,0,c_white,1);
	break;
	case 45: 
	draw_sprite_ext(sprHookSparksHorizontal,sparkFrame,x,y+z-54,1,1,45,c_white,1);
	break;
	case 90: 
	draw_sprite_ext(sprHookSparksVertical,sparkFrame,x,y+z-59,1,1,0,c_white,1);
	break;
	case 135: 
	draw_sprite_ext(sprHookSparksHorizontal,sparkFrame,x,y+z-54,1,-1,135,c_white,1);
	break;
	case 180: 
	draw_sprite_ext(sprHookSparksHorizontal,sparkFrame,x,y+z-54,-1,1,0,c_white,1);
	break;
	case 225: 
	draw_sprite_ext(sprHookSparksHorizontal,sparkFrame,x,y+z-54,1,-1,225,c_white,1);
	break;
	case 270: 
	draw_sprite_ext(sprHookSparksVertical,sparkFrame,x,y+z-59,1,-1,0,c_white,1);
	break;
	case 315: 
	draw_sprite_ext(sprHookSparksHorizontal,sparkFrame,x,y+z-54,1,1,315,c_white,1);
	break;
}
}

draw_text(x-24,y+z,inPlayerRange);
draw_text(x-24,y+z+12,direction);
draw_text(x-24,y+z+24,hookLineActive);
//draw_text(x-24, y+z, $"{inPlayerRange}\n{distanceToPlayer}");

if (inPlayerRange && objPlayer.closestTarget == self 
&& !collision_line(objPlayer.x,objPlayer.y,x,y,objWall,false,true)
&& objPlayer.playerState != PlayerState.ActionHookLine)
{
	draw_line(x, y+z-18, objPlayer.x, objPlayer.y+objPlayer.z);
	draw_sprite_ext(sprTargetLockOn, targetFrame, x, y+z-18, 1, 1, targetAngle, c_white, 1);
	if (objPlayer.playerState == PlayerState.AttachToTarget)
	draw_sprite(sprTargetArrow, 0, x, y+z-18-sprite_height/3);
}



