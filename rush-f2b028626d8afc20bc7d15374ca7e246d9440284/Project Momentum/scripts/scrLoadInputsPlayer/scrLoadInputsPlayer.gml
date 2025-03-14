function scrLoadInputsPlayer(){

//KEYBOARD --------------------------------------------------------------
//pressing
keyRight = keyboard_check(ord("D"));
keyLeft = keyboard_check(ord("A"));
keyUp = keyboard_check(ord("W"));
keyDown = keyboard_check(ord("S"));
keyAction = keyboard_check_pressed(ord("K")); //X
keyActionSecondary = keyboard_check_pressed(ord("J")); //Y
keyActionLeft = keyboard_check_pressed(ord("Q")); //LB
keyActionRight = keyboard_check_pressed(ord("E")); //RB
keyJump = keyboard_check_pressed(vk_space); //A
keyStomp = keyboard_check_pressed(ord("L")); //B
keyBoost = keyboard_check_pressed(vk_lshift); //RT
keyLT = keyboard_check_pressed(vk_lcontrol); //LT

//holding
keyJumpHold = keyboard_check(vk_space); //A
keyStompHold = keyboard_check(ord("L")); //B
keyActionHold = keyboard_check(ord("K")); //X
keyActionSecondaryHold = keyboard_check(ord("J")); //Y
keyActionLeftHold = keyboard_check(ord("Q")); //LB
keyActionRightHold = keyboard_check(ord("E")); //RB
keyBoostHold = keyboard_check(vk_lshift); //RT
keyLTHold = keyboard_check(vk_lcontrol); //LT

//GAMEPAD --------------------------------------------------------------
//pressing
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
buttonBoost = gamepad_button_check_pressed(0,gp_shoulderrb);//RT
buttonLT = gamepad_button_check_pressed(0,gp_shoulderlb);//LT

//holding
buttonJumpHold = gamepad_button_check(0,gp_face1); //A
buttonStompHold = gamepad_button_check(0,gp_face2); //B
buttonActionHold = gamepad_button_check(0,gp_face3); //X
buttonActionSecondaryHold = gamepad_button_check(0,gp_face4); //Y
buttonActionLeftHold = gamepad_button_check(0,gp_shoulderl);
buttonActionRightHold = gamepad_button_check(0,gp_shoulderr);
buttonBoostHold = gamepad_button_check(0,gp_shoulderrb);//RT
buttonLTHold = gamepad_button_check(0,gp_shoulderlb);//LT

//COMBINED INPUTS ------------------------------------------------------
//pressing
inputRight = (keyRight || (gamepad_axis_value(0, gp_axislh)>deadZone));
inputLeft = (keyLeft || (gamepad_axis_value(0, gp_axislh)<-deadZone));
inputUp = (keyUp || (gamepad_axis_value(0, gp_axislv)<-deadZone));
inputDown = (keyDown || (gamepad_axis_value(0, gp_axislv)>deadZone));

//SOCD cleaning
if (inputRight && inputLeft) {
inputRight = !inputRight;
inputLeft = !inputLeft;
}

//SOCD cleaning
if (inputUp && inputDown) {
inputDown = !inputDown;
inputUp = !inputUp;
}

inputAction = (keyAction || buttonAction);
inputActionSecondary = (keyActionSecondary || buttonActionSecondary);
inputActionLeft = (keyActionLeft || buttonActionLeft);
inputActionRight = (keyActionRight || buttonActionRight);
inputJump = (keyJump || buttonJump);
inputStomp = (keyStomp || buttonStomp);
inputBoost = (keyBoost || buttonBoost);
inputLT = (keyLT || buttonLT);

//holding
inputJumpHold = (keyJumpHold || buttonJumpHold); //A
inputStompHold = (keyStompHold || buttonStompHold); //B
inputActionHold = (keyActionHold || buttonActionHold); //X
inputActionSecondaryHold = (keyActionSecondaryHold || buttonActionSecondaryHold);//Y
inputActionLeftHold = (keyActionLeftHold || buttonActionLeftHold); //LB
inputActionRightHold = (keyActionRightHold || buttonActionRightHold); //RB
inputBoostHold = (keyBoostHold || buttonBoostHold); //RT
inputLTHold = (keyLTHold || buttonLTHold);
}