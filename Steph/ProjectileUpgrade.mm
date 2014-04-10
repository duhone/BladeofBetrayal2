// ProjectileUpgrade.cpp: implementation of the ProjectileUpgrade class.
//
//////////////////////////////////////////////////////////////////////


#include "ProjectileUpgrade.h"
#include "game.h"
extern Game* game_class;

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

ProjectileUpgrade::ProjectileUpgrade(char *Message)
{
	message = Message;

	/* Set Activate & Delay Timer */
	SetActiveTime(10);
	SetDelayTime(0);

	/* Set Velocity Direction */
	SetVelocityVector(-70, 0);

	/* Set Start Position */
	SetPosition(320, 100);

//	sound_processor->PlaySound(game_sounds->morsecode);
	soundPlayer->PlaySound(morsecode);
}

ProjectileUpgrade::~ProjectileUpgrade()
{

}

void ProjectileUpgrade::Update()
{

	if(proj_params.timeDelay <= 0)
	{
		proj_params.timeActive -= time;
	
		if(proj_params.timeActive <= 0)
			DeActivate();

		proj_params.xLoc += (proj_params.xVel * time);
		proj_params.yLoc += (proj_params.yVel * time);
	}
	else
	{
		proj_params.timeDelay -= time;
	}
}


void ProjectileUpgrade::Render()
{
	//if(game_class->GetEnableScore()) return;
	graphics_engine->Position((int)(proj_params.xLoc) ,(int)(proj_params.yLoc));
	(*graphics_engine) << gothic10 << message;
}
