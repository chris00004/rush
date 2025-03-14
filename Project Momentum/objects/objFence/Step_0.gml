if (objPlayer.z<z+zHeight) mask_index = sprEmpty;
else if (objPlayer.zspd==0) mask_index = sprFence;


if (!objPlayer.grounded && objPlayer.zspd>0 
&& (objPlayer.y>y-20 && objPlayer.y<y+12)
&& (objPlayer.x>=x && objPlayer.x<=x+48)
&& objPlayer.z>z+zHeight)
{
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
		slidingDir=0;
	}
}

if (objPlayer.y>=y-8) layer = layer_get_id("objectsBG");
else layer = layer_get_id("objectsFG");