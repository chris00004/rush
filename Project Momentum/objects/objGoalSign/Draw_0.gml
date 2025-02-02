angle++;
draw_sprite(sprGoalPlate,0,x,y);
draw_sprite(sprGoalSign,0,x,y-64);
draw_sprite_ext(sprGoalAccents,1,x,y-64,1,1,angle*1.5,c_white,1);
draw_sprite_ext(sprGoalAccents,0,x,y-64,1,1,angle*3,c_white,1);
