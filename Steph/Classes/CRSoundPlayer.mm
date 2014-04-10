/*
 *  CRSoundPlayer.cpp
 *  BoB
 *
 *  Created by Robert Shoemate on 2/11/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "CRSoundPlayer.h"

CRSoundPlayer::CRSoundPlayer()
{
	soundEngine = new CRSoundEngine();
	sounds.push_back(soundEngine->CreateSound(bang00));
	sounds.push_back(soundEngine->CreateSound(beepbeep));
	sounds.push_back(soundEngine->CreateSound(blip));
	//sounds.push_back(soundEngine->CreateSound(bulldozerstart));
	//sounds.push_back(soundEngine->CreateSound(clamps));
	sounds.push_back(soundEngine->CreateSound(clickon,0.75f));
	sounds.push_back(soundEngine->CreateSound(cratebreak));
	//sounds.push_back(soundEngine->CreateSound(crow));
	sounds.push_back(soundEngine->CreateSound(damage00));
	sounds.push_back(soundEngine->CreateSound(earthquake));
	sounds.push_back(soundEngine->CreateSound(explode00));
	sounds.push_back(soundEngine->CreateSound(explode01));
	sounds.push_back(soundEngine->CreateSound(explode02));
	sounds.push_back(soundEngine->CreateSound(flame));
	sounds.push_back(soundEngine->CreateSound(growl00,0.75f));
	sounds.push_back(soundEngine->CreateSound(growl01,0.75f));
	sounds.push_back(soundEngine->CreateSound(growl02,0.75f));
	//sounds.push_back(soundEngine->CreateSound(handgun00));
	sounds.push_back(soundEngine->CreateSound(handgun01));
	sounds.push_back(soundEngine->CreateSound(handgun02));
	sounds.push_back(soundEngine->CreateSound(jaildoorclose));
	sounds.push_back(soundEngine->CreateSound(laser00,0.5f));
	sounds.push_back(soundEngine->CreateSound(laser01,0.5f));
	sounds.push_back(soundEngine->CreateSound(laser02));
	//sounds.push_back(soundEngine->CreateSound(laser03));
	sounds.push_back(soundEngine->CreateSound(morsecode));
	sounds.push_back(soundEngine->CreateSound(phase00));
	//sounds.push_back(soundEngine->CreateSound(rocket00));
	sounds.push_back(soundEngine->CreateSound(shockattack));
	sounds.push_back(soundEngine->CreateSound(sparks));
	sounds.push_back(soundEngine->CreateSound(swing00));
	sounds.push_back(soundEngine->CreateSound(swoosh00));
	sounds.push_back(soundEngine->CreateSound(watersplash));
	//sounds.push_back(soundEngine->CreateSound(whip00));
	sounds.push_back(soundEngine->CreateSound(jump00));
	sounds.push_back(soundEngine->CreateSound(breakwindow));
	sounds.push_back(soundEngine->CreateSound(electronic,0.5f));
	sounds.push_back(soundEngine->CreateSound(firedeath,0.75f));
	sounds.push_back(soundEngine->CreateSound(monster,0.75f));
	//sounds.push_back(soundEngine->CreateSound(ninjastar));
	//sounds.push_back(soundEngine->CreateSound(machinery));
	sounds.push_back(soundEngine->CreateSound(colt45));
	sounds.push_back(soundEngine->CreateSound(carbine));
	sounds.push_back(soundEngine->CreateSound(ninjaswing));
	//sounds.push_back(soundEngine->CreateSound(endlevel));
	sounds.push_back(soundEngine->CreateSound(thunder));
}

CRSoundPlayer::~CRSoundPlayer()
{
	for (int i = 0; i < sounds.size(); i++)
		sounds[i]->Release();
	
	delete soundEngine;
}

void CRSoundPlayer::PlaySound(game_sound gameSound)
{
	sounds[gameSound]->Play(false);
}

bool CRSoundPlayer::IsPlaying(game_sound gameSound)
{
	return sounds[gameSound]->IsPlaying();
}

void CRSoundPlayer::RumbleSound(game_sound gameSound)
{
	sounds[gameSound]->Play(true);	
}