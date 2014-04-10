#include "texturestruct.h"
#include "GraphicsEngineInternal.h"
#include "zlib.h"

using namespace CR::Graphics;
extern GraphicsEngineInternal *gengine;
//extern void GENEW(void *arg);

using namespace std;

int TextureStruct::ReadPNG(char *name,FILE* &filep)
{
	padded_height = GetNextPowerOf2(height);
//	OutputDebugString("starting read png");
//	TCHAR temps[100];
//	int color_key_red;
//	int color_key_blue;
//	int color_key_green;
//		if(frames_per_set != NULL) delete[] frames_per_set;
	strcpy(file_name,name);
/*	if(data != NULL)
	{
		for(int count = 0;count < old_num_frame_sets;count++)
			if(data[count] != NULL) TwGfxFreeSurface(data[count]);
		delete[] data;
		//if(data != NULL) delete[] data;
	}*/


	int bytes_read = 0;
//	z_stream zlib_stream;
	fread(&bytes_read,sizeof(int),1,filep);
	zlib_size = bytes_read;
	zlib_pos = ftell(filep);
	fseek(filep,bytes_read,SEEK_CUR);
/*	unsigned char *stream = new unsigned char[bytes_read];

	fread(stream,sizeof(unsigned char),bytes_read,filep);
	unsigned long size = total_width*1*3+1;
	unsigned char *tdata = new unsigned char[size];
	NEW(tdata);

	zlib_stream.next_in = stream;
	zlib_stream.avail_in = bytes_read;
	zlib_stream.total_in = 0;
	zlib_stream.next_out = tdata;
	zlib_stream.avail_out = size;
	zlib_stream.total_out = 0;
	zlib_stream.data_type = Z_BINARY;
	zlib_stream.zalloc = Z_NULL;
	zlib_stream.zfree = Z_NULL;

	inflateInit(&zlib_stream);

	old_num_frame_sets = num_frame_sets;
//	real_data = new void*[num_frame_sets];
//	NEW(real_data);
	TwGfxSurfaceInfoType buffer_info;
	data = new TwGfxSurfaceType*[num_frame_sets];
//	TwGfxAllocSurface(gengine->GetGFXHandle(),&(texture->data[0]),&buffer_info);
	int data_size;
	for(int count = 0;count < num_frame_sets;count++)
	{
		int extrabytes;
		buffer_info.size = sizeof(TwGfxSurfaceInfoType);
		buffer_info.width = width*frames_per_set[count];
		buffer_info.height = height;
		buffer_info.pixelFormat = twGfxPixelFormatRGB565_LE;
		buffer_info.location = twGfxLocationAcceleratorMemory;
		TwGfxAllocSurface(gengine->GetGFXHandle(),&(data[count]),&buffer_info);
		extrabytes = (buffer_info.rowBytes>>1)-(width*frames_per_set[count]);
		unsigned short *tempout;
		TwGfxLockSurface(data[count],(void**)(&tempout));
//		unsigned short *tempout = (unsigned short*)(data[count]);
			unsigned short tempi;
			int skip_amount = (total_width*3) - (width*frames_per_set[count]*3);
			for(int count3 = 0;count3 < height;count3++)
			{
				zlib_stream.next_out = tdata;
				zlib_stream.avail_out = size;
				inflate(&zlib_stream,Z_SYNC_FLUSH);
				unsigned char *tempin = tdata;
	
				tempin++;
				for(int count2 = 0;count2 < width*frames_per_set[count];count2++)
				{
					tempi = 0;
					tempi += (*tempin)>>3;
					tempi = tempi<<6;
					tempin++;
					tempi += (*tempin)>>2;
					tempi = tempi<<5;
					tempin++;
					tempi+= (*tempin)>>3;
					tempin++;
					*tempout = tempi;
					tempout++;
				}
				tempout += extrabytes;
				tempin += skip_amount;
			}
		TwGfxUnlockSurface(data[count],true);

	}
	
		//MessageBox(NULL,_T("before"),_T("before"),MB_OK);
	inflateEnd(&zlib_stream);
	delete[] tdata;
	delete[] stream;
//	OutputDebugString("ending read png");
	*/
	return bytes_read+4;
}

void TextureStruct::LoadTexture()
{
	if(glTextureIds != NULL) FreeTexture();
		
	FILE *filep = fopen(file_name,"rb");
	fseek(filep,zlib_pos,SEEK_SET);
	z_stream zlib_stream;

	unsigned char *stream = new unsigned char[zlib_size];

	fread(stream,sizeof(unsigned char),zlib_size,filep);
	unsigned long size = total_width*1*2+1;
	//unsigned char *tdata = new unsigned char[size];
	//GENEW(tdata);

	memset(&zlib_stream,0,sizeof(z_stream));
	zlib_stream.next_in = stream;
	zlib_stream.avail_in = zlib_size;
	//zlib_stream.total_in = 0;
	//zlib_stream.next_out = tdata;
	//zlib_stream.avail_out = size;
	//zlib_stream.total_out = 0;
	zlib_stream.data_type = Z_BINARY;
	//zlib_stream.zalloc = Z_NULL;
	//zlib_stream.zfree = Z_NULL;

	inflateInit(&zlib_stream);
	//	unsigned char line_type;

	old_num_frame_sets = num_frame_sets;
	numTextures = num_frame_sets;
	
//	real_data = new void*[num_frame_sets];
//	NEW(real_data);
//	TwGfxSurfaceInfoType buffer_info;
	//data = new TwGfxSurfaceType*[num_frame_sets];
	glTextureIds = new GLuint[numTextures];
	glGenTextures(numTextures,glTextureIds);
	
	//buffer_info = new TwGfxSurfaceInfoType[num_frame_sets];
//	TwGfxAllocSurface(gengine->GetGFXHandle(),&(texture->data[0]),&buffer_info);
	//int data_size;
	for(int count = 0;count < num_frame_sets;count++)
	{
		//int extrabytes;
		//buffer_info[count].size = sizeof(TwGfxSurfaceInfoType);
		//buffer_info[count].width = width*frames_per_set[count];
		//buffer_info[count].height = height;
		//buffer_info[count].pixelFormat = twGfxPixelFormatRGB565_LE;
		//buffer_info[count].location = twGfxLocationAcceleratorMemoryNoBackingStore;
		//TwGfxAllocSurface(gengine->GetGFXHandle(),&(data[count]),&(buffer_info[count]));
		//extrabytes = (buffer_info[count].rowBytes>>1)-(width*frames_per_set[count]);
		//unsigned short *tempout;
		//TwGfxLockSurface(data[count],(void**)(&tempout));
//		unsigned short *tempout = (unsigned short*)(data[count]);
			//unsigned short tempi;
			//int skip_amount = (total_width*3) - (width*frames_per_set[count]*3);
		unsigned char *tempout = NULL;
		if(type <= 1)
			tempout = new unsigned char[total_width*padded_height*2];
		else if(type == 2)
			tempout = new unsigned char[total_width*padded_height*4];
		else if(type == 3)
			tempout = new unsigned char[total_width*padded_height*3];
			
		zlib_stream.next_out = tempout;//reinterpret_cast<unsigned char*>(tempout);
		if(type <= 1)
			zlib_stream.avail_out = total_width*padded_height*2;
		else if(type == 2)
			zlib_stream.avail_out = total_width*padded_height*4;
		else if(type == 3)
			zlib_stream.avail_out = total_width*padded_height*3;
			
		//while(zlib_stream.avail_out > 0)
			inflate(&zlib_stream,Z_FINISH);
		
		/*int i=0;
		for(int count3 = 0;count3 < padded_height;count3++)
			{
				zlib_stream.next_out = tdata;
				zlib_stream.avail_out = size;
				inflate(&zlib_stream,Z_SYNC_FLUSH);
				unsigned char *tempin = tdata;
	
				tempin++;

				for(int count2 = 0;count2 < total_width;count2++)
				{
					tempi = 0;
					tempi += (*tempin)>>3;
					tempi = tempi<<5;
					tempin++;
					tempi += (*tempin)>>3;
					tempi = tempi<<5;
					tempin++;
					tempi+= (*tempin)>>3;
					tempi = tempi<<1;
					if(color_key == 0 || tempi != color_key)
						tempi += 1;
					tempin++;
					tempout[(padded_height-count3-1)*total_width+count2] = tempi;
					i++;
				}
				//tempout += extrabytes;
				//tempin += skip_amount;
			}*/
		glBindTexture(GL_TEXTURE_2D,glTextureIds[count]);	
		if(type == 0)
			glTexImage2D(GL_TEXTURE_2D,0,GL_RGBA, total_width,padded_height,0,
						 GL_RGBA,GL_UNSIGNED_SHORT_5_5_5_1,tempout);
		else if(type == 1)
			glTexImage2D(GL_TEXTURE_2D,0,GL_RGBA, total_width,padded_height,0,
						 GL_RGBA,GL_UNSIGNED_SHORT_4_4_4_4,tempout);
		else if(type == 2)
			glTexImage2D(GL_TEXTURE_2D,0,GL_RGBA, total_width,padded_height,0,
						 GL_RGBA,GL_UNSIGNED_BYTE,tempout);
		else if(type == 3)
			glTexImage2D(GL_TEXTURE_2D,0,GL_RGB, total_width,padded_height,0,
						 GL_RGB,GL_UNSIGNED_BYTE,tempout);
		
		//TwGfxUnlockSurface(data[count],true);
		
		delete[] tempout;
	}
	
		//MessageBox(NULL,_T("before"),_T("before"),MB_OK);
	inflateEnd(&zlib_stream);
	//delete[] tdata;
	delete[] stream;
//	OutputDebugString("ending read png");

	fclose(filep);
}

void TextureStruct::LoadTexture(FILE *filep)
{
//	FILE *filep = fopen(file_name,"rb");
	if(glTextureIds != NULL) FreeTexture();

	
	fseek(filep,zlib_pos,SEEK_SET);
	z_stream zlib_stream;

	unsigned char *stream = new unsigned char[zlib_size];

	fread(stream,sizeof(unsigned char),zlib_size,filep);
	unsigned long size = total_width*1*3+1;
	unsigned char *tdata = new unsigned char[size];
	//GENEW(tdata);

	zlib_stream.next_in = stream;
	zlib_stream.avail_in = zlib_size;
	zlib_stream.total_in = 0;
	zlib_stream.next_out = tdata;
	zlib_stream.avail_out = size;
	zlib_stream.total_out = 0;
	zlib_stream.data_type = Z_BINARY;
	zlib_stream.zalloc = Z_NULL;
	zlib_stream.zfree = Z_NULL;

	inflateInit(&zlib_stream);

	old_num_frame_sets = num_frame_sets;
	numTextures = num_frame_sets;

//	real_data = new void*[num_frame_sets];
//	NEW(real_data);
//	TwGfxSurfaceInfoType buffer_info;
	//data = new TwGfxSurfaceType*[num_frame_sets];
	//buffer_info = new TwGfxSurfaceInfoType[num_frame_sets];
//	TwGfxAllocSurface(gengine->GetGFXHandle(),&(texture->data[0]),&buffer_info);
	//int data_size;
	
	glTextureIds = new GLuint[numTextures];
	glGenTextures(numTextures,glTextureIds);
	for(int count = 0;count < num_frame_sets;count++)
	{
		/*int extrabytes;
		buffer_info[count].size = sizeof(TwGfxSurfaceInfoType);
		buffer_info[count].width = width*frames_per_set[count];
		buffer_info[count].height = height;
		buffer_info[count].pixelFormat = twGfxPixelFormatRGB565_LE;
		buffer_info[count].location = twGfxLocationAcceleratorMemoryNoBackingStore;
		TwGfxAllocSurface(gengine->GetGFXHandle(),&(data[count]),&(buffer_info[count]));
		extrabytes = (buffer_info[count].rowBytes>>1)-(width*frames_per_set[count]);
		unsigned short *tempout;
		unsigned char line_type;
		TwGfxLockSurface(data[count],(void**)(&tempout));*/
//		unsigned short *tempout = (unsigned short*)(data[count]);
			unsigned short tempi;
			//int skip_amount = (total_width*3) - (width*frames_per_set[count]*3);
		
		unsigned short *tempout = new unsigned short[total_width*padded_height];
		int i=0;
		
			for(int count3 = 0;count3 < padded_height;count3++)
			{
				zlib_stream.next_out = tdata;
				zlib_stream.avail_out = size;
				inflate(&zlib_stream,Z_SYNC_FLUSH);
				unsigned char *tempin = tdata;
	
				tempin++;

				for(int count2 = 0;count2 < total_width;count2++)
				{
					tempi = 0;
					tempi += (*tempin)>>3;
					tempi = tempi<<5;
					tempin++;
					tempi += (*tempin)>>3;
					tempi = tempi<<5;
					tempin++;
					tempi+= (*tempin)>>3;
					tempi = tempi<<1;
					if(color_key == 0 || tempi != color_key)
						tempi += 1;
					tempin++;
					tempout[(padded_height-count3-1)*total_width+count2] = tempi;
					i++;
				}
				//tempout += extrabytes;
				//tempin += skip_amount;
			}
		glBindTexture(GL_TEXTURE_2D,glTextureIds[count]);	
		glTexImage2D(GL_TEXTURE_2D,0,GL_RGBA, total_width,padded_height,0,
					 GL_RGBA,GL_UNSIGNED_SHORT_5_5_5_1,tempout);
		//TwGfxUnlockSurface(data[count],true);
		
		delete[] tempout;
	}
	
		//MessageBox(NULL,_T("before"),_T("before"),MB_OK);
	inflateEnd(&zlib_stream);
	delete[] tdata;
	delete[] stream;
//	OutputDebugString("ending read png");

//	fclose(filep);
}

void TextureStruct::FreeTexture()
{
	if(ref_count == 0) return;
	/*if(buffer_info != NULL)
	{
		delete[] buffer_info;
		buffer_info = NULL;
	}

	if(data != NULL)
	{
		for(int count = 0;count < old_num_frame_sets;count++)
			if(data[count] != NULL) TwGfxFreeSurface(data[count]);
//		delete[] data;
		if(data != NULL) delete[] data;
		data = NULL;
	}*/
	
	if(glTextureIds != NULL)
	{
		glDeleteTextures(numTextures,glTextureIds);
		delete[] glTextureIds;
		glTextureIds = NULL;
	}
	
}

void TextureStruct::UseTexture()
{
	if(ref_count == 0) LoadTexture();
	ref_count++;
	
}

void TextureStruct::ReleaseTexture()
{
	if(ref_count == 1) FreeTexture();
	ref_count--;
}

void TextureStruct::ReLoad()
{
	if(ref_count == 0) return;
	FILE *filep = fopen(file_name,"rb");
	fseek(filep,zlib_pos,SEEK_SET);
	z_stream zlib_stream;

	unsigned char *stream = new unsigned char[zlib_size];

	fread(stream,sizeof(unsigned char),zlib_size,filep);
	unsigned long size = total_width*1*3+1;
	unsigned char *tdata = new unsigned char[size];
	//GENEW(tdata);

	zlib_stream.next_in = stream;
	zlib_stream.avail_in = zlib_size;
	zlib_stream.total_in = 0;
	zlib_stream.next_out = tdata;
	zlib_stream.avail_out = size;
	zlib_stream.total_out = 0;
	zlib_stream.data_type = Z_BINARY;
	zlib_stream.zalloc = Z_NULL;
	zlib_stream.zfree = Z_NULL;

	inflateInit(&zlib_stream);

//	old_num_frame_sets = num_frame_sets;
//	real_data = new void*[num_frame_sets];
//	NEW(real_data);
//	data = new TwGfxSurfaceType*[num_frame_sets];
//	TwGfxAllocSurface(gengine->GetGFXHandle(),&(texture->data[0]),&buffer_info);
	//int data_size;
	for(int count = 0;count < num_frame_sets;count++)
	{
		//int extrabytes;
/*		buffer_info.size = sizeof(TwGfxSurfaceInfoType);
		buffer_info.width = width*frames_per_set[count];
		buffer_info.height = height;
		buffer_info.pixelFormat = twGfxPixelFormatRGB565_LE;
		buffer_info.location = twGfxLocationAcceleratorMemoryNoBackingStore;
*///		TwGfxAllocSurface(gengine->GetGFXHandle(),&(data[count]),&buffer_info);
		//extrabytes = (buffer_info[count].rowBytes>>1)-(width*frames_per_set[count]);
		//unsigned short *tempout;
		//TwGfxLockSurface(data[count],(void**)(&tempout));
//		unsigned short *tempout = (unsigned short*)(data[count]);
		//unsigned char line_type;
		unsigned short *tempout = new unsigned short[total_width*padded_height];
		int i=0;
			unsigned short tempi;
			//int skip_amount = (total_width*3) - (width*frames_per_set[count]*3);
			for(int count3 = 0;count3 < padded_height;count3++)
			{
				zlib_stream.next_out = tdata;
				zlib_stream.avail_out = size;
				inflate(&zlib_stream,Z_SYNC_FLUSH);
				unsigned char *tempin = tdata;
	
				tempin++;

				for(int count2 = 0;count2 < total_width;count2++)
				{
					tempi = 0;
					tempi += (*tempin)>>3;
					tempi = tempi<<5;
					tempin++;
					tempi += (*tempin)>>3;
					tempi = tempi<<5;
					tempin++;
					tempi+= (*tempin)>>3;
					tempi = tempi<<1;
					if(color_key == 0 || tempi != color_key)
						tempi += 1;
					tempin++;
					tempout[(padded_height-count3-1)*total_width+count2] = tempi;
					i++;
				}
				//tempout += extrabytes;
				//tempin += skip_amount;
			}
		//TwGfxUnlockSurface(data[count],true);
		glBindTexture(GL_TEXTURE_2D,glTextureIds[count]);	
		glTexImage2D(GL_TEXTURE_2D,0,GL_RGBA, total_width,padded_height,0,
					 GL_RGBA,GL_UNSIGNED_SHORT_5_5_5_1,tempout);
		
		delete[] tempout;
	}
	
		//MessageBox(NULL,_T("before"),_T("before"),MB_OK);
	inflateEnd(&zlib_stream);
	delete[] tdata;
	delete[] stream;
//	OutputDebugString("ending read png");

	fclose(filep);
}

unsigned int TextureStruct::GetNextPowerOf2(unsigned int _original)
{
	unsigned int result = 1024;
	while ((result&_original) == 0 && result > 0)
	{
		result = result >> 1;
	}
	if(result == 0)
		return 0;
	if((_original&(result-1)) == 0)
		return result;
	else
		return result<<1;
}

void TextureStruct::LoadTextureTiles(FILE *filep)
{
	if(glTextureIds != NULL) FreeTexture();
	
	int padded_height = GetNextPowerOf2(total_height);
	
	fseek(filep,zlib_pos,SEEK_SET);
	z_stream zlib_stream;
	
	unsigned char *stream = new unsigned char[zlib_size];
	
	fread(stream,sizeof(unsigned char),zlib_size,filep);
	unsigned long size = total_width*1*3+1;
	unsigned char *tdata = new unsigned char[size];
	
	zlib_stream.next_in = stream;
	zlib_stream.avail_in = zlib_size;
	zlib_stream.total_in = 0;
	zlib_stream.next_out = tdata;
	zlib_stream.avail_out = size;
	zlib_stream.total_out = 0;
	zlib_stream.data_type = Z_BINARY;
	zlib_stream.zalloc = Z_NULL;
	zlib_stream.zfree = Z_NULL;
	
	inflateInit(&zlib_stream);
	
	old_num_frame_sets = num_frame_sets;
	numTextures = 1;

	
	glTextureIds = new GLuint[numTextures];
	glGenTextures(numTextures,glTextureIds);
	unsigned short tempi;
		
	unsigned short *tempout = new unsigned short[total_width*padded_height];
	int i=0;
		
	for(int count3 = 0;count3 < total_height;count3++)
	{
		zlib_stream.next_out = tdata;
		zlib_stream.avail_out = size;
		inflate(&zlib_stream,Z_SYNC_FLUSH);
		unsigned char *tempin = tdata;
			
		tempin++;
			
		for(int count2 = 0;count2 < total_width;count2++)
		{
			tempi = 0;
			tempi += (*tempin)>>3;
			tempi = tempi<<5;
			tempin++;
			tempi += (*tempin)>>3;
			tempi = tempi<<5;
			tempin++;
			tempi+= (*tempin)>>3;
			tempi = tempi<<1;
			if(color_key == 0 || tempi != color_key)
				tempi += 1;
			tempin++;
			tempout[(padded_height-count3-1)*total_width+count2] = tempi;
			i++;
		}
	}
	glBindTexture(GL_TEXTURE_2D,glTextureIds[0]);	
	glTexImage2D(GL_TEXTURE_2D,0,GL_RGBA, total_width,padded_height,0,
					GL_RGBA,GL_UNSIGNED_SHORT_5_5_5_1,tempout);
		
	delete[] tempout;
	
	inflateEnd(&zlib_stream);
	delete[] tdata;
	delete[] stream;
}

