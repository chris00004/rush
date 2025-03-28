if (instance_exists(objPlayer))
{
//position
x = objPlayer.x+objPlayer.xspd;
y = objPlayer.y+objPlayer.yspd+13;

//angle

	a=objPlayer.xspd;
	b=objPlayer.yspd;
	c=sqrt((a*a)+(b*b));
	sinB = b*sin(90)/c;
	if (sinB>-1 && sinB<1) angle = arcsin(sinB);
	if (objPlayer.xspd>0)image_angle = -angle*(180/pi);
	if (objPlayer.xspd<0)image_angle = angle*(180/pi)+180;
	if (objPlayer.xspd==0)
	{
		if (objPlayer.yspd<0) image_angle = 90;
		if (objPlayer.yspd>0) image_angle = 270;
	}


	if (objPlayer.playerState==PlayerState.Sliding) active=true;
else active=false;

if (active) image_alpha = 1;
else image_alpha = 0;

}

