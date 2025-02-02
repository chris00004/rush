if (active) 
{
	//draw switch turned on
	draw_sprite(sprSwitch,2,x,y);
	//draw energy beam
	draw_set_color(make_color_rgb(182,255,0));
	draw_line_width(x,y,objPlayer.x,objPlayer.y+objPlayer.z,3);
	draw_set_color(make_color_rgb(233,255,178));
	draw_line_width(x,y,objPlayer.x,objPlayer.y+objPlayer.z,2);
	draw_set_color(c_white);
	draw_line_width(x,y,objPlayer.x,objPlayer.y+objPlayer.z,1);
}
//draw switch in range
else if (inRange) draw_sprite(sprSwitch,1,x,y);
//draw switch turned off
else draw_sprite(sprSwitch,0,x,y);
