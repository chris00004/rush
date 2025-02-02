//set font
draw_set_font(fntPlayerHUD);

//player related
if(instance_exists(objPlayer))
{
if (objPlayer.playerState!=PlayerState.DialogueNPC)
{
	/*
draw_sprite(sprPlayerHud,1,camX,camY);
draw_set_color(c_black)
draw_text(camX+17,camY+16,$"{objPlayer.tris}");
draw_text(camX+3,camY+258,"[C] SHOW CONTROLS");
draw_set_color(c_white)
draw_text(camX+16,camY+16,$"{objPlayer.tris}");
draw_text(camX+2,camY+258,"[C] SHOW CONTROLS");
*/
if (showControls)
{
	draw_set_color(c_black)
draw_text(objCamera.camX+3,objCamera.camY+100,"[WASD] MOVE");
draw_text(objCamera.camX+3,objCamera.camY+115,"[SPACE] JUMP");
draw_text(objCamera.camX+3,objCamera.camY+130,"[SHIFT] BOOST");
draw_text(objCamera.camX+3,objCamera.camY+145,"[L] STOMP");
draw_text(objCamera.camX+3,objCamera.camY+160,"[K] LOCK-ON");
draw_text(objCamera.camX+3,objCamera.camY+175,"HOLD [K] ATTACK");
draw_text(objCamera.camX+3,objCamera.camY+190,"[Q] BACKOFF ENEMY");
	draw_set_color(c_white)
draw_text(objCamera.camX+2,objCamera.camY+100,"[WASD] MOVE");
draw_text(objCamera.camX+2,objCamera.camY+115,"[SPACE] JUMP");
draw_text(objCamera.camX+2,objCamera.camY+130,"[SHIFT] BOOST");
draw_text(objCamera.camX+2,objCamera.camY+145,"[L] STOMP");
draw_text(objCamera.camX+2,objCamera.camY+160,"[K] LOCK-ON");
draw_text(objCamera.camX+2,objCamera.camY+175,"HOLD [K] ATTACK");
draw_text(objCamera.camX+2,objCamera.camY+190,"[Q] BACKOFF ENEMY");
}

//fade out for stage end
if (objPlayer.alarmStageEnd<0)
{
	alpha+=0.02;
	draw_sprite_ext(sprScreenBlack,0,camX,camY,1,1,0,c_black,alpha);
}


//draw timer
if (seconds<10)
{
draw_set_color(c_black)
draw_text(camX+17,camY+1,string(minutes)+":0"+string(seconds));
draw_set_color(c_white)
draw_text(camX+16,camY+1,string(minutes)+":0"+string(seconds));
}
else
{
	draw_set_color(c_black)
draw_text(camX+17,camY+1,string(minutes)+":"+string(seconds));
draw_set_color(c_white)
draw_text(camX+16,camY+1,string(minutes)+":"+string(seconds));
}
}
}
