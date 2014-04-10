#pragma once

#include "Audio.h"

// Wave File Data Chunk
class PCM_WAV_BUFFER : public CAudioBuffer
{
public:
	PCM_WAV_BUFFER();
	virtual ~PCM_WAV_BUFFER();

	bool Load(char *file);

private:

	PCM_WAV_BUFFER(PCM_WAV_BUFFER &arg) {};
	PCM_WAV_BUFFER& operator=(PCM_WAV_BUFFER &arg) {return *this;};
};