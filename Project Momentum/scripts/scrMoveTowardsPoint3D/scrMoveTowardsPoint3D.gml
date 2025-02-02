// Function to move towards a 3D point
function scrMoveTowardsPoint3D(targetX, targetY, targetZ, speed) {
    // Calculate the direction vector
    var dirX = targetX - x;
    var dirY = targetY - y;
    var dirZ = targetZ - z;
    
    // Calculate the distance to the target
    var distance = sqrt(dirX * dirX + dirY * dirY + dirZ * dirZ);

    // Normalize the direction vector
    if (distance != 0) {
        dirX /= distance;
        dirY /= distance;
        dirZ /= distance;
    }
	
    // Update the player's position
	xspd=dirX * speed;
	yspd=dirY * speed;
	zspd=dirZ * speed;
	/*
    x += dirX * speed;
    y += dirY * speed;
    z += dirZ * speed;*/

    // Ensure the player doesn't overshoot the target
    if (abs(targetX - x) < speed) x = targetX;
    if (abs(targetY - y) < speed) y = targetY;
    if (abs(targetZ - z) < speed) z = targetZ;
	objPlayer.connectTarget = true;
}
