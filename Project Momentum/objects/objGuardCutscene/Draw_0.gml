if (instance_exists(objIntroHookShot))
{
	draw_line_width_colour(x+29, y-29, objIntroHookShot.x, objIntroHookShot.y+objIntroHookShot.z, 1.5, c_black, c_red);
}

if (currentSprite == sprIntroGuardShootHook)
{
	switch (frame)
	{
		case 4:
			draw_sprite_ext(sprTriHookFull,0,x-14,y-60,1,1,40,c_white,1);
		break;
		case 5:
			draw_sprite_ext(sprTriHookFull,0,x+14,y-45,1,1,50,c_white,1);
		break;
		case 6:
			draw_sprite_ext(sprTriHookFull,0,x+21,y-23,1,1,-7,c_white,1);
		break;
		case 7:
		case 8:
		case 9:
			draw_sprite_ext(sprTriHookFull,0,x+21,y-24,1,1,-7,c_white,1);
		break;
		case 10:
			draw_sprite_ext(sprTriHookFull,1,x+19,y-24,1,1,-7,c_white,1);
		break;
		case 11:
			draw_sprite_ext(sprTriHookFull,1,x+20,y-24,1,1,-7,c_white,1);
		break;	
		case 12:
			draw_sprite_ext(sprTriHookFull,1,x+21,y-24,1,1,-7,c_white,1);
		break;
	}
}


draw_sprite_ext(sprPlayerShadow,0,x,y+12,1,1,0,c_black,0.6);
draw_sprite_ext(currentSprite,frame,x,y+z,image_xscale,image_yscale,angle,c_white,1);
//draw_text(x+48,y-32,objIntroCutsceneController.animStateGuard);
//draw_text(x+48,y-16,fps);