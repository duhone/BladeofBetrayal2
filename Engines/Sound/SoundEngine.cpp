#include "SoundEngine.h"

void SoundEngine::ReadFile(FILE *arg)
{
/*	if(data != NULL) delete[] data;
	
	unsigned long zlib_size;
	fread(&data_size,sizeof(int),1,arg);
	fread(&zlib_size,sizeof(int),1,arg);

	unsigned char* temp_zdata = new unsigned char[zlib_size];
	data = new unsigned short[data_size];
	fread(temp_zdata,1,zlib_size,arg);
	data_size *= 2;
	uncompress((unsigned char*)data,&data_size,temp_zdata,zlib_size);
	data_size /= 2;
	
	delete[] temp_zdata;
	
	for(int count = 1;count < data_size;count++)
	{
		data[count] = data[count] += data[count-1];
	}*/
}

bool SoundEngine::LoadHSF(char name[])
{
	/*
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
	*/
	
	return true;
}