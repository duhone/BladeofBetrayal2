/*
 *  CRSoundPlayer.h
 *  BoB
 *
 *  Created by Robert Shoemate on 2/11/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */
#include "CRSoundEngine.h"
#include "CRSound.h"
#pragma once

class CRSoundPlayer
{
public:
	CRSoundPlayer();
	~CRSoundPlayer();
	
	void PlaySound(game_sound gameSound);
	bool IsPlaying(game_sound gameSound);
	void RumbleSound(game_sound gameSound);
	
	void Mute(bool isMuted) {soundEngine->Mute(isMuted); }
	bool IsMuted() const { return soundEngine->IsMuted(); }
private:
	CRSoundEngine *soundEngine;
	vector<CRSound*> sounds;

};