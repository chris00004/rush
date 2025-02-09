//shadow
draw_set_alpha(0.5);
draw_set_color(c_black);
draw_rectangle(x-12,y-12,x+11,y+11,false);

//blockBG
draw_set_alpha(1);
draw_set_color(c_red);
draw_rectangle(iX-12,y-12+z-52,iX+11,y+11+z-52,false);

//crane side R
if (x>=iX)
{
draw_sprite_ext(sprCraneSide,0,iX+12,y+z-52,dist,1,0,c_white,1);
draw_sprite_ext(sprCraneSide,0,iX-12,y+z-52,dist,1,0,c_white,1);
}

//crane side L
else
{
draw_sprite_ext(sprCraneSide,0,iX-12,y+z-52,dist,1,0,c_white,1);
draw_sprite_ext(sprCraneSide,0,iX+12,y+z-52,dist,1,0,c_white,1);
}

//crane hook
draw_sprite_ext(sprCraneHook,0,x,y+z,1,1,0,c_white,1);

draw_set_color(c_white);
if (inPlayerRange && objPlayer.closestTarget == self)
{
	draw_line(x, y+z, objPlayer.x, objPlayer.y+objPlayer.z);
	draw_sprite_ext(sprTargetLockOn, targetFrame, x, y+z, 1, 1, targetAngle, c_white, 1);
	if (objPlayer.playerState == PlayerState.AttachToTarget)
	draw_sprite(sprTargetArrow, 0, x, y+z-sprite_height/3);
}