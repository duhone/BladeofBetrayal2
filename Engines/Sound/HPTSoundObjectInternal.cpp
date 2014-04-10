#include "HPTSoundObjectInternal.h"

extern HPTSoundEngineInternal *m_hptSndEngine;

HPTSoundObjectInternal::HPTSoundObjectInternal(int arg)
{
	sound = arg;
}

HPTSoundObjectInternal::~HPTSoundObjectInternal()
{

}

void HPTSoundObjectInternal::Release()
{
	delete this;
}

void HPTSoundObjectInternal::Play()
{
	ActiveSound *temps = m_hptSndEngine->GetAvailableSound();
	if(temps != NULL) temps->StartSound( m_hptSndEngine->GetSound(sound));

}

void HPTSoundObjectInternal::ChangeSound(int arg)
{
	sound = arg;
}