#pragma once

#include<stdio.h>
#include<math.h>
#include<stdlib.h>

#include <list>
#include <vector>

#include "IActiveSound.h"
#include "SoundEngine.h"

using namespace std;

class SoundEngineInternal : public SoundEngine
	{
		
	public:
		IActiveSound* GetAvailableSound();
		void DoneWithActiveSound(IActiveSound *arg);
		
		unsigned long GetBufferSamples();
		SoundObject* GetSound(int arg);
		void FreeSounds();
		char* GetMidiData(int entry);
		void FreeMidis();
		virtual void LoadHMF(char* name);
		
		SoundEngineInternal();
		~SoundEngineInternal();
		
		virtual SoundObject* CreateSoundObject(int arg);
		
		virtual bool LoadHSF(char name[]);
		
		void AddRef() {ref_count++;};
		virtual void Release();
		
	protected:
		
	private:
		int sound_volume;
		bool sound_mute;
		unsigned long num_buffer_samples;
		
		static int ref_count;
		
		vector<SoundObject*> sound_data;
		
		list<SoundObject*> available_sounds;
		list<SoundObject*> used_sounds;
	};

class Sound 
	{
	public:
		Sound();
		virtual ~Sound();
		
		unsigned long GetSize();
		unsigned short* GetData();
		void ReadFile(FILE* arg);
		
	private:
		unsigned long data_size;
		unsigned short* data;
	};
