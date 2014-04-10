#include "SoundEngine.h"
#include "ActiveSound.h"

/*void StreamCallback(void *userData,SndStreamRef stream, void *buffer,UInt32 frameCount)
 {
 ActiveSound *asound = (ActiveSound*)userData;
 if(asound->pos >= asound->length)
 {
 memset(buffer,0,frameCount*2);
 SndStreamStop(stream);
 asound->done = true;
 return errNone;
 }
 
 if(frameCount <= (asound->length - asound->pos))
 {
 memcpy(buffer,asound->sound+asound->pos,frameCount*2);
 }
 else
 {
 memset(buffer,0,frameCount*2);
 memcpy(buffer,asound->sound+asound->pos,(asound->length - asound->pos)*2);
 }
 asound->pos += frameCount;
 
 return errNone;
 }*/

ActiveSound::ActiveSound()
{
	pos = 0;
	sound = NULL;
	length = NULL;
	done = false;
}

ActiveSound::~ActiveSound()
{
}


void ActiveSound::StartSound(SoundObject *arg)
{
/*	sound = arg->GetData();
	length = arg->GetSize();
	pos = 0;
	done = false;*/
}

bool ActiveSound::IsDone()
{
/*	if(done) 
	{
		//snd_eng->DoneWithActiveSound(this);
		done = false;
		return true;
	}*/
	return false;
}

