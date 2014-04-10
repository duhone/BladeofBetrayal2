#include "GraphicsEngineInternal.h"
#include "SpriteInternal.h"
#include "BackgroundInternal.h"
//#include "asm.h"

using namespace CR::Graphics;

extern GraphicsEngineInternal *gengine;
//extern void GENEW(void *arg);

GraphicsEngineInternal::GraphicsEngineInternal() : m_ambientLight(1.0f,1.0f,1.0f)
{
//	back_buffer = new unsigned char[480*320*2];
//	NEW(back_buffer);
	//TwGfxOpen(&twgfx_handle,NULL);

	textures = new TexturesInternal();
	
	/*TwGfxSurfaceInfoType back_buffer_info;
	back_buffer_info.size = sizeof(TwGfxSurfaceInfoType);
	back_buffer_info.width = 480;
	back_buffer_info.height = 320;
	back_buffer_info.pixelFormat = twGfxPixelFormatRGB565_LE;
	back_buffer_info.location = twGfxLocationAcceleratorMemory;
	TwGfxAllocSurface(twgfx_handle,&back_buffer,&back_buffer_info);

	back_buffer_info.size = sizeof(TwGfxSurfaceInfoType);
	back_buffer_info.width = 480;
	back_buffer_info.height = 320;
	back_buffer_info.pixelFormat = twGfxPixelFormatRGB565_LE;
	back_buffer_info.location = twGfxLocationAcceleratorMemory;
	TwGfxAllocSurface(twgfx_handle,&scratch_buffer,&back_buffer_info);*/

	ref_count = 0;
/*#if defined POCKET_PC
	GXOpenDisplay(hwnd,GX_FULLSCREEN);
	GXDisplayProperties prop;
	prop = GXGetDisplayProperties();
	//screen_width = prop.cxWidth;
	//screen_height = prop.cyHeight;
	//screen_xpitch = prop.cbxPitch;
	//screen_ypitch = prop.cbyPitch;
	if(prop.ffFormat & kfDirect555)
		screen_format = FORMAT555;
	if(prop.ffFormat & kfDirect565)
		screen_format = FORMAT565;
	if(prop.ffFormat & kfDirect888)
		screen_format = FORMAT888;
	if(prop.ffFormat & kfLandscape)
	{
		landscape = true;
//		MessageBox(NULL,_T("landscape"),_T("landscape"),MB_OK);
	}
	else landscape = false;

	if(!landscape) extra_y = prop.cbyPitch - 480;
	else extra_y = prop.cbxPitch - 640;
#endif
*/
	cur_text_x = 20;
	cur_text_y = 20;
	cur_text_paragraph_x = 20;
	
	background_image = NULL;
	tile_image[0] = NULL;
	tile_image[1] = NULL;

	//default_clipper.SetClipper(0,0,479,319);
	//current_clipper = &default_clipper;
//	frame_pointer = (unsigned short*)GXBeginDraw();
	capture = false;
	clearscreen = true;

}

GraphicsEngineInternal::~GraphicsEngineInternal()
{
	/*delete textures;
	TwGfxFreeSurface(back_buffer);
	TwGfxFreeSurface(scratch_buffer);

	TwGfxClose(twgfx_handle);*/
//	delete[] back_buffer;
}

int GraphicsEngineInternal::LoadHGF(const char *_name)
{

//	Sleep(1000);
 
	char *name = const_cast<char*>(_name);

	textures->LoadHGF(name);

	/*list<SpriteInternal*>::iterator tempi = sprite_list.begin();
	
	while(tempi != sprite_list.end()) //for(int count = 0;count < sprite_list.size();count++)
	{
//		if((*tempi) == NULL) MessageBox(NULL,_T("imposible for code to get hear"),_T("error"),MB_OK);

		(*tempi)->Refresh();
		tempi++;
	}*/


	return 0;
}
void GraphicsEngineInternal::Release()
{
		ref_count--;
	if(ref_count == 0)
	{
		//HPTList<SpriteInternal*>::iterator tempi = sprite_list.begin();
		//int temp = sprite_list.size();
		/*for(list<SpriteInternal*>::iterator tempi = sprite_list.begin();tempi != sprite_list.end();)
		{
			delete (*tempi);
			tempi = sprite_list.erase(tempi);
		}*/

		gengine = NULL;
		delete this;
	}
}

Sprite* GraphicsEngineInternal::CreateSprite1(bool _singleSetMode)
{
	SpriteInternal *temp;
	temp = new SpriteInternal(_singleSetMode);
	//GENEW(temp);
	//sprite_list.push_front(temp);
	return temp;
}

Background* GraphicsEngineInternal::CreateBackground()
{
	BackgroundInternal *temp = new BackgroundInternal();
	//GENEW(temp);
	return temp;
}

TileBackground* GraphicsEngineInternal::CreateTileBackground()
{
	TileBackgroundInternal *temp = new TileBackgroundInternal();
	//GENEW(temp);
	return temp;
}

Font* GraphicsEngineInternal::CreateFont1()
{
	FontInternal *temp = new FontInternal();
	//GENEW(temp);
	return temp;

	return 0;
}

/*HPTClipper1* GraphicsEngineInternal::CreateClipper1()
{
	HPTClipperInternal1 *temp = new HPTClipperInternal1();
	//GENEW(temp);
	return temp;
}*/

void GraphicsEngineInternal::BeginFrame()
{
	
    [EAGLContext setCurrentContext:context];
    
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    glViewport(0, 0, backingWidth, backingHeight);
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrthof(-160.0f, 160.0f, -240.0f, 240.0f, 0.0f, 100.0f);
	glRotatef(-90.0f, 0.0f, 0.0f, 1.0f);
    glMatrixMode(GL_MODELVIEW);
	
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	// Enable blending
	glEnable(GL_BLEND);

	
		if(background_image == NULL)
		{
			if(clearscreen)
				clear_screen();
		}
		else background_image->Render();
		if(tile_image[0] != NULL)
		{
			if(tile_image[1] != NULL)
			{
				tile_image[0]->Render/*HighQuality*/(/*tile_image[1]*/);	
				tile_image[1]->Render();
			}
			else
			{
				tile_image[0]->Render();
			}
		}
		else
			if(tile_image[1] != NULL) tile_image[1]->Render();

}

void GraphicsEngineInternal::EndFrame()
{
	
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
	
	/*TwGfxSurfaceType* twfront_buffer;
	TwGfxGetPalmDisplaySurface(twgfx_handle,&twfront_buffer);

//	TwGfxWriteSurface(twfront_buffer,back_buffer,true);
	TwGfxPointType point;
	point.x = 0;
	point.y = 0;
	TwGfxRectType rect;
	rect.x = 0;
	rect.y = 0;
	rect.w = 480;
	rect.h = 320;
	TwGfxWaitForVBlank(twgfx_handle);
	TwGfxBitBlt(twfront_buffer,&point,back_buffer,&rect);
	*/
	
/*	if(landscape)
	{
		MemCpyFastLandscape(frame_pointer,(unsigned short*)back_buffer,extra_y);
	}
	else
	{*/

//		PageFlip((unsigned char*)frame_pointer,(unsigned char*)back_buffer,0);
//	}

//	GXEndDraw();

}

void GraphicsEngineInternal::AddRef()
{
		ref_count++;

}

void GraphicsEngineInternal::SetBackgroundColor(int red,int green,int blue)
{
		clear_red = red;
	clear_green = green;
	clear_blue = blue;

}

void GraphicsEngineInternal::SetBackgroundImage(Background *arg)
{
		background_image = static_cast<BackgroundInternal*>(arg);

}

void GraphicsEngineInternal::SetClearScreen(bool arg)
{
		clearscreen = arg;

}

/*void GraphicsEngineInternal::SetClipper(HPTClipper1 *clipper)
{
		if(clipper == NULL) current_clipper = &default_clipper;
	else current_clipper = static_cast<HPTClipperInternal1*>(clipper);

}*/

void GraphicsEngineInternal::SetTileBackgroundImage(int number,TileBackground *arg)
{
	if(number > 1) number = 1;
	tile_image[number] = static_cast<TileBackgroundInternal*>(arg);

}

GraphicsEngine& GraphicsEngineInternal::operator<<(Font* arg)
{
	cur_font = (FontInternal*)arg;
	//cur_font->SetPosition(20,20);
	return *this;
}

GraphicsEngine& GraphicsEngineInternal::operator<<(int arg)
{
	char temp[12];
	sprintf(temp,"%d",arg);
	(*this) << temp;
	return *this;
}

GraphicsEngine& GraphicsEngineInternal::operator<<(double arg)
{
	char temp[30];
	sprintf(temp,"%f",arg);
	int pos = 0;
	for(unsigned int count = 0;count < strlen(temp);count++)
	{
		if(temp[count] != '0') pos = count;
	}
	temp[pos+1] = 0;
	(*this) << temp;
	return *this;
}

GraphicsEngine& GraphicsEngineInternal::operator<<(unsigned int arg)
{
	char temp[12];
	sprintf(temp,"%u",arg);
	(*this) << temp;
	return *this;
}

void GraphicsEngineInternal::clear_screen()
{
	
    glClearColor(clear_red,clear_green,clear_blue, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);
	/*//unsigned short *tempp = (unsigned short*)back_buffer;
		unsigned short tempc = 0;
		//MessageBox(NULL,_T("closing"),_T("closing"),MB_OK);
		tempc += clear_red>>3;
		tempc = tempc<<6;
			tempc += clear_green>>2;
			tempc = tempc<<5;
		tempc += clear_blue>>3;
		TwGfxRectType rect;
		rect.x = 0;
		rect.y = 0;
		rect.w = 480;
		rect.h = 320;

		TwGfxFillRect(back_buffer,&rect,TwGfxComponentsToPackedRGB(clear_red,clear_green,clear_blue));*/

/*		for(int count = 0;count < 480*320;count++)
		{
			(*tempp) = tempc;
			tempp++;
		}*/
//		memset(back_buffer,tempc,480*320*2);
/*		for(int y = 0;y < 320;y++)
		{
			for(int x = 0;x < 480;x++)
			{
				*(tempp + (x) + (y * (320))) = tempc;
				
			}
		}*/
		
}

void GraphicsEngineInternal::RemoveSprite(SpriteInternal *arg)
{
	/*	for(list<SpriteInternal*>::iterator tempi = sprite_list.begin();tempi != sprite_list.end();)
	{
		if((*tempi) == arg)
		{
			tempi = sprite_list.erase(tempi);
			return;
		}
		else tempi++;
	}*/

}

int GraphicsEngineInternal::GetTextureEntrys()
{
	return textures->GetNumEntrys();
}

int GraphicsEngineInternal::GetAvailableMemory()
{
	/*TwGfxInfoType info;
	info.size = sizeof(TwGfxInfoType);
	TwGfxGetInfo(twgfx_handle,&info);
	return info.freeAcceleratorMemory;
*/
	long result = 0;
	//TwGfxGetMemoryUsage(twgfx_handle,twGfxLocationAcceleratorMemory,&result);
	return result;
}

void GraphicsEngineInternal::ReLoadGraphics()
{
	textures->ReLoad();
//	background_image->ReLoad();
	if(tile_image[0] != NULL) tile_image[0]->ReLoad();
	if(tile_image[1] != NULL) tile_image[1]->ReLoad();
}
