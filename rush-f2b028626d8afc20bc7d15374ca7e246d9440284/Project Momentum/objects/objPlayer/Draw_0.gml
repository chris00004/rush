if (playerState != PlayerState.Dead)
{
		draw_sprite(sprPlayerShadow, 0, x, y+zFloor+13);
		if (playerState == PlayerState.Sliding) draw_sprite(sprAnimSlide, animFrameRun, x, y+z);
		else if (inputRight && z==zFloor) draw_sprite(sprXRunRight, animFrameRun, x, y+z);
		else if (inputLeft && z==zFloor) draw_sprite(sprXRunLeft, animFrameRun, x, y+z);
		else if (inputDown && z==zFloor) draw_sprite(sprXRunDown_1, animFrameRun, x, y+z);
		else if (inputUp && z==zFloor) draw_sprite(sprXRunUp, animFrameRun, x, y+z);
		else if (playerState == PlayerState.BasicAttack)
		{
			switch(attackState)
			{
				case AttackType.Idle:
				draw_sprite(sprXFallRight, 0, x, y+z);
				break;
				
				case AttackType.Punch: 
				if (attackType==0 || attackType == 2) draw_sprite_ext(sprFlamePunch0R, 2, x, y+z, 1, 1, 0, c_yellow, 1);
				else draw_sprite_ext(sprFlamePunch1R, 2, x, y+z, 1, 1, 0, c_blue, 1);
				break;
				
				case AttackType.ReverseKick: 
				draw_sprite_ext(sprAnimAttackReverseKick, 0, x, y+z, 1, 1, 0, c_white, 1);
				break;
				
				case AttackType.SlamStrike: 
				draw_sprite_ext(sprAnimAttackSlam, 0, x, y+z, 1, 1, 0, c_white, 1);
				break;
				
				case AttackType.Launcher: 
				draw_sprite_ext(sprAnimAttackLaunch, 0, x, y+z, 1, 1, 0, c_white, 1);
				break;
				
				case AttackType.ComboExtender: 
				draw_sprite_ext(sprFlamePunch0R, 2, x, y+z, 1, 1, 0, c_green, 1);
				break;
				
				case AttackType.Grab: 
				draw_sprite_ext(sprFlamePunch1R, 2, x, y+z, 1, 1, 0, c_red, 1);
				break;
				
				case AttackType.GrabChuckBack:
				draw_sprite_ext(sprFlamePunch1R, 2, x, y+z, 1, 1, 0, c_purple, 1);
				
				case AttackType.GrabChuck:
				draw_sprite_ext(sprFlamePunch1R, 2, x, y+z, 1, 1, 0, c_purple, 1);
			}
		}
		
		//draws left or right air sprites depending on speed and what side they're attached to the enemy
		else if (!grounded && xspd >= 0 && attachSide != 1) draw_sprite_ext(sprXFallRight, 0, x, y+z, 1, 1, 0, c_white, 1);
		else if (!grounded && (xspd < 0 || attachSide = 1)) draw_sprite_ext(sprXFallRight, 0, x, y+z, -1, 1, 0, c_white, 1);
		
		else draw_sprite(sprXIdleRight, animFrameIdle, x, y+z);
		
		//boost icon
		/*
		if (!boostRecovery) draw_sprite(sprBoostMeter,round(20-(boostMeter/13)),x-12,y-12+z);
		else draw_sprite(sprBoostMeterRecovery,round(20-(boostMeter/13)),x-12,y-12+z);*/

}
else if (playerState == PlayerState.Dead)
{
	draw_sprite(sprPlayerDeathIcon, 0, x, y+zFloor+13);
}

draw_sprite(sprPlayerHitBox,0,x,y);

/*
draw_text(x+24,y-30,$"X_SPD: {xspd}");
draw_text(x+24,y-18,$"X_MAX: {xMax}");
draw_text(x+24,y-6,$"X_ACC: {newSpeedX}");
draw_text(x+24,y+6,$"Y_SPD: {yspd}");
draw_text(x+24,y+18,$"Y_MAX: {yMax}");
draw_text(x+24,y+30,$"Y_ACC: {newSpeedY}");*/


//draw_text(x+24,y-30,$"X_AXIS: {gamepad_axis_value(0,gp_axislh)}");
//draw_text(x+24,y-18,$"Y_AXIS: {gamepad_axis_value(0,gp_axislv)}");

//draw_text(x+24,y-6,$"X_SPD: {xspd}");
//draw_text(x+24,y+6,$"Y_SPD: {yspd}");

draw_text(x+24,y-6,lightAttackCount);
draw_text(x+24,y+6,heavyCharges);
draw_text(x+24,y+18,movementDirection);
draw_text(x+24,y-30, maxSpeedNormal);

switch(heavyCharges)
{
	case 1:
	draw_rectangle_color(x-20,y-29+z,x-10,y-23+z,c_white,c_white,c_aqua,c_aqua,false);
	break;
	
	case 2:
	draw_rectangle_color(x-20,y-29+z,x-10,y-23+z,c_white,c_white,c_aqua,c_aqua,false);
	draw_rectangle_color(x-7,y-29+z,x+3,y-23+z,c_white,c_white,c_aqua,c_aqua,false);
	break;
	
	case 3:
	draw_rectangle_color(x-20,y-29+z,x-10,y-23+z,c_white,c_white,c_aqua,c_aqua,false);
	draw_rectangle_color(x-7,y-29+z,x+3,y-23+z,c_white,c_white,c_aqua,c_aqua,false);
	draw_rectangle_color(x+6,y-29+z,x+16,y-23+z,c_white,c_white,c_aqua,c_aqua,false);
	break;
	
	case 4:
	draw_rectangle_color(x-20,y-29+z,x-10,y-23+z,c_white,c_white,c_aqua,c_aqua,false);
	draw_rectangle_color(x-7,y-29+z,x+3,y-23+z,c_white,c_white,c_aqua,c_aqua,false);
	draw_rectangle_color(x+6,y-29+z,x+16,y-23+z,c_white,c_white,c_aqua,c_aqua,false);
	draw_rectangle_color(x+19,y-29+z,x+29,y-23+z,c_white,c_white,c_aqua,c_aqua,false);
	break;
}


draw_set_color(c_red);
if (godMode==1) draw_text(x-20,y-56+z,"[GOD MODE]\nSPACE - ascend\nSHIFT - descend");












