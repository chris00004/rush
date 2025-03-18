switch(frame)
{
	case 0:
	
	case 3:
	
	case 4:
	case 5:
	case 7:
	case 8:
	case 9:
	draw_sprite(sprFlameIntroFrames,frame,0,0);
	break;
	
	case 1:
	
	if (frameAlarm>125) draw_sprite(sprIntroHeart,0,0,0);
	else draw_sprite(sprIntroHeart,animFrame1,0,0);
	
	if (frameAlarm>135) draw_sprite(sprIntroHeartSplit,animFrame0,0,0);
	
	
	
	break;
	case 2:
	layer_background_visible(layer_background_get_id("blackBG") ,false);
	draw_sprite(sprIntroHookLine,animFrame0,0,0);
	break;
	case 6:
	layer_background_visible(layer_background_get_id("sunBG") ,false);
	layer_background_visible(layer_background_get_id("farBG") ,false);
	layer_background_visible(layer_background_get_id("closeBG") ,false);
	draw_sprite(sprIntroShadowBG,animFrame0,0,0);
	draw_sprite(sprIntroEnemies,animFrame0,0,0);
	draw_sprite(sprIntroElectricity,animFrame0,0,0);
	draw_sprite(sprIntroEnemySawblades,0,0,0);
	break;
}