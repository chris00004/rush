if (objPlayer.z<z+zHeight) mask_index = sprEmpty;
else if (objPlayer.zspd==0) mask_index = sprFence;


if (!objPlayer.grounded && objPlayer.zspd>0 
&& (objPlayer.y>y-20 && objPlayer.y<y+12)
&& (objPlayer.x>=x-9 && objPlayer.x<=x+56)
&& objPlayer.z>z+zHeight)
{
	objPlayer.fenceSliding=true;
	sliding=true;
	if (objPlayer.y<=y-10) slidingDir=-1;
	if (objPlayer.y>y-10) slidingDir=1;
}

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
		objPlayer.fenceSliding=false;
		slidingDir=0;
	}
}

if (objPlayer.y>=y-12) layer = layer_get_id("objectsBG");
else layer = layer_get_id("objectsFG");