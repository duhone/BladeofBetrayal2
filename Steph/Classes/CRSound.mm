/*
 *  CRSound.cpp
 *  BoB
 *
 *  Created by Robert Shoemate on 2/10/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "CRSound.h"
#include "CRSoundEngine.h"

CRSound::CRSound(CRSoundEngine* soundEngine, game_sound gameSound,float _gain)
{
	this->soundEngine = soundEngine;
	this->gameSound = gameSound;
	
	alGenSources(1, &m_soundId);
	alSourcei(m_soundId, AL_BUFFER, soundEngine->GetAudioBuffer(gameSound));
	alSourcef(m_soundId, AL_PITCH, 1.0f);
	alSourcef(m_soundId, AL_GAIN, _gain);
	
	//NSString *path = [[NSBundle mainBundle] pathForResource:@"jump00" ofType:@"wav"];
	
	/*NSString *resourceFile = [[NSString alloc] initWithCString: soundEngine->GetFileName(gameSound).c_str()];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:resourceFile ofType:@"wav"];
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath: path], &soundID);
	
	[resourceFile release];*/
	
	refCount = 1;
}

CRSound::~CRSound()
{
	alDeleteSources(1, &m_soundId);
}

void CRSound::Play(bool rumble)
{
	if (soundEngine->IsMuted())
		return;
	alSourcePlay(m_soundId);

	/*if (rumble)
		AudioServicesPlayAlertSound(soundID);
	else
		AudioServicesPlaySystemSound(soundID);*/
}

void CRSound::Release()
{
	refCount--;
	/*if (refCount <= 0)
		soundEngine->ReleaseSound(this);*/
}

game_sound CRSound::GetGameSound()
{
	return gameSound;
}

bool CRSound::IsPlaying()
{
	ALint state;
	alGetSourcei(m_soundId,AL_SOURCE_STATE,&state);
	return state == AL_PLAYING;
}
