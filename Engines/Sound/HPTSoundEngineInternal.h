#ifndef HPT_SOUND_ENGINE_INTERNAL
#define HPT_SOUND_ENGINE_INTERNAL

#include<stdio.h>
#include<math.h>
#include<stdlib.h>

#include "HPT Sound.h"
#include "Sound.h"
#include "ActiveSound.h"

#include "HPTSoundObjectInternal.h"

#include <list>
#include <vector>

using namespace std;

class HPTSoundObjectInternal;

// Wave File Header Information
/*struct PCM_WAV_HEADER
{
	unsigned int hdRIFF;      //Header RIFF
	unsigned int szFile;      //File Size
	unsigned int hdWAVE;      //Header WAVE
	unsigned int hdFormat;    //Header Format
	unsigned int szWavChunk;  //Wave Chunk Size
	unsigned short fmWave;    //Wave Format
	unsigned short numChans;  //Mono / Stereo
	unsigned int sampRate;    //Sample Rate
	unsigned int byteRate;    //Byte Rate
	unsigned short byteAlign; //Byte Alignment
	unsigned short bitsSamp;  //Bits per Sample
	unsigned int hdData;      //Header Data Description
	unsigned int szDataChunk; //Size Data Chunk
};*/

class HPTSoundEngineInternal : public HPTSoundEngine
{

public:
	ActiveSound* GetAvailableSound();
	void DoneWithActiveSound(ActiveSound *arg);
	unsigned long GetBufferSamples();
	Sound* GetSound(int arg);
	void FreeSounds();
	char* GetMidiData(int entry);
	void FreeMidis();
	virtual void LoadHMF(char* name);
	virtual HPTMusicObject* GetMusicObject();

	HPTSoundEngineInternal();
	~HPTSoundEngineInternal();

	virtual HPTSoundObject* CreateSoundObject(int arg);

	virtual bool LoadHSF(char name[]);

	void AddRef() {ref_count++;};
	virtual void Release();

protected:

private:
	int sound_volume;
	bool sound_mute;
	unsigned long num_buffer_samples;

	static int ref_count;

	vector<Sound*> sound_data;

	list<ActiveSound*> available_sounds;
	list<ActiveSound*> used_sounds;
};

#endif