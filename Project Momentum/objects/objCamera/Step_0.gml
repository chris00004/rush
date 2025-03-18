

camX=camera_get_view_x(view_camera[0]);
camY=camera_get_view_y(view_camera[0]);

switch(camMode)
{
	case CameraMode.FollowPlayer:
	if (instance_exists(following))
	{
		
		//camX = following.x - viewWidth/2 + objPlayer.xspd*4;
		//camY = following.y - viewHeight/2 + objPlayer.yspd*4 +objPlayer.z*0.75;
		camX = lerp(camX, following.x - viewWidth/2 , 0.4);
		camY = lerp(camY, following.y- viewHeight/2 + following.z*0.5, 0.4);
	}
	break;
	
}

camera_set_view_pos(view_camera[0], camX, camY);

//player related
if (instance_exists(objPlayer))
{
	
	//timer for stage
	if (objPlayer.playerState != PlayerState.StageEnd) seconds+=1/60;
	
	if (seconds>60)
	{
		minutes+=1;
		seconds = 0;
	}
	
	if (objPlayer.playerState == PlayerState.Dead)
	{
		minutes = 0;
		seconds = 0;
	}
}

//parallax scrolling for BG
if (layer_exists("BG0"))
{
	layer_x("BG0",camX/1.15);
}

if (layer_exists("BG1"))
{
	layer_x("BG1",camX/1.5);
}

if (layer_exists("BG2"))
{
	layer_x("BG2",camX/2);
}