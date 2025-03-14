if (instance_exists(objPlayer))
{
	if (objPlayer.playerState == PlayerState.DialogueNPC)
	{
		//draw fade
		draw_sprite_ext(sprScreenBlack,0,objCamera.camX,objCamera.camY,1,1,0,c_black,alpha);
		//draw player portrait
		draw_sprite(sprPortraitFlame,1,objCamera.camX+playerPortraitX-2,objCamera.camY+29);
		draw_sprite(sprPortraitFlame,0,objCamera.camX+playerPortraitX,objCamera.camY+31);
		//draw npc portrait
		draw_sprite(sprPortraitNPCTest,0,objCamera.camX+npcPortraitX,objCamera.camY+8);
		//draw hud
		draw_sprite(sprNpcHud,0,objCamera.camX,objCamera.camY);
		
		if (npcPortraitX<250)
		{
			draw_sprite(sprNpcHudAccents0,frame0,objCamera.camX+394,objCamera.camY+20);
			draw_sprite(sprNpcHudAccents1,frame1,objCamera.camX+387,objCamera.camY+98);
			draw_sprite(sprNpcHudAccents2,frame2,objCamera.camX+419,objCamera.camY+95);
		}
		draw_set_color(c_black);
		draw_text(objCamera.camX+80,objCamera.camY+200,text);
		draw_set_color(c_white);
		draw_text(objCamera.camX+81,objCamera.camY+200,text);
	}
}