draw_set_color(c_white);
draw_sprite(sprEnemyTestShadow, 0, x, y+zFloor);
draw_sprite(sprEnemyTest, 0, x, y+z);
draw_text(x-24,y+z,inPlayerRange);
//draw_text(x-24, y+z, $"{inPlayerRange}\n{distanceToPlayer}");

if (inPlayerRange && objPlayer.closestTarget == self)
{
	draw_line(x, y+z, objPlayer.x, objPlayer.y+objPlayer.z);
	draw_line(x,y,objPlayer.x,objPlayer.y);
	draw_sprite_ext(sprTargetLockOn, targetFrame, x, y+z, 1, 1, targetAngle, c_white, 1);
	if (objPlayer.playerState == PlayerState.AttachToTarget)
	draw_sprite(sprTargetArrow, 0, x, y+z-sprite_height/3);
}



