draw_sprite(sprFenceRail,0,x,y);
if (objPlayer.dropShadowRails && objPlayer.x>=x-16 && objPlayer.x<=x+64)
{
	draw_sprite(sprPlayerShadow,0,objPlayer.x,dropShadowY);
}
//draw_text(x-24,y,slidingDir);