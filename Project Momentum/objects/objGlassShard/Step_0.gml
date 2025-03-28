if (instance_exists(objIntroCutsceneController))
{
	if (objPlayerCutscene.x<objIntroCutsceneController.x-96)
	&& (objIntroCutsceneController.animStatePlayer==14) active=true;
}

if (active)
{
	x+=xspd;

	angle+=angleRotation;

	if (place_meeting(x+xspd,y,objWall))
	{
		if (shardSize==1)
		{
			instance_create_layer(x+3,y-4,layer_get_id("objectsFG"),objGlassShardShatter);
			instance_create_layer(x+3,y+4,layer_get_id("objectsFG"),objGlassShardShatter);
			instance_destroy(self);
		}
	
		if (shardSize==2)
		{
			instance_create_layer(x+3,y-7,layer_get_id("objectsFG"),objGlassShardShatter);
			instance_create_layer(x+6,y,layer_get_id("objectsFG"),objGlassShardShatter);
			instance_create_layer(x+3,y+7,layer_get_id("objectsFG"),objGlassShardShatter);
			instance_destroy(self);
		}
		xspd=-(xspd/2);
		yspd= irandom_range(-2,0);
		angleRotation*=-1;
		bounce=true;
	}

	if (bounce)
	{
		xspd-=decceleration;
		if (xspd-decceleration<0) xspd=0;
		yspd+=grav;
		y+=yspd;
	}
}