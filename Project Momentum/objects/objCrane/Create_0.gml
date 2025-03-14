enum CraneState{
	Idle,
	Moving
}

//inherit parent event
event_inherited();

targetType = 0; // 0 - single target location // 1 - can target left or right

z=-96;
iX=x;
xspd=2;
maxDistance = 96;
position = -1; // (-1)-left / (1)-right
x=iX+maxDistance*position;
state = CraneState.Idle;
dist = 0;
craneActive=false;


