if (active)
{
	switch(shardSize)
	{
		case 0:
		{
			draw_sprite_ext(sprGlassShardsSmall,frame,x,y,1,1,angle,c_white,1);
		}
		break;
		case 1:
		{
			draw_sprite_ext(sprGlassShardsMed,0,x,y,1,1,angle,c_white,1);
		}
		break;
		case 2:
		{
			draw_sprite_ext(sprGlassShardsLarge,0,x,y,1,1,angle,c_white,1);
		}
		break;
	}
}