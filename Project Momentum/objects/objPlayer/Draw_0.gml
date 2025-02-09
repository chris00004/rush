if (playerState != PlayerState.Dead)
{
		draw_sprite(sprPlayerShadow, 0, x, y+zFloor+13);
		if (inputRight && z==zFloor) draw_sprite(sprFlameRunR, animFrameRun, x, y+z);
		else if (inputLeft && z==zFloor) draw_sprite(sprFlameRunL, animFrameRun, x, y+z);
		else if (inputDown && z==zFloor) draw_sprite(sprFlameRunF, animFrameRun, x, y+z);
		else if (inputUp && z==zFloor) draw_sprite(sprFlameRunB, animFrameRun, x, y+z);
		else if (playerState == PlayerState.BasicAttack)
		{
			switch(attackState)
			{
				case AttackType.Punch0: draw_sprite(sprFlamePunch0R, 2, x, y+z)
				break;
				case AttackType.Punch1: draw_sprite(sprFlamePunch1R, 2, x, y+z)
				break;
				case AttackType.Kick: draw_sprite(sprFlamePunch1R, 0, x, y+z)
				break;
				
			}
		}
		else if (!grounded) draw_sprite(sprFlameJump, 1, x, y+z);
		else draw_sprite(sprFlameIdleR, animFrameIdle, x, y+z);
		
		//boost icon
		/*
		if (!boostRecovery) draw_sprite(sprBoostMeter,round(20-(boostMeter/13)),x-12,y-12+z);
		else draw_sprite(sprBoostMeterRecovery,round(20-(boostMeter/13)),x-12,y-12+z);*/

}
else if (playerState == PlayerState.Dead)
{
	draw_sprite(sprPlayerDeathIcon, 0, x, y+zFloor+13);
}

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

draw_text(x+24,y-6,currentSpeed);
draw_text(x+24,y+6,xspd);
draw_text(x+24,y+18,maxSpeedNormal);

draw_set_color(c_red)
if (godMode==1) draw_text(x-20,y-56+z,"[GOD MODE]\nSPACE - ascend\nSHIFT - descend");










