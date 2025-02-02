//position
x = objPlayer.x+objPlayer.xspd;
y = objPlayer.y+objPlayer.yspd+13;

//angle
//angle
if (mode==-1)
{
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
}

if (mode==1)
{
	if (gamepad_axis_value(0, gp_axislh)>deadZone || gamepad_axis_value(0, gp_axislh)<-deadZone 
	|| gamepad_axis_value(0, gp_axislv)<-deadZone || gamepad_axis_value(0, gp_axislv)>deadZone) gamepadActive = true;
	else gamepadActive = false;

	joystickAngle = point_direction(0,0,gamepad_axis_value(0,gp_axislh),gamepad_axis_value(0,gp_axislv))
	if (gamepadActive) image_angle = joystickAngle;
}

if (draw == 1) image_alpha = 1;
else image_alpha = 0;