if (keyboard_check_pressed(vk_enter) ||
gamepad_button_check_pressed(0,gp_start))
{
	if (room==rmTitleScreen) room_goto(rmTutorialStage);
}

if (room==rmController) 
	{
		alarmRoom--;
		if (alarmRoom<0)
		{
			room_goto(rmTitleScreen);
		}
	}