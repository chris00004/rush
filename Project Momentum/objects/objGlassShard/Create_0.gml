shardSize= 2;
xspd=-11;
if (shardSize==0) xspd=irandom_range(-6,-8);
if (shardSize==1) xspd=irandom_range(-8,-11);
if (shardSize==2) xspd=irandom_range(-9,-12);
yspd=0;
grav=0.06;
decceleration=0.05;
angle=0;
angleRotation=20;
if (shardSize==1) angleRotation=13;
if (shardSize==2) angleRotation=6;

frame = irandom_range(0,5);

bounce=false;

active=false;