#pragma once

#include "CAudio.h"

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "zlib.h"

class SoundResource 
	{
	public:
		
		SoundResource(char *pRscFileName, long pFDataOffset, unsigned int szCompData, unsigned int szData, int *psndStream)
		{
			l_FileDataOffset = pFDataOffset;
			
			if(pRscFileName != 0)
				strcpy(rscFileName, pRscFileName);
			
			szCompressedData = szCompData;
			szUncompressedData = szData;
			internal_ref_count = 0;
		};
		
		~SoundResource()	{};
		
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