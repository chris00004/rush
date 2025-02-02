if (instance_exists(objPlayer))
{
draw_text(x+10,y+10,$"xspd: {objPlayer.xspd}");
draw_text(x+10,y+25,$"yspd: {objPlayer.yspd}");
draw_text(x+10,y+40,$"maxSpeed: {objPlayer.movingPlatLock}");
draw_text(x+10,y+55,$"boosting: {objPlayer.boosting}");
draw_text(x+10,y+70,$"abovePit: {objPlayer.abovePit}");
draw_text(x+10,y+85,$"grounded: {objPlayer.grounded}");
draw_text(x+10,y+100,$"z: {objPlayer.z}");
draw_text(x+10,y+115,$"zFloor: {objPlayer.zFloor}");
draw_text(x+10,y+130,$"state: {objPlayer.playerState}");
draw_text(x+10,y+145,$"x: {objPlayer.x}");
draw_text(x+10,y+160,$"y: {objPlayer.y}");
draw_text(x+10,y+175,$"inPriorityRange: {objPlayer.inPriorityRange}");
}



