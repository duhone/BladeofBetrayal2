#include "CAudio.h"

CAudioBuffer::CAudioBuffer()
{
	szBuffer = 0;
	pBufferData = 0;
}

CAudioBuffer::~CAudioBuffer()
{
	if(pBufferData != 0)
		delete[] pBufferData;
}

void CAudioBuffer::CreateBuffer(unsigned int szChars)
{
	szBuffer = szChars;
	
	//8-bit buffer
	pBufferData = new unsigned char[szChars];
	
	//16-bit buffer
	//pBufferData = new unsigned short[szChars];
}

void CAudioBuffer::ReleaseBuffer()
{
	if(pBufferData != 0)
		delete[] pBufferData;
}

unsigned char *CAudioBuffer::GetBuffer()
{
	return pBufferData;
}

unsigned int CAudioBuffer::GetBufferLength()
{
	return szBuffer;
}

