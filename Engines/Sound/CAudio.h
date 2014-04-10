#pragma once

class CAudioBuffer  
	{
	public:
		CAudioBuffer();
		virtual ~CAudioBuffer();
		
		void CreateBuffer(unsigned int szBuffer);
		void ReleaseBuffer();
		
		unsigned char *GetBuffer();
		unsigned int GetBufferLength();
		
	private:
		
		unsigned char *pBufferData; //Wave Buffer
		unsigned int szBuffer;
	};
