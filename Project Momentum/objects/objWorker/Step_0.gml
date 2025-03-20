alarmFrame--;
alarmAnim--;
if (alarmAnim<0)
{
	if (alarmFrame<0)
	{
		if (frame<3) frame++;
		alarmFrame=5;
	}
}