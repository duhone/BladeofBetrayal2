#include "FontInternal.h"
#include "TexturesInternal.h"
#include "GraphicsEngineInternal.h"
#include <memory>

using namespace std;

using namespace CR::Graphics;
extern GraphicsEngineInternal *gengine;
//extern void GENEW(void *arg);

FontInternal::FontInternal()
{
		current_x = 0;
	current_y = 0;
	sprite.SetPositionAbsalute(0,0);
	texture = NULL;

}

FontInternal::~FontInternal()
{
		if(texture != NULL)
		{
			texture->ReleaseTexture();
			delete texture;
			texture = NULL;
		}
}

void FontInternal::LoadHFFFont(char *fontname)
{
		unsigned int colorred,colorgreen,colorblue;
	int count;


	FILE *filep;
	if((filep = fopen(fontname,"rb")) == NULL)
	{
//		MessageBox(NULL,fontname,_T("could not open HFF file"),MB_OK);
		return;
	}
	char check[4];
	check[3] = 0;
	fread(check,sizeof(char),3,filep);
	if(strcmp(check,"HFF"))
	{
//		MessageBox(NULL,_T("File is not a HPT Font File"),fontname,MB_OK);	
	}
	int tempi;
	fread(&tempi,sizeof(int),1,filep);
	if(tempi != 1)
	{
//		MessageBox(NULL,_T("Font is a version not recognized"),fontname,MB_OK);	
	}
	if(texture != NULL) delete texture;
	texture = new TextureStruct();
	//GENEW(texture);
	fread(&tempi,sizeof(int),1,filep);
	width = tempi/95;
	fread(&height,sizeof(int),1,filep);
	fread(&keyred,sizeof(int),1,filep);
	fread(&keygreen,sizeof(int),1,filep);
	fread(&keyblue,sizeof(int),1,filep);

	
	
	fread(&colorred,sizeof(int),1,filep);
	fread(&colorgreen,sizeof(int),1,filep);
	fread(&colorblue,sizeof(int),1,filep);
	fread(&fringered,sizeof(int),1,filep);
	fread(&fringegreen,sizeof(int),1,filep);
	fread(&fringeblue,sizeof(int),1,filep);
	fread(&charwidths,sizeof(int),95,filep);
	for(count = 0;count < 95;count++)
	{
		charwidths[count]++;
	}

	int total_width = texture->GetNextPowerOf2(width*95);
	int total_height =  texture->GetNextPowerOf2(height);
	
	int num_rows = total_width>>10;
	if(total_width & 0x03ff)
		num_rows++;
	numChars = 1024/width;
	int numLastChars = 95-(num_rows-1)*numChars;
	
	texture->color_key = 0;
	texture->color_key += keyred>>3;
/*	if(gengine->GetScreenFormat() == FORMAT565)
	{
*/		texture->color_key = texture->color_key<<5;
		texture->color_key += keygreen>>3;
/*	}
	else
	{
		texture->color_key = texture->color_key<<5;
		texture->color_key += keygreen>>3;
	}*/
	texture->color_key = texture->color_key<<5;
	texture->color_key += keyblue>>3;

	
	texture->default_auto_animate = 0;
	texture->default_frame_rate = 1;
	texture->height = height;
	texture->num_frame_sets = num_rows;
	texture->numTextures = num_rows;
	texture->total_height = texture->GetNextPowerOf2(height);
	texture->total_width = texture->GetNextPowerOf2(width*95);
	texture->m_halfu = 1.0f/(1.0f*(texture->total_width))*0.375f;
	texture->m_halfv = 1.0f/(1.0f*texture->total_height)*0.375f;
	if(total_width >= 1024)
		texture->total_width = 1024;	
	texture->width = width;
	texture->frames_per_set = new int[1];
	//GENEW(texture->frames_per_set);
	for(int i = 0;i < num_rows; i++)
	{
		if(i != (num_rows-1))
			texture->frames_per_set[i] = numChars;
		else
			texture->frames_per_set[i] = numLastChars;
	}
	/*if(texture.data != NULL)
	{
		delete[] texture.data[0];
		delete[] texture.data;
	}*/
	texture->old_num_frame_sets = 1;

	/*TwGfxSurfaceInfoType buffer_info;
	buffer_info.size = sizeof(TwGfxSurfaceInfoType);
	buffer_info.width = texture->total_width;
	buffer_info.height = texture->total_height;
	buffer_info.pixelFormat = twGfxPixelFormatRGB565_LE;
	buffer_info.location = twGfxLocationAcceleratorMemory;
	texture->data = new TwGfxSurfaceType*[1];
	TwGfxAllocSurface(gengine->GetGFXHandle(),&(texture->data[0]),&buffer_info);*/
	//int extrabytes = (buffer_info.rowBytes>>1)-(texture->width*95);

//	texture->real_data = new void*[1];
//	NEW(texture->real_data);
//	texture->real_data[0] = new unsigned short[width*height*95];
//	NEW(texture->real_data[0]);
//	texture->data = new void*[1];
//	NEW(texture->data);
//	texture->data[0] = texture->real_data[0];

	int bitsofar = 0;
	unsigned short int color0,color1,color2;
	/*color0 = 0;
	color0 += keyred>>3;
	color0 = color0<<5;
	color0 += keygreen>>3;
	color0 = color0<<5;
	color0 += keyblue>>3;*/
	color0 = 0;

	color1 = 0;
	color1 += colorred>>3;
	color1 = color1<<5;
	color1 += colorgreen>>3;
	color1 = color1<<5;
	color1 += colorblue>>3;
	color1 = color1<<1;
	color1 += 1;


	color2 = 0;
	color2 += fringered>>3;
	color2 = color2<<5;
	color2 += fringegreen>>3;
	color2 = color2<<5;
	color2 += fringeblue>>3;
	color2 = color2<<1;
	color2 += 1;
	
	//color1 = 0x0ffff;
	unsigned char data/* = *fpntr*/;
	data = 0;
	fread(&data,sizeof(char),1,filep);
	//unsigned short *bitdata;
	//TwGfxLockSurface(texture->data[0],(void**)(&bitdata));
	texture->glTextureIds = new GLuint[num_rows];
	glGenTextures(num_rows,texture->glTextureIds);
	unsigned short *tempout = new unsigned short[total_width*total_height];
	int i=0;
//00 = background color
//01 = fringe color
//10 = forground color
//	char temps[100];
	for(int ycount = 0;ycount < total_height;ycount++)
	{

		for(count = 0;count < total_width;count++)
		{
			if((data & 128))
			{
				tempout[i] = color1;
			}
			else if((data & 64))
			{
				tempout[i] = color2;
			}
			else
			{
				tempout[i] = color0;
			}
			i++;
			bitsofar += 2;
			if(bitsofar == 8)
			{
				bitsofar = 0;
				if(fread(&data,1/*sizeof(char)*/,1,filep) == 0)
				{
					if(feof(filep) != 0) data = 170;
					else data = 85;
				}
			}
			else
			{
				data = data<<2;
			}
		}
		//bitdata += extrabytes;
	}


	fclose(filep);
	//TwGfxUnlockSurface(texture->data[0],true);
	for(int i = 0;i < num_rows;i++)
	{
		unsigned short *temprow = new unsigned short[ texture->total_width*texture->total_height];
		for(int y = 0;y < texture->total_height;y++)
		{
			for(int x = 0; x < texture->total_width;x++)
			{
				temprow[y*texture->total_width+x] = tempout[y*total_width+x+i*texture->width*numChars];
			}
		}
		glBindTexture(GL_TEXTURE_2D,texture->glTextureIds[i]);	
		glTexImage2D(GL_TEXTURE_2D,0,GL_RGBA, texture->total_width,texture->total_height,0,
				 GL_RGBA,GL_UNSIGNED_SHORT_5_5_5_1,temprow);
		delete[] temprow;
	}
	texture->ref_count = 1;
	sprite.SetTexture(texture);
	delete[] tempout;
}

void FontInternal::Release()
{
	delete this;
}

void FontInternal::Render(char *arg,int& x,int& y,int px)
{
		sprite.SetPositionAbsalute(x,y);
	unsigned int temp = strlen(arg);
	unsigned int temp2;
	for(unsigned int count = 0;count < temp;count++)
	{
		if(arg[count] != '\n')
		{
			temp2 = arg[count]-32;
			if(temp2 >= 95) continue;
			sprite.SetFrameSet(temp2/numChars);
			sprite.SetFrame(temp2%numChars);
			x -= (texture->width - charwidths[temp2])>>1;
			sprite.SetPositionAbsalute(x,y);
			sprite.Render();
			x += charwidths[temp2] + ((texture->width - charwidths[temp2])>>1);
	
		}
		else
		{
			y += height;
			x = px;
			sprite.SetPositionAbsalute(x,y);
		}
	}
}
