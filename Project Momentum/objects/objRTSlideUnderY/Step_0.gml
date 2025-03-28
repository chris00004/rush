if (objPlayer.playerState == PlayerState.Sliding)
{
	mask_index = sprEmpty;
}
else mask_index = sprTRSlideUnderY;

if (objPlayer.y<=y+64 
|| objPlayer.playerState == PlayerState.Sliding) layer = layer_get_id("objectsFG");
else layer = layer_get_id("objectsBG");