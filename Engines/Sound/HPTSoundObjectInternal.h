#ifndef HPT_SOUND_OBJECT_INTERNAL_H
#define HPT_SOUND_OBJECT_INTERNAL_H

#include "HPT Sound.h"
#include "HPTSoundResource.h"
#include "HPTSoundEngineInternal.h"
#include "ActiveSound.h"

class HPTSoundObjectInternal : public HPTSoundObject 
{
public:

	// Constructor & Deconstructor
	HPTSoundObjectInternal(int arg);
	~HPTSoundObjectInternal();

	// Insert Sound Into HPTSoundEngineInternal Channel List
	virtual void Play();
	virtual void Release();
	virtual void ChangeSound(int arg);
	
protected:
	
private:
	
	int sound;

	// return next sound sample in buffer
	HPTSoundObjectInternal(HPTSoundObjectInternal &arg) {};
	HPTSoundObjectInternal& operator=(HPTSoundObjectInternal &arg) {return *this;};
};

#endif