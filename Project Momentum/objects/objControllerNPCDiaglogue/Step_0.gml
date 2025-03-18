if (objPlayer.playerState == PlayerState.DialogueNPC)
{

//keyboard
keyRight = keyboard_check(ord("D"));
keyLeft = keyboard_check(ord("A"));
keyUp = keyboard_check(ord("W"));
keyDown = keyboard_check(ord("S"));
keyAccept = keyboard_check_pressed(vk_space); //A
keyExit = keyboard_check_pressed(ord("L")); //B

//gamepad
buttonRight = gamepad_button_check(0,gp_padr);
buttonLeft = gamepad_button_check(0,gp_padl);
buttonUp = gamepad_button_check(0,gp_padu);
buttonDown = gamepad_button_check(0,gp_padd);
buttonAccept = gamepad_button_check_pressed(0,gp_face1);
buttonExit = gamepad_button_check_pressed(0,gp_face2);

//input handling
inputRight = (keyRight || buttonRight || (gamepad_axis_value(0, gp_axislh)>deadZone));
inputLeft = (keyLeft || buttonLeft || (gamepad_axis_value(0, gp_axislh)<-deadZone));
inputUp = (keyUp || buttonUp || (gamepad_axis_value(0, gp_axislv)<-deadZone));
inputDown = (keyDown || buttonDown || (gamepad_axis_value(0, gp_axislv)>deadZone));
inputAccept = (keyAccept || buttonAccept);
inputExit = (keyExit || buttonExit);


//dialogue controls
if (inputExit) 
{
	active = false;
	
	//reset animation
	alpha = 0;
	playerPortraitX = -96;
	npcPortraitX = 480;
	frame0=0;
	frame1=0;
	frame2=0;
	file_text_close(dialogueFile);
	text = "";
	fileOpen = false;
}
if (active) 
{
	if (!fileOpen)
	{
		dialogueFile = file_text_open_read("testDialogue.txt");
		fileOpen = true;
	}
	alpha = lerp(alpha,0.75,0.12);
	playerPortraitX = lerp(playerPortraitX,20,0.15);
	npcPortraitX = lerp(npcPortraitX,240,0.1);
	if (npcPortraitX<250)
	{
		alarmFrame--;
		if (alarmFrame<0)
		{
			alarmFrame = 3;
			frame0++;
			frame1++;
			frame2++;
		}
		if (frame0>13) frame0 = 14;
		if (frame1>18) frame1 = 19;
		if (frame2>7) frame2 = 8;
	}
}

if (inputAccept) text = file_text_readln(dialogueFile);
}

