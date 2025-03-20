switch (tint)
{
	case 0:
	color=c_white;
	break;
	case 1:
	color=c_ltgray;
	break;
	case 2:
	color=c_grey;
	break;
	case 3:
	color=c_dkgrey;
	break;
	case 4:
	color=c_black;
	break;
}

draw_sprite_ext(sprWorker,frame,x,y,1,1,0,color,1);