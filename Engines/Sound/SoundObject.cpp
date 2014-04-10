#include "SoundEngine.h"

SoundObject::SoundObject(int arg)
{
	_sound = arg;
}

SoundObject::~SoundObject()
{
	
}

void SoundObject::Release()
{
	delete this;
}

void SoundObject::Play()
{
/*	SoundObject *temps = m_hptSndEngine->GetAvailableSound();
	if(temps != NULL) temps->StartSound( m_hptSndEngine->GetSound(sound));*/
}

void SoundObject::ChangeSound(int arg)
{
	_sound = arg;
}