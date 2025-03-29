if (active)
{
	if (room==rmTutorialStage) room_goto(rmTropicalRig);
}



if (place_meeting(x,y,objPlayer))
{
	image_speed=0;
	image_index=9;
	if (room==rmTropicalRig) room_goto(rmThankYou);
}
else{
	image_speed=1;
}