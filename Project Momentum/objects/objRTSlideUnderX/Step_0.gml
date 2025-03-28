if (objPlayer.playerState == PlayerState.Sliding)
{
	mask_index = sprEmpty;
}
else mask_index = sprTRSlideUnderXMask;

if (objPlayer.y<=y+90
|| objPlayer.playerState == PlayerState.Sliding) layer = layer_get_id("objectsFG");
else layer = layer_get_id("objectsBG");