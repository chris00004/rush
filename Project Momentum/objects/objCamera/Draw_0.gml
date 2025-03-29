//set font
//draw_set_font(fntPlayerHUD);

//player related
if(instance_exists(objPlayer))
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
draw_text(objCamera.camX+3,objCamera.camY+160,"[K] HOME-IN");
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

if (room==rmTutorialStage)
{
	/*
// (X)
if (objPlayer.inputActionHold) draw_set_color(c_red);
else draw_set_color(c_white);
draw_circle(camX+200,camY+164,6,false);
// (B)
if (objPlayer.inputStompHold) draw_set_color(c_red);
else draw_set_color(c_white);
draw_circle(camX+224,camY+164,6,false);
// (Y)
if (objPlayer.inputActionSecondaryHold) draw_set_color(c_red);
else draw_set_color(c_white);
draw_circle(camX+212,camY+152,6,false);
// (A)
if (objPlayer.inputJumpHold) draw_set_color(c_red);
else draw_set_color(c_white);
draw_circle(camX+212,camY+176,6,false);

// (L-Stick)
draw_set_color(c_grey);
draw_circle(camX+120,camY+164,11,false);
draw_set_color(c_white);
draw_sprite_ext(sprTestCircle,objPlayer.inputUp || objPlayer.inputDown || objPlayer.inputRight
|| objPlayer.inputLeft,camX+121,camY+165,1,1,objPlayer.movementDirection-90,c_white,1);

//LB
if (objPlayer.inputActionLeftHold) draw_set_color(c_red);
else draw_set_color(c_white);
draw_rectangle(camX+108,camY+126,camX+134,camY+134,false);

//RB
if (objPlayer.inputActionRightHold) draw_set_color(c_red);
else draw_set_color(c_white);
draw_rectangle(camX+199,camY+126,camX+225,camY+134,false);

//LT
if (objPlayer.inputLTHold) draw_set_color(c_red);
else draw_set_color(c_white);
draw_rectangle(camX+108,camY+102,camX+134,camY+120,false);

//RT
if (objPlayer.inputBoostHold) draw_set_color(c_red);
else draw_set_color(c_white);
draw_rectangle(camX+199,camY+102,camX+225,camY+120,false);
draw_set_color(c_white);
*/
}

draw_text(camX+viewWidth-80,camY+170,objPlayer.currentSpeed);

draw_set_color(c_navy);
draw_rectangle(camX+viewWidth-140,camY+120,camX+viewWidth-40,camY+190,false);
draw_rectangle_color(camX+viewWidth-140,camY+120,camX+viewWidth-140+(100*(objPlayer.comboMultiplier-floor(objPlayer.comboMultiplier))),camY+190,c_aqua,c_white,c_white,c_aqua,false);
draw_set_color(c_black);
draw_set_font(gameFont);
draw_text(camX+viewWidth-128,camY+130,string_format(objPlayer.comboMultiplier,0,1));
draw_set_color(c_white);
draw_text(camX+viewWidth-126,camY+130,string_format(objPlayer.comboMultiplier,0,1));
draw_set_font(fntPlayerHUD);
}
