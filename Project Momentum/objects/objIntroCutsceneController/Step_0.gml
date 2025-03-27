//PLAYER
alarmAnimPlayer--;

switch(animStatePlayer)
{
	//idle working
	case 0:
		objPlayerCutscene.xspd=0;
		objPlayerCutscene.yspd=0;
		if (alarmAnimPlayer<0)
		{
			animStatePlayer++;
			alarmAnimPlayer = 35;
			objPlayerCutscene.currentSprite=sprIntroPlayerGrabbed;
			objPlayerCutscene.frame=0;
		}
	break;
	
	//get grabbed by guard
	case 1:
		objPlayerCutscene.xspd+=0.2;
		yDeccel+=0.07;
		objPlayerCutscene.yspd=-2.5+yDeccel;
		if (objPlayerCutscene.xspd>1.5) objPlayerCutscene.xspd=1.5;
		if (objPlayerCutscene.yspd>0) objPlayerCutscene.yspd=0;
		
		objPlayerCutscene.z=-12;
		objPlayerCutscene.grav=0;
		
		if (alarmAnimPlayer<0) 
		{
			animStatePlayer++;
			objPlayerCutscene.zspd=1;
			objPlayerCutscene.yspd=0;
			objPlayerCutscene.xspd=4;
			objPlayerCutscene.grav=0.16;
		}
	break;
	
	//thrown by guard
	case 2:

	if (objPlayerCutscene.grounded) 
	{
		animStatePlayer++;
		alarmAnimPlayer=180;
		objPlayerCutscene.currentSprite=sprIntroPlayerSliding;
		objPlayerCutscene.frame=0;
	}
	break;

	//slide landing backward
	case 3:
	objPlayerCutscene.xspd-=0.09;
	if (objPlayerCutscene.xspd<0) objPlayerCutscene.xspd=0;
	
	if (alarmAnimPlayer<0)
	{
		animStatePlayer++;
		alarmAnimPlayer = 90;
		objPlayerCutscene.currentSprite=sprIntroPlayerHandsExclaim;
		objPlayerCutscene.frame=0;
	}
	break;
	
	//player exclaiming
	case 4:
	if (alarmAnimPlayer<0)
	{
		animStatePlayer++;
		alarmAnimPlayer = 110;
		objPlayerCutscene.currentSprite=sprIntroPlayerCrossedArms;
		objPlayerCutscene.frame=0;
	}
	break;
	
	//player crossed arms
	case 5:
	if (alarmAnimPlayer<0)
	{
		animStatePlayer++;
		alarmAnimPlayer = 70;
		objPlayerCutscene.currentSprite=sprIntroPlayerThrowing;
		objPlayerCutscene.frame=0;
	}
	break;
	
	//player throwing object
	case 6:
	if (alarmAnimPlayer<0)
	{
		animStatePlayer++;
		alarmAnimPlayer = 200;
		objPlayerCutscene.frame=0;
	}
	break;
	
	//player idleing
	case 7:
	objPlayerCutscene.currentSprite=sprIntroPlayerIdleing;
	if (instance_exists(objIntroHookShot))
	{
		if (objIntroHookShot.state>0)
		{
			animStatePlayer++;
			objPlayerCutscene.frame=0;
			objPlayerCutscene.xspd=5;
		}
	}
	break;
	
	//hookshot flung back
	case 8:
	objPlayerCutscene.currentSprite=sprIntroPlayerHookedAway;
	objPlayerCutscene.xspd-=0.3;
		if (objPlayerCutscene.xspd<0)
		{
			animStatePlayer++;
			objPlayerCutscene.frame=0;
		}
	break;
	
	//hookshot in
	case 9:
	objPlayerCutscene.currentSprite=sprIntroPlayerHookedIn;
	objPlayerCutscene.xspd-=0.3;
	objPlayerCutscene.zspd-=0.18;
		if (objPlayerCutscene.x<objGuardCutscene.x+30)
		{
			objPlayerCutscene.image_xscale=-1;
			objPlayerCutscene.xspd=0;
			objPlayerCutscene.zspd=0;
			objPlayerCutscene.grav=0;
			objPlayerCutscene.x=objGuardCutscene.x+30;
			animStatePlayer++;
			objPlayerCutscene.frame=0;
		}
	break;
	
	//held up
	case 10:
		objPlayerCutscene.currentSprite=sprIntroPlayerHeldUpGuard;
		if (animStateGuard==10)
		{
			animStatePlayer++;
			objPlayerCutscene.frame=0;
		}
	break;
	
	//held up pt2
	case 11:
		objPlayerCutscene.currentSprite=sprIntroPlayerHeldUpGuard;
		if (objGuardCutscene.frame==12)
		{
			animStatePlayer++;
			alarmAnimPlayer=30;
			objPlayerCutscene.x=objGuardCutscene.x-40;
			objPlayerCutscene.xspd=-0.25;
			objPlayerCutscene.frame=0;
			frameRate=15;
		}
	break;
	
	//punched
	case 12:
		objPlayerCutscene.currentSprite=sprIntroPlayerPunched;
		if (alarmAnimPlayer<0)
		{
			animStatePlayer++;
			
			//objPlayerCutscene.frame=0;
		}
	break;
	
	case 13:
		if (frameRate<60) frameRate+=10;
		if (frameRate>60) frameRate=60;
		objPlayerCutscene.xspd-=4;
		if (objPlayerCutscene.xspd<-12) objPlayerCutscene.xspd=-12;
	break;
}



//----[ GUARD ]----------------------------------------------------------------------------------------
alarmAnimGuard--;
objGuardCutscene.image_xscale = guardXDir;

switch(animStateGuard)
{
	//walking
	case 0:
		objGuardCutscene.currentSprite=sprIntroGuardWalk;
		objGuardCutscene.xspd=0.85*guardXDir;
		
		//stop and turn
		if (objGuardCutscene.x<4730 && guardXDir<0)
		{
			alarmAnimGuard = 60;
			objGuardCutscene.xspd=0;
			objGuardCutscene.x=4730;
			objGuardCutscene.frame=0;
			animStateGuard++;
		}
		
		//stop to grab player
		if (objGuardCutscene.x>4940 && guardXDir>0)
		{
			alarmAnimGuard = 60;
			objGuardCutscene.xspd=0;
			objGuardCutscene.x=4940;
			objGuardCutscene.frame=0;
			guardXDir*=-1;
			animStateGuard=2;
		}
	break;
	
	//idle turn after walk
	case 1:
		objGuardCutscene.currentSprite=sprIntroGuardIdleSide;
		if (alarmAnimGuard<0) 
		{
			alarmAnimGuard=60;
			animStateGuard=0;
			guardXDir*=-1;
		}
	break;
		
		//ponder to throw player
	case 2:
		objGuardCutscene.currentSprite=sprIntroGuardIdleSide;
		if (alarmAnimGuard<0) 
		{
			objGuardCutscene.frame=0;
			alarmAnimGuard=65;
			animStateGuard++;
		}
	break;
	
		//throw player backward
	case 3:
		objGuardCutscene.currentSprite=sprIntroGuardGrab;
		if (alarmAnimGuard<0) 
		{
			alarmAnimGuard=60;
			guardXDir*=-1;
			animStateGuard++;
		}
	break;
		//idle
	case 4:
		objGuardCutscene.currentSprite=sprIntroGuardIdleSide;
		if (alarmAnimGuard<0) 
		{
			objGuardCutscene.frame=0;
			alarmAnimGuard=150;
			animStateGuard++;
		}
	break;
		//fired!
	case 5:
	
	//screenshake
		if (alarmAnimGuard<140) layer_set_visible(layer_get_id("screenShakeEffect"),true);
		if (alarmAnimGuard<130) layer_set_visible(layer_get_id("screenShakeEffect"),false);
		
		//fired text
		textXPos0+=3;
		textXPos1+=3;
		if (textXPos0>x+768) textXPos0=x-768;
		if (textXPos1>x+768) textXPos1=x-768;
		
		//set sprite
		objGuardCutscene.currentSprite=sprIntroGuardFired;
		if (alarmAnimGuard<0) 
		{
			alarmAnimGuard=600;
			animStateGuard++;
		}
	break;
		//re-fired!
	case 6:

		//set sprite
		if (alarmAnimGuard<100 && objGuardCutscene.currentSprite!=sprIntroGuardReFired)
		{
			objGuardCutscene.frame=0;
			objGuardCutscene.currentSprite=sprIntroGuardReFired;
		}
		
		if (instance_exists(objIntroMotherboardThrown))
		{
			if (objIntroMotherboardThrown.state>0)
			{
				objGuardCutscene.frame=0;
				alarmAnimGuard=200;
				layer_set_visible(layer_get_id("screenShakeEffectLight"),true);
				animStateGuard++;
			}
		}
	break;
	
	//get hit
	case 7:
		if (alarmAnimGuard<195) layer_set_visible(layer_get_id("screenShakeEffectLight"),false);

		//set sprite
		objGuardCutscene.currentSprite=sprIntroGuardHit;
		
		if (alarmAnimGuard<0) 
		{
			objGuardCutscene.frame=0;
			alarmAnimGuard=600;
			animStateGuard++;
		}
	break;
	
	//grapple player
	case 8:

		//set sprite
		objGuardCutscene.currentSprite=sprIntroGuardShootHook;
		
		if (animStatePlayer==10) 
		{
			instance_destroy(objIntroHookShot);
			guardXDir=-1;
			objGuardCutscene.frame=0;
			alarmAnimGuard=120;
			animStateGuard++;
		}
	break;
	
	//hold up player
	case 9:
		//set sprite
		objGuardCutscene.currentSprite=sprIntroGuardHoldPlayer;
		
		if (alarmAnimGuard<0) 
		{
			objGuardCutscene.frame=0;
			objPlayerCutscene.frame=0;
			alarmAnimGuard=600;
			animStateGuard++;
		}
	break;
	
	//punch
	case 10:
		//set sprite
		objGuardCutscene.currentSprite=sprIntroGuardPunch;
		
		if (alarmAnimGuard<0) 
		{
			objGuardCutscene.frame=0;
			alarmAnimGuard=600;
			animStateGuard++;
		}
	break;
}

game_set_speed(frameRate, gamespeed_fps);

//debug scrubbing
if (keyboard_check(vk_left)) frameRate=15;
else if (keyboard_check(vk_right)) frameRate=300;
else if (keyboard_check(vk_up)) frameRate=60;