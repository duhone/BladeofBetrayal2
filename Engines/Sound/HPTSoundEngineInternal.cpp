#include "HPTSoundEngineInternal.h"

int HPTSoundEngineInternal::ref_count = 0;

HPTSoundEngineInternal::HPTSoundEngineInternal()
{
	for(int count = 0;count < 8;count++)
	{
		available_sounds.push_back(new ActiveSound());
	}
	sound_mute = false;
}

HPTSoundEngineInternal::~HPTSoundEngineInternal()
{
}

bool HPTSoundEngineInternal::LoadHSF(char name[])
{
	//FileSTUFF
	char hsf[3];
	int version;
	int num_objects;
	Sound* temp_sound;

	//Read File Data
	FILE *filep;

	filep = fopen(name, "rb");

	if(filep == NULL)
	{
		; //error
	}

	fread(hsf,sizeof(char),3,filep);
	if(hsf[0] != 'H' || hsf[1] != 'S' || hsf[2] != 'F')
	{
		; //error
	}

	fread(&version,sizeof(int),1,filep);
	fread(&num_objects,sizeof(int),1,filep);

	for(int count = 0;count < num_objects;count++)
	{
		temp_sound = new Sound();
		temp_sound->ReadFile(filep);
		sound_data.push_back(temp_sound);
	}


	return true;
}


HPTSoundObject *HPTSoundEngineInternal::CreateSoundObject(int arg)
{
//	HPTSoundResource *temp = RequestSoundResource(nSoundObj);

	//Create New Sound Object
	HPTSoundObjectInternal *sndObj = new HPTSoundObjectInternal(arg);

	//Return Sound Object for Use
	return sndObj;
}

void HPTSoundEngineInternal::Release()
{
	ref_count--;
	if(ref_count == 0)  delete this;
}

void HPTSoundEngineInternal::FreeSounds()
{
	Sound *temps;
	for(int count = 0;count < sound_data.size();count++)
	{
		temps = sound_data[count];
		delete temps;
	}
	sound_data.clear();
}

Sound* HPTSoundEngineInternal::GetSound(int arg)
{
	return sound_data[arg];
}

unsigned long HPTSoundEngineInternal::GetBufferSamples()
{
	return num_buffer_samples;
}

void HPTSoundEngineInternal::DoneWithActiveSound(ActiveSound *arg)
{
	available_sounds.push_back(arg);
}

ActiveSound* HPTSoundEngineInternal::GetAvailableSound()
{
	if(sound_mute) return NULL;
	
	for(list<ActiveSound*>::iterator iter= used_sounds.begin();iter != used_sounds.end();)
	{
		if((*iter)->IsDone())
		{
			available_sounds.push_back(*iter);
			iter = used_sounds.erase(iter);	
		}
		else iter++;
	}

	if(available_sounds.size() == 0) return NULL;
	ActiveSound *temp = *(available_sounds.begin());
	used_sounds.push_back(temp);
	available_sounds.pop_front();
	return temp;
}