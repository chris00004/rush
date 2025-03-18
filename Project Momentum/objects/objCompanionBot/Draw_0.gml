draw_sprite(sprCampanionBotBody,0,x,y+z);
draw_sprite_ext(sprCampanionBotHead,0,x+headX,y+headY+z,1,1,angleHead,c_white,1);

draw_set_font(fntPlayerHUD);
draw_text(x+10,y-12,gamepadActive);
draw_text(x+10,y,"");