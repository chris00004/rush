switch (state)
{
	//gets thrown
	case 0:
		angle-=10;
		
		xspd=-7.5;
		zspd=-0.2;
		
		x+=xspd;
		z+=zspd;
	
		if (place_meeting(x,y,objGuardCutscene))
		{
			state++;
			xspd=-.95;
			zspd=-4;
		}
	break;
	
	//hit guard
	case 1:
	
		angle+=30;
		zspd+=grav;
		
		x+=xspd;
		z+=zspd;
		y+=0.25;
		
		
	
		if (z>0)
		{
			z=0;
			xspd=0;
			yspd=0;
			zspd=0;
			grav=0;
			state++;
		}
	break;
}