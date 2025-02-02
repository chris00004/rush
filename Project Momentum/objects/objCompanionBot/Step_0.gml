//----[ INPUTS ]-------------------------------------------------------------------------------------

//keyboard
keyRight = keyboard_check(ord("D"));
keyLeft = keyboard_check(ord("A"));
keyUp = keyboard_check(ord("W"));
keyDown = keyboard_check(ord("S"));

//gamepad
buttonRight = gamepad_button_check(0,gp_padr);
buttonLeft = gamepad_button_check(0,gp_padl);
buttonUp = gamepad_button_check(0,gp_padu);
buttonDown = gamepad_button_check(0,gp_padd);


//input handling
inputRight = (keyRight || buttonRight || (gamepad_axis_value(0, gp_axislh)>deadZone));
inputLeft = (keyLeft || buttonLeft || (gamepad_axis_value(0, gp_axislh)<-deadZone));
inputUp = (keyUp || buttonUp || (gamepad_axis_value(0, gp_axislv)<-deadZone));
inputDown = (keyDown || buttonDown || (gamepad_axis_value(0, gp_axislv)>deadZone));

//----[ MOVEMENT ]-------------------------------------------------------------------------------------

//ACTIVATE KEYBOARD CONTROLS
if (keyboard_check_pressed(vk_anykey)) gamepadActive = false;

//ACTIVATE GAMEPAD CONTROLS
for (var i = gp_face1; i < gp_axisrv; i++ ) 
{
    if (gamepad_button_check_pressed(0, i)) gamepadActive = true;
}

if (gamepad_axis_value(0, gp_axislh)>deadZone || gamepad_axis_value(0, gp_axislh)<-deadZone 
|| gamepad_axis_value(0, gp_axislv)<-deadZone || gamepad_axis_value(0, gp_axislv)>deadZone) gamepadActive = true;


//HANDLE MOVING
if (!inputLock && !movementLock  && !charLock)
{
	//KEYBOARD MOVEMENT
	if (!gamepadActive)
	{
		if (inputRight) movementDirection = 0;
		if (inputLeft) movementDirection = 180;
		if (inputUp) movementDirection = 90;
		if (inputDown) movementDirection = 270;
		if (inputRight && inputUp) movementDirection = 45;
		if (inputLeft && inputUp) movementDirection = 135;
		if (inputRight && inputDown) movementDirection = 315;
		if (inputLeft && inputDown) movementDirection = 225;
	}
	
	//GAMEPAD MOVEMENT
	else if (gamepadActive)
	{
		joystickAngle = point_direction(0,0,gamepad_axis_value(0,gp_axislh),gamepad_axis_value(0,gp_axislv))
		movementDirection = joystickAngle;
	}
	
	//calculate speeds with regard to direction 
	if (inputRight || inputLeft || inputUp || inputDown)
	{
		//cos and sin of acceleration
		angleAccelerationX = acceleration * cos(movementDirection*(pi/180));
		angleAccelerationY = -(acceleration * sin(movementDirection*(pi/180)));
		
		//apply acceleration to player speed
		xspd+=angleAccelerationX;
		yspd+=angleAccelerationY;
	
		// Calculate current speed
		currentSpeed = sqrt(sqr(xspd) + sqr(yspd));

		//CAP SPEED
		if (currentSpeed > maxSpeedNormal) 
		{
			//scale the speed 
			speedScale = maxSpeedNormal / currentSpeed;
			xspd *= speedScale;
			yspd *= speedScale;
		}
	}
}

//DECELERATE X
if ((!inputRight && !inputLeft) || (inputRight && inputLeft) || movementLock)
{
	if (xspd>0)
	{
		if (xspd-acceleration<0)  xspd=0;
		else if (xspd>0) 
		{
			xspd -=decceleration;
		}
	}
	else
	{
		if (xspd+acceleration>0) xspd = 0;
		else if (xspd<0) 
		{
			xspd +=decceleration;
		}
	}
}

//DECELERATE Y
if ((!inputUp && !inputDown) || (inputUp && inputDown) || movementLock)
{
	if (yspd>0)
	{
		if (yspd-acceleration<0)  yspd=0;
		else if (yspd>0) 
		{
			yspd -=decceleration;
		}
	}
	else
	{
		if (yspd+acceleration>0) yspd = 0;
		else if (yspd<0) 
		{
			yspd +=decceleration;
		}
	}
}

///----[ WALL COLLISION ]--------------------------------------------------------------------------------------------

// WALL COLLISION X
if (place_meeting(x+xspd+movingPlatSpdX,y,objWall))
{
	while (!place_meeting(x+sign(xspd+movingPlatSpdX),y,objWall))
	{
		x = x + sign(xspd+movingPlatSpdX);
	}
	xspd=0;
	movingPlatSpdX=0;
}

x+=xspd+movingPlatSpdX;

// WALL COLLISION Y
if (place_meeting(x,y+yspd+movingPlatSpdY,objWall))
{
	while (!place_meeting(x,y+sign(yspd+movingPlatSpdY),objWall))
	{
		y = y + sign(yspd+movingPlatSpdY);
	}
	yspd=0;
	movingPlatSpdY=0;
}

y+=yspd+movingPlatSpdY;

//----[ ANIMATION ]-------------------------------------------------------------------------------------

headXOrigin = 1;
headYOrigin = -15;





//head tilt X
if (inputRight) 
{
	headX = lerp(headX,headXOrigin+4,0.15);
	headY = lerp(headY,headYOrigin+1,0.15);
	angleHead = lerp (angleHead,angleHeadMax,0.2);
}
else if (inputLeft) 
{
	headX = lerp(headX,headXOrigin-5,0.15);
	headY = lerp(headY,headYOrigin+1,0.15);
	angleHead = lerp (angleHead,-angleHeadMax,0.2);
}
else 
{
	headX = lerp(headX,headXOrigin,0.1);
	angleHead = lerp (angleHead,0,0.2);
}
	
//head tilt Y
if (inputDown) headY = lerp(headY,headYOrigin+5,0.15);
else if (inputUp) headY = lerp(headY,headYOrigin-1,0.15);

else 
{
	headY = lerp(headY,headYOrigin,0.1);
}
	