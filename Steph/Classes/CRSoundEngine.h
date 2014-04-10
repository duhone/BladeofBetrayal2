/*
 *  CRSoundEngine.h
 *  BoB
 *
 *  Created by Robert Shoemate on 2/11/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */
#pragma once
#include <vector>
#include <string>
#include "GameSounds.h"
#include "CRSound.h"
#include <OpenAL/al.h>
#include <OpenAL/alc.h>
#include <tr1/memory>

using namespace std;

class CRSoundEngine
{
public:
	CRSoundEngine();
	~CRSoundEngine();
	
	CRSound *CreateSound(game_sound gameSound,float _gain = 1.0f);
	void ReleaseSound(CRSound *sound);
	string GetFileName(game_sound gameSound);
	void Mute(bool isMuted) { this->isMuted = isMuted; }
	bool IsMuted() const { return isMuted; }
	ALuint GetAudioBuffer(int _entry) {return m_oalBuffers[_entry];}
private:
	vector<CRSound*> sounds;
	string soundFiles[36];
	bool isMuted;
	ALCcontext* m_context;
	ALCdevice* m_device;
	ALuint m_oalBuffers[36];
	std::vector<tr1::shared_ptr<unsigned char> > m_aolDataBuffers;
};