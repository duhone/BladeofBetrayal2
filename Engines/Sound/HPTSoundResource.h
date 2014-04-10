#ifndef HPT_SOUND_RESOURCE
#define HPT_SOUND_RESOURCE

#include "PCM_WAV_BUFFER.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

class HPTSoundResource 
{
public:

	HPTSoundResource(char *pRscFileName, long pFDataOffset, unsigned int szCompData, unsigned int szData, SndStreamRef *psndStream)
	{
		l_FileDataOffset = pFDataOffset;

		if(pRscFileName != 0)
			strcpy(rscFileName, pRscFileName);

		szCompressedData = szCompData;
		szUncompressedData = szData;
		internal_ref_count = 0;
	};

	~HPTSoundResource()	{};

	CAudioBuffer *GetAudioBuffer() {return &sndRsrc;};
	void SetResourceFile(char *pRscFileName);
	void SetFileDataOffset(long pFDataOffset);
	void AddInternalRef();
	void Release();

protected:

private:

	void AllocateResource();
	void DeAllocateResource();

	CAudioBuffer sndRsrc;

	char rscFileName[255];
	long l_FileDataOffset;
	unsigned int szCompressedData;
	unsigned int szUncompressedData;
	int internal_ref_count;
	bool bActiveResource;
};

#endif