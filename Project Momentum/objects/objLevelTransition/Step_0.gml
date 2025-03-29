if (active)
{
	if (room==rmTutorialStage) room_goto(rmTropicalRig);
	if (room==rmTropicalRig) room_goto(rmTutorialStage);
}



if (place_meeting(x,y,objPlayer))
{
	image_speed=1;
}
else{
	image_speed=0;
	image_index=4;
}