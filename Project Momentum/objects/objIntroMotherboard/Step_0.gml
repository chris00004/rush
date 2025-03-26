
	frameDelay--;
	if (frameDelay<0)
	{
		x+=xspd;
		frameDelay=2;
	}

	if (x>5070) x=4710;
