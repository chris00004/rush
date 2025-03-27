


//movement



x+=xspd;
y+=yspd;
z+=zspd;

if (z>zFloor-24)
{
	//instance_destroy(self);
}

if (place_meeting(x, y, objPlayer) && (z >= objPlayer.z && z <= objPlayer.z + 10)){
objPlayer.playerState = PlayerState.hitByEnemy;
objPlayer.hp -= 1;
objPlayer.zspd = -2;
instance_destroy(self);	
}
if (abs(xspd) > abs(yspd)) 
{
    // Handle X collision first
    if (place_meeting(x + xspd, y, objWall))
    {
        instance_destroy(self);
    }

    // Then handle Y collision
    if (place_meeting(x, y + yspd, objWall))
    {
       instance_destroy(self);
    }
} 
else 
{
    // Handle Y collision first
    if (place_meeting(x, y + yspd, objWall))
    {
       instance_destroy(self);
    }

    // Then handle X collision
    if (place_meeting(x + xspd, y, objWall))
    {
       instance_destroy(self);
    }
}