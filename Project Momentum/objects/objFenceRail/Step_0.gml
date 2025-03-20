if (objPlayer.z<z+zHeight) mask_index = sprEmpty;
else if (objPlayer.zspd==0) mask_index = sprFence;


if (!objPlayer.grounded && objPlayer.zspd>-2 
&& (objPlayer.y>y-25 && objPlayer.y<y)
&& (objPlayer.x>=x-8 && objPlayer.x<=x+55)
&& objPlayer.z>z+zHeight && !objPlayer.fenceSliding)
{
	objPlayer.playerState = PlayerState.ActionRailGrind;
	objPlayer.zspd=0;
	objPlayer.yspd=0;
	objPlayer.grav=0;
	objPlayer.z=z+zHeight-8;
	objPlayer.y=y-10;
}

if (!objPlayer.grounded && (objPlayer.y>y-24 && objPlayer.y<y)
&& (objPlayer.x>=x-8 && objPlayer.x<=x+55) && objPlayer.z<=z+zHeight+4)
{
	objPlayer.dropShadowRails=true;
	dropShadowY=y+zHeight-8;
}
if (objPlayer.z>z+zHeight+4 
|| ((objPlayer.x>=x-8 && objPlayer.x<=x+55) && !(objPlayer.y>y-25 && objPlayer.y<y)))
{
	objPlayer.dropShadowRails=false;
}




/*
if (sliding)
{
	if (slidingDir==1)
	{
		if (objPlayer.y<y) objPlayer.y=y;
	}
	else if (slidingDir==-1)
	{
		if (objPlayer.y>y-22) objPlayer.y=y-22;
	}
	if (objPlayer.grounded) 
	{
		sliding=false;
		slidingDir=0;
	}
}*/

if (objPlayer.y>=y-12) layer = layer_get_id("objectsBG");
else layer = layer_get_id("objectsFG");