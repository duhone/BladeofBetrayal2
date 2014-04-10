/*
 *  CRSoundEngine.cpp
 *  BoB
 *
 *  Created by Robert Shoemate on 2/11/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "CRSoundEngine.h"
#include "OpenAL/oalStaticBufferExtension.h"
#include "OpenAL/oalMacOSX_OALExtensions.h"

using namespace std::tr1;

CRSoundEngine::CRSoundEngine()
{
	soundFiles[0] = "bang00";
	soundFiles[1] = "beepbeep";
	soundFiles[2] = "blip";
	//soundFiles[3] = "bulldozerstart";
	//soundFiles[4] = "clamps";
	soundFiles[3] = "clickon";
	soundFiles[4] = "cratebreak";
	//soundFiles[7] = "crow";
	soundFiles[5] = "Damage00";
	soundFiles[6] = "EarthQuake";
	soundFiles[7] = "explode00";
	soundFiles[8] = "explode01";
	soundFiles[9] = "explode02";
	soundFiles[10] = "flame";
	soundFiles[11] = "growl00";
	soundFiles[12] = "growl01";
	soundFiles[13] = "growl02";
	//soundFiles[17] = "handgun00";
	soundFiles[14] = "handgun01";
	soundFiles[15] = "handgun02";
	soundFiles[16] = "jaildoorclose";
	soundFiles[17] = "laser00";
	soundFiles[18] = "laser01";
	soundFiles[19] = "laser02";
	//soundFiles[24] = "laser03";
	soundFiles[20] = "morsecode";
	soundFiles[21] = "phase00";
	//soundFiles[27] = "rocket00";
	soundFiles[22] = "shockattack";
	soundFiles[23] = "sparks";
	soundFiles[24] = "swing00";
	soundFiles[25] = "swoosh00";
	soundFiles[26] = "watersplash";
	//soundFiles[33] = "whip00";
	soundFiles[27] = "jump00";
	soundFiles[28] = "breakwindow";
	soundFiles[29] = "electronic";
	soundFiles[30] = "firedeath";
	soundFiles[31] = "monster";
	//soundFiles[39] = "ninjastar";
	//soundFiles[40] = "machinery";
	soundFiles[32] = "colt45";
	soundFiles[33] = "carbine";
	soundFiles[34] = "ninjaswing";
	//soundFiles[44] = "endlevel";
	soundFiles[35] = "thunder";
	isMuted = false;
	
	m_device = alcOpenDevice(NULL); // open default device
	
	if (m_device != NULL)
	{		
		m_context=alcCreateContext(m_device,NULL); // create context		
		if (m_context != NULL)
		{			
			alcMakeContextCurrent(m_context); // set active context			
		}		
	}
	
	/*alListener3f(AL_POSITION, 0, 0, 0);
		
	float directionvect[6];	
	directionvect[0] = 0;	
	directionvect[1] = 0;	
	directionvect[2] = 0;	
	directionvect[3] = 0;	
	directionvect[4] = 1;	
	directionvect[5] = 0;	
	alListenerfv(AL_ORIENTATION, directionvect);*/
	
	alBufferDataStaticProcPtr alBufferDataStaticProc = (alBufferDataStaticProcPtr)alcGetProcAddress(nil, (const ALCchar *)"alBufferDataStatic");
	alcMacOSXMixerOutputRateProcPtr alcMacOSXMixerOutputRateProc = (alcMacOSXMixerOutputRateProcPtr)alcGetProcAddress(nil, (const ALCchar *)"alcMacOSXMixerOutputRate");
	
	alcMacOSXMixerOutputRateProc(11025);
	alGenBuffers(36, m_oalBuffers);
	for(int i=0;i < 36;++i)
	{		
		NSString *resourceFile = [[NSString alloc] initWithCString: soundFiles[i].c_str()];
		NSString *path = [[NSBundle mainBundle] pathForResource:resourceFile ofType:@"wav"];
		
		AudioFileID outAFID;
		NSURL * afUrl = [NSURL fileURLWithPath:path];

		OSStatus result = AudioFileOpenURL((CFURLRef)afUrl, kAudioFileReadPermission, 0, &outAFID);
		UInt64 outDataSize = 0;
		UInt32 thePropSize = sizeof(UInt64);
		result = AudioFileGetProperty(outAFID, kAudioFilePropertyAudioDataByteCount, &thePropSize, &outDataSize);
		
		unsigned char * outData = new unsigned char[outDataSize];
		m_aolDataBuffers.push_back(shared_ptr<unsigned char>(outData));
		// this where we actually get the bytes from the file and put them
		// into the data buffer
		UInt32 outDataSizeSmall = (UInt32)outDataSize;
		result = AudioFileReadBytes(outAFID, false, 0, &outDataSizeSmall, outData);
		
		alBufferDataStaticProc(m_oalBuffers[i],AL_FORMAT_MONO16,outData,outDataSize,11025);
	}
	
}

CRSoundEngine::~CRSoundEngine()
{
	for (vector<CRSound*>::iterator i = sounds.begin(); i != sounds.end(); i++)
	{
		delete (*i);
		i = sounds.erase(i);
	}
	
	alDeleteBuffers(35, m_oalBuffers);
	m_aolDataBuffers.clear();
	alcDestroyContext(m_context);
	alcCloseDevice(m_device);
}

CRSound* CRSoundEngine::CreateSound(game_sound gameSound,float _gain)
{
	for (int i = 0; i < sounds.size(); i++)
	{
		if (sounds[i]->GetGameSound() == gameSound)
		{
			sounds[i]->IncrementRefCount();
			return sounds[i];
		}
	}
	
	// sound has not yet been created
	CRSound *sound = new CRSound(this, gameSound,_gain);
	sounds.push_back(sound);
	
	return sound;
}

void CRSoundEngine::ReleaseSound(CRSound* sound)
{
	for (vector<CRSound*>::iterator i = sounds.begin(); i != sounds.end(); i++)
	{
		if ( (*i) == sound)
		{
			delete (*i);
			sounds.erase(i);
			break;
		}
	}
}

string CRSoundEngine::GetFileName(game_sound gameSound)
{
	return soundFiles[gameSound];
}