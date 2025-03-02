if (active)
{
draw_set_color(c_white);
draw_sprite(sprEnemyTestShadow, 0, x, y+zFloor);
draw_sprite(sprEnemyTest, 0, x, y+z);
draw_text(x-24,y+z,inPlayerRange);
draw_text(x-24, y+z+12, enemyState);

if (inPlayerRange && objPlayer.closestTarget == self 
&& !collision_line(objPlayer.x,objPlayer.y,x,y,objWall,false,true) 
&& objPlayer.playerState != PlayerState.DialogueNPC)
{
	//draw_line(x, y+z, objPlayer.x, objPlayer.y+objPlayer.z);
	draw_sprite_ext(sprTargetLockOn, targetFrame, x, y+z, 1, 1, targetAngle, c_white, 1);
	if (objPlayer.playerState == PlayerState.AttachToTarget)
	draw_sprite(sprTargetArrow, 0, x, y+z-sprite_height/3);
	draw_set_color(c_red);
	if (weak) draw_sprite(sprEnemyUIWeak, 0, x-24,y+z-4)
	draw_set_color(c_white);
}

draw_text(x+24,y,wallToRight);
draw_text(x+24,y+12,wallToLeft);
}