if ((place_meeting(x,y,objPlayer)) && (objPlayer.playerState = PlayerState.ActionDashRamp) && (objPlayer.z>=-6) && (objPlayer.dashRampActive))
{
	if (!posLock)
	{
		objPlayer.x=x;
		objPlayer.y=y;
		objPlayer.zspd = zspd;
		posLock=true;
	}
	objPlayer.xspdReturned = xspd*image_xscale;
	objPlayer.yspdReturned = yspd;
	objPlayer.dashRampActive = false;
	
}
else posLock=false;