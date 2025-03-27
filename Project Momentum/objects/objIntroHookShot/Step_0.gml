angle-=20;

x+=xspd;
y+=yspd;
z+=zspd;

switch (state)
{
	//shoot
	case 0:
	xspd=7;
	zspd=1.6;
	if (place_meeting(x,y,objPlayerCutscene))
	{
		xspd=0;
		zspd=0;
		state++;
	}
	break;
	//hit player
	case 1:
	x=objPlayerCutscene.x-6;
	y=objPlayerCutscene.y+6+objPlayerCutscene.z;
	break;
}