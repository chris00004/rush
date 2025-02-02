// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrLoadInputsPlayer(){

//keyboard
keyRight = keyboard_check(ord("D"));
keyLeft = keyboard_check(ord("A"));
keyUp = keyboard_check(ord("W"));
keyDown = keyboard_check(ord("S"));
keyAction = keyboard_check_pressed(ord("K")); //X
keyActionHold = keyboard_check(ord("K")); //X
keyActionSecondary = keyboard_check_pressed(ord("I")); //Y
keyActionLeft = keyboard_check_pressed(ord("Q")); //LB
keyActionRight = keyboard_check_pressed(ord("E")); //RB
keyJump = keyboard_check_pressed(vk_space); //A
keyBoost = keyboard_check(vk_lshift); //RT
keyStomp = keyboard_check_pressed(ord("L")); //B

//gamepad
buttonRight = gamepad_button_check(0,gp_padr);
buttonLeft = gamepad_button_check(0,gp_padl);
buttonUp = gamepad_button_check(0,gp_padu);
buttonDown = gamepad_button_check(0,gp_padd);
buttonAction = gamepad_button_check_pressed(0,gp_face3);
buttonActionHold = gamepad_button_check(0,gp_face3);
buttonActionSecondary = gamepad_button_check_pressed(0,gp_face4); 
buttonActionLeft = gamepad_button_check_pressed(0,gp_shoulderl);
buttonActionRight = gamepad_button_check_pressed(0,gp_shoulderr);
buttonJump = gamepad_button_check_pressed(0,gp_face1);
buttonBoost = gamepad_button_check(0,gp_shoulderrb);
buttonStomp = gamepad_button_check_pressed(0,gp_face2);

//input handling
inputRight = (keyRight || buttonRight || (gamepad_axis_value(0, gp_axislh)>deadZone));
inputLeft = (keyLeft || buttonLeft || (gamepad_axis_value(0, gp_axislh)<-deadZone));
inputUp = (keyUp || buttonUp || (gamepad_axis_value(0, gp_axislv)<-deadZone));
inputDown = (keyDown || buttonDown || (gamepad_axis_value(0, gp_axislv)>deadZone));
inputAction = (keyAction || buttonAction);
inputActionHold = (keyActionHold || buttonActionHold);
inputActionSecondary = (keyActionSecondary || buttonActionSecondary);
inputActionLeft = (keyActionLeft || buttonActionLeft);
inputActionRight = (keyActionRight || buttonActionRight);
inputJump = (keyJump || buttonJump);
inputBoost = (keyBoost || buttonBoost);
inputStomp = (keyStomp || buttonStomp);

}