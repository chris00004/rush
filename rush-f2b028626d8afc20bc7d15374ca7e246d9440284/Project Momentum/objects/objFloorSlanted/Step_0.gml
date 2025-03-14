z = -(sprite_height+(y-objPlayer.y-13));
if (z<-sprite_height) z = -sprite_height;
if (z>0) z = 0;

//affect player
if (place_meeting(x,y-13,objPlayer) && !onSlope)
{
	onSlope=true
}

if (onSlope && !place_meeting(x,y-13,objPlayer))
{
	
	objPlayer.zTemp=z;
	//objPlayer.z=z/3;
}




