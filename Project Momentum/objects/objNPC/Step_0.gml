if (objPlayer.y+13>=y) depth = 400;
else depth = 100;

if (point_distance(x,y,objPlayer.x,objPlayer.y+13)<=48) inPlayerRange = true;
else inPlayerRange = false;

switch (npcType)
{
	case NPCCharacter.Test:
	{
		dialogue = "TEST: This place used to be fruitful you know.@";
	}
}