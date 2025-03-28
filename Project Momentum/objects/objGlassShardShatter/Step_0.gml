x+=xspd;

angle+=angleRotation;

	xspd-=decceleration;
	if (xspd-decceleration<0) xspd=0;
	yspd+=grav;
	y+=yspd;
