#pragma once

#include "SoundObject.h"

class SoundObjectInternal : public SoundObject 
	{
	public:
		
		// Constructor & Deconstructor
		SoundObjectInternal(int arg);
		~SoundObjectInternal();
		
		// Insert Sound Into HPTSoundEngineInternal Channel List
		virtual void Play();
		virtual void Release();
		virtual void ChangeSound(int arg);
		
	protected:
		
	private:
		
		int sound;
		
		// return next sound sample in buffer
		SoundObjectInternal(SoundObjectInternal &arg) {};
		SoundObjectInternal& operator=(SoundObjectInternal &arg) {return *this;};
	};