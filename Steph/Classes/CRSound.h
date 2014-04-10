/*
 *  CRSound.h
 *  BoB
 *
 *  Created by Robert Shoemate on 2/10/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */
#pragma once
#include <AudioToolbox/AudioToolbox.h>
#include <AudioToolbox/AudioServices.h>
#include "GameSounds.h"
#include <OpenAL/al.h>
#include <OpenAL/alc.h>

class CRSoundEngine;

class CRSound
{
public:
	CRSound(CRSoundEngine* soundEngine, game_sound gameSound,float _gain = 1.0f);
	~CRSound();
	
	void Play(bool rumble);
	void Release();
	game_sound GetGameSound();
	void IncrementRefCount() { refCount++;}
	bool IsPlaying();
private:
	game_sound gameSound;
	ALuint m_soundId;
	//SystemSoundID soundID;
	CRSoundEngine *soundEngine;
	int refCount;
};