
if (active)
{
	//not stationary
	lockedPosition=false;
	
	x+=xspd;
	y+=yspd;
	
	switch(dir)
	{
		//up
		case 0:
		xspd=0;
		yspd=-spd;
		if (y<initialY-range)
		{
			active=false;
			y=initialY-range;
			xspd=0;
			yspd=0;
			dir=2;//down
		}
		break;
		
		//right
		case 1:
		xspd=spd;
		yspd=0;
		
		if (x>initialX+range)
		{	
			active=false;
			x=initialX+range;
			xspd=0;
			yspd=0;
			dir=3;//left
		}
		break;
		
		//down
		case 2:
		yspd=spd;
		xspd=0;
		if (y>initialY+range)
		{
			active=false;
			y=initialY+range;
			xspd=0;
			yspd=0;
			dir=0;//up
		}
		break;
		
		//left
		case 3:
		xspd=-spd;
		yspd=0;
		if (x<initialX-range)
		{
			active=false;
			x=initialX-range;
			xspd=0;
			yspd=0;
			dir=1;//right
		}
		break;
	}
	
	//guard rail barrier for player
	if (objPlayer.x>x+24) 
	{
		objPlayer.x=x+24;
		objPlayer.xspd=0;
	}
	if (objPlayer.x<x-24) 
	{
		objPlayer.x=x-24;
		objPlayer.xspd=0;
	}
	if (objPlayer.y>y+6)
	{
		objPlayer.y=y+6;
		objPlayer.yspd=0;
	}
	if (objPlayer.y<y-30) 
	{
		objPlayer.y=y-30;
		objPlayer.yspd=0;
	}
}




//PLAYER
if (!active && !lockedPosition)
{
	if (!objPlayer.grounded) lockedPosition=true;
}

if (place_meeting(x,y,objPlayer)) && (objPlayer.grounded) && (lockedPosition)
{
	alarmMove--;
	if (alarmMove<0)
	{
		addToPlayerSpd=true;
		active=true;
		alarmMove=20;
	}
}

if ((!place_meeting(x,y,objPlayer)) || (!objPlayer.grounded)) && (addToPlayerSpd)
{
	addToPlayerSpd=false; 
	objPlayer.xspd+=xspd;
	objPlayer.yspd+=yspd;
	objPlayer.movingPlatSpdX = 0;
	objPlayer.movingPlatSpdY = 0;
}


if (addToPlayerSpd)
{
	objPlayer.movingPlatSpdX = xspd;
	objPlayer.movingPlatSpdY = yspd;
}


