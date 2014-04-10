#include "SoundResource.h"

void SoundResource::AddInternalRef()
{
	//if ref > 0 load sound buffer
	internal_ref_count++;
	
	if(internal_ref_count > 0)
	{
		bActiveResource = true;
		
		AllocateResource();
		//load sound buffer
	}
}

void SoundResource::Release()
{
	if(internal_ref_count > 0)
		internal_ref_count--;
	
	if(internal_ref_count == 0)
	{
		bActiveResource = false;
		
		DeAllocateResource();
		//unload audio buffer;
	}
}

void SoundResource::AllocateResource()
{
	//allocate audio buffer
	sndRsrc.CreateBuffer(szUncompressedData);
	
	void *buffer = sndRsrc.GetBuffer();
	
	FILE *pFile = fopen(rscFileName, "rb");
	
	fseek(pFile, l_FileDataOffset, SEEK_SET);
	
	//allocate temporary buffer
	void *tbuffer;
	
	tbuffer = malloc(szCompressedData);
	
	fread(tbuffer, 1, szCompressedData, pFile);
	
	fclose(pFile);
	
	/* UnCompress Data from File */ 
	uncompress((unsigned char*)buffer, (unsigned long*)&szUncompressedData, \
		       (const unsigned char *)tbuffer, szCompressedData);
	
	/* Reconstruct Data With Addative Filter */
	unsigned char *temp = (unsigned char*) buffer;
	for(unsigned int j = 0; j < szUncompressedData - 1; j++)
	{
		unsigned char prev = temp[j];
		temp[j + 1] = temp[j + 1] + prev;
	}
	
	free(tbuffer);
}

void SoundResource::DeAllocateResource()
{
	//deallocate audio buffer
}
