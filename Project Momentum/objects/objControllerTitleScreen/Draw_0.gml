

	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_set_font(fntTest);
if (room == rmTitleScreen) 
{
	//draw title screen bg
draw_sprite(sprTitleScreen,0,0,0);
//draw title screen logo
draw_sprite(sprTitleScreen,1,0,0);
//draw title screen test menu
draw_sprite(sprTitleScreen,2,0,0);
//draw accents
for (i=0; i<array_length(titleAccents); i++)
{
	draw_sprite_ext(sprTitleScreenAccents0,titleAccents[i][0],titleAccents[i][1],titleAccents[i][2],1,1,titleAccents[i][3],c_white,1);
}

	draw_text(304,185,"[C]");
	draw_text(260,215,"[F]");
}



if (room == rmControlsScreen) 
{
	draw_text(40,2,"[M]");
}