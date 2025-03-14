

frameAlarm--;
if (frameAlarm<0) 
{
	if (frame==0) frameAlarm = 200;
	else if (frame==1) frameAlarm = 220;
	else frameAlarm = 180;
	frame++;
	
	//reset animation varibles
	animAlarm0 = 4;
	animFrame = 0;
}

//animate
	animAlarm0--;
	if (animAlarm0<0) 
	{
		animAlarm0 = 4;
		animFrame0++;
	}
	
	//special case
	if (frameAlarm<=125 && frameAlarm>110)
	{
		animAlarm1--;
		if (animAlarm1<0) 
		{
			animAlarm1 = 4;
			animFrame1++;
		}
	}
	
	if (frame>9) || (keyboard_check_pressed(ord("S"))) 
	{
		room_goto(rmStage01);
		audio_stop_sound(sndTestAudio);
	}