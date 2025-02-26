function scrLoadInputsPlayer(){

//KEYBOARD --------------------------------------------------------------
//pressing
keyRight = keyboard_check(ord("D"));
keyLeft = keyboard_check(ord("A"));
keyUp = keyboard_check(ord("W"));
keyDown = keyboard_check(ord("S"));
keyAction = keyboard_check_pressed(ord("K")); //X
keyActionSecondary = keyboard_check_pressed(ord("I")); //Y
keyActionLeft = keyboard_check_pressed(ord("Q")); //LB
keyActionRight = keyboard_check_pressed(ord("E")); //RB
keyJump = keyboard_check_pressed(vk_space); //A
keyStomp = keyboard_check_pressed(ord("L")); //B

//holding
keyJumpHold = keyboard_check(vk_space); //A
keyStompHold = keyboard_check(ord("L")); //B
keyActionHold = keyboard_check(ord("K")); //X
keyActionSecondaryHold = keyboard_check(ord("I")); //Y
keyBoostHold = keyboard_check(vk_lshift); //RT

//gamepad
buttonRight = gamepad_button_check(0,gp_padr);
buttonLeft = gamepad_button_check(0,gp_padl);
buttonUp = gamepad_button_check(0,gp_padu);
buttonDown = gamepad_button_check(0,gp_padd);
buttonAction = gamepad_button_check_pressed(0,gp_face3);
buttonActionSecondary = gamepad_button_check_pressed(0,gp_face4); 
buttonActionLeft = gamepad_button_check_pressed(0,gp_shoulderl);
buttonActionRight = gamepad_button_check_pressed(0,gp_shoulderr);
buttonJump = gamepad_button_check_pressed(0,gp_face1);
buttonStomp = gamepad_button_check_pressed(0,gp_face2);

buttonJumpHold = gamepad_button_check(0,gp_face1); //A
buttonStompHold = gamepad_button_check(0,gp_face2); //B
buttonActionHold = gamepad_button_check(0,gp_face3); //X
buttonActionSecondaryHold = gamepad_button_check(0,gp_face4); //Y
buttonBoostHold = gamepad_button_check(0,gp_shoulderrb);//RT

//input handling
inputRight = (keyRight || buttonRight || (gamepad_axis_value(0, gp_axislh)>deadZone));
inputLeft = (keyLeft || buttonLeft || (gamepad_axis_value(0, gp_axislh)<-deadZone));
inputUp = (keyUp || buttonUp || (gamepad_axis_value(0, gp_axislv)<-deadZone));
inputDown = (keyDown || buttonDown || (gamepad_axis_value(0, gp_axislv)>deadZone));
inputAction = (keyAction || buttonAction);
inputActionSecondary = (keyActionSecondary || buttonActionSecondary);
inputActionLeft = (keyActionLeft || buttonActionLeft);
inputActionRight = (keyActionRight || buttonActionRight);
inputJump = (keyJump || buttonJump);
inputStomp = (keyStomp || buttonStomp);

inputBoostHold = (keyBoostHold || buttonBoostHold); //RT
inputJumpHold = (keyJumpHold || buttonJumpHold); //A
inputStompHold = (keyStompHold || buttonStompHold); //B
inputActionHold = (keyActionHold || buttonActionHold); //X
inputActionSecondaryHold = (keyActionSecondaryHold || buttonActionSecondaryHold);//Y
}