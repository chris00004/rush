enum CameraMode
{
	FollowPlayer,
	//MoveToTarget,
	//MoveToFollowTarget,
	IntroCustscene,
}

camMode=0;
if (room==rmIntroCutsceneStage) camMode=1;

if (room = rmCompanionTest) following = objCompanionBot;
else following = objPlayer;
camX=camera_get_view_x(view_camera[0]);
camY=camera_get_view_y(view_camera[0]);
viewWidth = camera_get_view_width(view_camera[0]);
viewHeight = camera_get_view_height(view_camera[0]);

//smoothing
lerpCamX = camX;
lerpCamY = camY;
//controls
showControls = false;

//alpha
alpha = 0;

seconds = 0;
minutes = 0;

gameFont = font_add_sprite_ext(sprGameFont, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,!?-0123456789", true, 0);
gameFontSmall = font_add_sprite_ext(sprGameFontSmall, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,!?-0123456789", true, 0);
draw_set_font(fntPlayerHUD);