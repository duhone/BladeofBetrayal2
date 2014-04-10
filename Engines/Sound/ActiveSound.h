#pragma once

#include "SoundEngine.h"
#include "SoundObject.h"
#include "IActiveSound.h"

class ActiveSound  :IActiveSound
	{
	public:
		ActiveSound();
		virtual ~ActiveSound();

		virtual bool IsDone();
		virtual void StartSound(SoundObject* arg);
		
		SoundEngine *snd_eng;
		
		unsigned short* sound;
		long length;
		long pos;
		int* stream;
		bool done;
	};

