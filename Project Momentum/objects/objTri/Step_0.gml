if ((place_meeting(x,y,objPlayer)) && (objPlayer.z>z-6 && objPlayer.z<z+6) && (active))
{
	active = false;
	objPlayer.tris++;
	objPlayer.boostMeter+=10;
}

if (!active)
{
	image_index = 1;
	spd+=0.2;
	move_towards_point(objCamera.camX+55,objCamera.camY+20,spd);
	if (x<objCamera.camX+60 && y<objCamera.camY+25)
	{
		
		instance_destroy(self);
	}
}