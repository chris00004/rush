if (active)
{
	active = false;
	objPlayer.tris++;
	objPlayer.boostMeter+=5;
}

if (!active)
{
	image_index = 1;
	spd+=0.3;
	move_towards_point(objCamera.camX+55,objCamera.camY+20,spd);
	if (x<objCamera.camX+60 && y<objCamera.camY+25)
	{
		
		instance_destroy(self);
	}
}