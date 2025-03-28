draw_sprite(sprPlayerShadow,0,x,y+12+zfloor);

switch(objIntroCutsceneController.animStatePlayer)
{	
	case 3:
		draw_sprite_ext(sprIntroMotherboard,0,x-18,y+z,1,1,30,c_white,1);
	break;
		
	
	case 6:
		switch(frame)
		{
			case 0:
				draw_sprite_ext(sprIntroMotherboard,0,x+19,y-20,1,1,30,c_white,1);
			break;
			case 1:
				draw_sprite_ext(sprIntroMotherboard,0,x+21,y-20,1,1,20,c_white,1);
			break;
			case 2:
			case 3:
			case 4:
			case 5:
				draw_sprite_ext(sprIntroMotherboard,0,x+23,y-21,1,1,10,c_white,1);
			break;
			
			case 6: 
			draw_sprite_ext(sprIntroMotherboard,0,x+17,y-21,1,1,20,c_white,1);
			break;

		}
		
	break;
}

draw_sprite_ext(currentSprite,frame,x,y+z,image_xscale,image_yscale,angle,c_white,1);

switch(objIntroCutsceneController.animStatePlayer)
{
	case 1:
	case 2:
	draw_sprite_ext(sprIntroMotherboard,0,x-18,y-2+z,1,1,30,c_white,1);
	break;
}

//draw_text(x,y-40,objIntroCutsceneController.alarmAnimPlayer);