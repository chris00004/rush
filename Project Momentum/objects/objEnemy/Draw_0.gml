if (active)
{
draw_set_color(c_white);
draw_sprite(sprEnemyTestShadow, 0, x, y+zFloor);
draw_sprite(sprEnemyTest, 0, x, y+z);

if (objPlayer.closestTarget == self 
&& !collision_line(objPlayer.x,objPlayer.y,x,y,objWall,false,true) 
&& objPlayer.playerState != PlayerState.DialogueNPC)
{
	if (objPlayer.playerState == PlayerState.HomeIn) 
	{
		draw_set_alpha(0.4);
	draw_line_width_colour(x, y, objPlayer.x, objPlayer.y+12, 1.5, c_black, c_black);
	draw_set_alpha(1);
		angle-=15;
		draw_line_width_colour(x, y+z, objPlayer.x+10, objPlayer.y+objPlayer.z-10, 1.5, c_black, c_red);
		draw_sprite_ext(sprTriHook,0,x,y+z,1.5,1.5,angle,c_white,1);
	}
	else
	{
	draw_sprite_ext(sprTargetLockOn, targetFrame, x, y+z, 1, 1, targetAngle, c_white, 1);
	}
	if (objPlayer.playerState == PlayerState.AttachToTarget)
	draw_sprite(sprTargetArrow, 0, x, y+z-sprite_height/3);
	draw_set_color(c_red);
	if (weak) draw_sprite(sprEnemyUIWeak, 0, x-24,y+z-4)
	draw_set_color(c_white);
}

draw_text(x+24,y,grav);
draw_text(x+24,y+12,xspd);
}