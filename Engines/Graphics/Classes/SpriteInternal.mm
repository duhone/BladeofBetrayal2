
#include "SpriteInternal.h"
#include "GraphicsEngineInternal.h"
#include "TexturesInternal.h"
//#include "HPTClipperInternal1.h"
#include "asm.h"

#include<OpenGLES/ES1/gl.h>
#include<OpenGLES/ES1/glext.h>

using namespace CR::Graphics;
using namespace CR::Math;

extern GraphicsEngineInternal *gengine;
extern void GENEW(void *arg);

#define NOT_ASSIGNED 0x0ffffffff

SpriteInternal::SpriteInternal(bool _singleSetMode) : m_singleSetMode(_singleSetMode), m_lighting(false)
{
	pause = false;
	reverse_animation = false;
		frame_skip = true;
	x_position = 0;
	y_position = 0;
	max_frame = 2;
	current_frame = 0;
	//timerfreq = SysTicksPerSecond();
	mach_timebase_info_data_t time_info;
	mach_timebase_info(&time_info);

	inverse_timerfreq = time_info.numer/(float)time_info.denom;
	inverse_timerfreq /= 1000000000.0f;
	
	starttime = mach_absolute_time();
	time_to_animate = 1.0f;
	auto_animate = false;
	frame_rate = 1.0f;
	inv_frame_rate = 1.0f;
	image_number = NOT_ASSIGNED;
	current_frame_set = 0;
	texture = NULL;
	auto_stop = false;
	disabled = false;
	blits[0] = &SpriteInternal::Blit;
	blits[HFLIP] = &SpriteInternal::BlitHFlip;
	blits[VFLIP] = &SpriteInternal::BlitVFlip;
	blits[HFLIP | VFLIP] = &SpriteInternal::BlitHVFlip;
	blits[HPTOPAQUE] = &SpriteInternal::BlitO;
	blits[HFLIP | HPTOPAQUE] = &SpriteInternal::BlitHO;
	blits[VFLIP | HPTOPAQUE] = &SpriteInternal::BlitVO;
	blits[HFLIP | VFLIP | HPTOPAQUE] = &SpriteInternal::BlitHVO;
	
	m_indices[0] = 0;
	m_indices[1] = 2;
	m_indices[2] = 1;
	m_indices[3] = 1;
	m_indices[4] = 2;
	m_indices[5] = 3;

	m_color.Set(255,255,255,255);
}

SpriteInternal::~SpriteInternal()
{
}

void SpriteInternal::SetImage(int pallette_entry)
{
	if(image_number == pallette_entry) return;
	if(image_number != NOT_ASSIGNED) texture->ReleaseTexture();
		image_number = pallette_entry;
	if(image_number >= gengine->GetTextureEntrys())
	{
		disabled = true;
		image_number = NOT_ASSIGNED;
		return;
	}
	else disabled = false;
	texture = gengine->GetTexture(pallette_entry);
	texture->UseTexture();
	auto_animate = texture->default_auto_animate;
	frame_rate = texture->default_frame_rate;
	if(frame_rate < 0.00001f) frame_rate = 0.00001f;
	inv_frame_rate = 1.0f/frame_rate;
	time_to_animate = inv_frame_rate;
	if(!m_singleSetMode)
		max_frame = texture->frames_per_set[0] - 1;
	else
	{
		max_frame = (texture->num_frame_sets-1)*texture->frames_per_set[0];
		max_frame += texture->frames_per_set[texture->num_frame_sets-1] - 1;
	}
	starttime = mach_absolute_time();
	//time_to_animate = 1.0f/frame_rate;

	SetFrameSet(0);
}

void SpriteInternal::SetFrameRate(float rate)
{
		if(rate < 0.0001f) rate = 0.0001f;
	frame_rate = rate;
	inv_frame_rate = 1.0f/frame_rate;     
	time_to_animate = inv_frame_rate;

}

void SpriteInternal::UpdateFrameRate(float rate)
{
	float old_irate = inv_frame_rate;
	if(rate < 0.0001f) rate = 0.0001f;
	frame_rate = rate;
	inv_frame_rate = 1.0f/frame_rate;     
	time_to_animate = inv_frame_rate - (old_irate - time_to_animate);

}
void SpriteInternal::SetAutoAnimate(bool arg)
{
		auto_animate = arg;
	starttime = mach_absolute_time();
	currenttime = mach_absolute_time();
	auto_stop = false;
//	time_to_animate = 0;

	time_to_animate = inv_frame_rate;

}

void SpriteInternal::Render()
{
	if(disabled) return;
	if(auto_animate) AutoAnimate();

	(this->*blits[0])();
}

void SpriteInternal::RenderBatch(int _num)
{
	if(disabled || _num==0) return;
	
	GLfloat squarecoords[8*_num];
	
	GLfloat top,bot,left,right;
	GetUVBounds(left,right,top,bot);
	
	for(int i =0; i < _num;++i)
	{
		int base = i*8;
		squarecoords[base] = left;
		squarecoords[base+2] = right;	
		squarecoords[base+4] = left;	
		squarecoords[base+6] = right;
		
		squarecoords[base+1] = bot;
		squarecoords[base+3] = bot;
		squarecoords[base+5] = top;
		squarecoords[base+7] = top;
	}
	
	GLfloat squareVertices[8*_num];
	
	int xstart = x_position-240-(texture->width>>1);
	int ystart = 160-y_position-(texture->height>>1);
	
	for(int i = 0;i < _num;++i)
	{
		int base = i*8;
		squareVertices[base] = xstart;
		squareVertices[base+1] = ystart;
		squareVertices[base+2] = xstart+texture->width;
		squareVertices[base+3] = ystart;
		squareVertices[base+4] = xstart;
		squareVertices[base+5] = ystart+texture->height;
		squareVertices[base+6] = xstart+texture->width;
		squareVertices[base+7] = ystart+texture->height;
		xstart += texture->width;
	}
	
	//glPushMatrix();
	//glScalef(texture->width/(float)480,texture->height/(float)320,1.0f);
	//glTranslatef(x_position,y_position,1);
	
	//glScalef(texture->width>>1, texture->height>>1, 1);
	//glTranslatef(x_position-240/*+(texture->width>>1)*/, 160-y_position/*-(texture->height>>1)*/, -60.0f);
	
	if(!m_singleSetMode)
		glBindTexture(GL_TEXTURE_2D,texture->glTextureIds[current_frame_set]);
	else
		glBindTexture(GL_TEXTURE_2D,texture->glTextureIds[current_frame/texture->frames_per_set[0]]);
	
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
	//glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	//glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	
	glEnable(GL_TEXTURE_2D);
	
    glVertexPointer(2, GL_FLOAT, 0, squareVertices);
    glEnableClientState(GL_VERTEX_ARRAY);
	glTexCoordPointer(2, GL_FLOAT, 0, squarecoords);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisableClientState(GL_COLOR_ARRAY);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4*_num);
	//glPopMatrix();				  
	
}

void SpriteInternal::RenderHFlip()
{
	if(disabled) return;
	if(auto_animate) AutoAnimate();

	(this->*blits[HFLIP])();

}

void SpriteInternal::RenderVFlip()
{
		if(disabled) return;
	if(auto_animate) AutoAnimate();

	(this->*blits[VFLIP])();

}

void SpriteInternal::RenderHVFlip()
{
		if(disabled) return;
	if(auto_animate) AutoAnimate();

	(this->*blits[HFLIP | VFLIP])();

}

void SpriteInternal::Release()
{
	if(image_number != NOT_ASSIGNED)
		if(texture != NULL) texture->ReleaseTexture();
	gengine->RemoveSprite(this);
	delete this;

}

void SpriteInternal::AutoAnimate()
{
	float timepassed;
	currenttime = mach_absolute_time();
	timepassed = (currenttime - starttime)*inverse_timerfreq;
	timepassed = min(timepassed, 1.0f/10.0f);
	starttime = currenttime;
	if(pause) return;
	time_to_animate -= timepassed;
	if(time_to_animate <= 0)
	{
		if(frame_skip)
		{
			while(time_to_animate <= 0)
			{
				StepFrame();
				time_to_animate += inv_frame_rate;
				if(auto_stop)
				{
					if(!reverse_animation)
					{
						if(current_frame == max_frame)
						{
							auto_animate = false;
							auto_stop = false;
							return;
						}
					}
					else
					{
						if(current_frame == 0)
						{
							auto_animate = false;
							auto_stop = false;
							return;
						}
					}

				}
			}
		}
		else
		{
			StepFrame();
			time_to_animate += inv_frame_rate;
			if(auto_stop)
			{
				if(!reverse_animation)
				{
					if(current_frame == max_frame)
					{
						auto_animate = false;
						auto_stop = false;
						return;
					}
				}
				else
				{
					if(current_frame == 0)
					{
						auto_animate = false;
						auto_stop = false;
						return;
					}
				}

				
			}

		}
	}
	if(auto_stop)
		if(current_frame == max_frame)
		{
			auto_animate = false;
			auto_stop = false;
		}
}

void SpriteInternal::ProcessColor()
{
	Color32 baseColor = m_color;
	if(m_lighting)
		baseColor *= gengine->AmbientLight();
	
	m_vertices[0].Color = baseColor;
	m_vertices[1].Color = baseColor;
	m_vertices[2].Color = baseColor;
	m_vertices[3].Color = baseColor;
}

void SpriteInternal::BlitBase()
{
	/*GLfloat squareVertices[] = {
        -1.0f, -1.0f,
        1.0f,  -1.0f,
        -1.0f,  1.0f,
        1.0f,   1.0f,
	};	*/	
			
	//glPushMatrix();
	//glScalef(texture->width/(float)480,texture->height/(float)320,1.0f);
	//glTranslatef(x_position,y_position,1);
	
	//glScalef(texture->width>>1, texture->height>>1, 1);
	//glTranslatef(x_position-240/*+(texture->width>>1)*/, 160-y_position/*-(texture->height>>1)*/, -60.0f);
	//glScalef(texture->width>>1, texture->height>>1, 1);
	
	int xstart = x_position-240-(texture->width>>1);
	int ystart = 160-y_position-(texture->height>>1);
	
	m_vertices[0].X = xstart;
	m_vertices[0].Y = ystart;
	m_vertices[1].X = xstart+texture->width;
	m_vertices[1].Y = ystart;
	m_vertices[2].X = xstart;
	m_vertices[2].Y = ystart+texture->height;
	m_vertices[3].X = xstart+texture->width;
	m_vertices[3].Y = ystart+texture->height;
		
	ProcessColor();
	
	if(!m_singleSetMode)
		glBindTexture(GL_TEXTURE_2D,texture->glTextureIds[current_frame_set]);
	else
		glBindTexture(GL_TEXTURE_2D,texture->glTextureIds[current_frame/texture->frames_per_set[0]]);
	
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
	//glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	//glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	
	glEnable(GL_TEXTURE_2D);
	
    glVertexPointer(2, GL_FLOAT, sizeof(Vertex), m_vertices);
    glEnableClientState(GL_VERTEX_ARRAY);
	glTexCoordPointer(2, GL_FLOAT, sizeof(Vertex), &(m_vertices[0].U));
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glColorPointer(4, GL_UNSIGNED_BYTE, sizeof(Vertex), &(m_vertices[0].Color));
    glEnableClientState(GL_COLOR_ARRAY);
	
	//glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	glDrawElements(GL_TRIANGLES, 6,GL_UNSIGNED_SHORT, m_indices);
	//glPopMatrix();				  
	
}

void SpriteInternal::GetUVBounds(GLfloat &_left,GLfloat &_right,GLfloat &_top,GLfloat &_bot)
{	
	int heightp2 = texture->GetNextPowerOf2(texture->height);
	int diffheight = heightp2-texture->height;
	int top = diffheight/2;
	int bot = top+texture->height-1;
	int left;	
	if(!m_singleSetMode)
		left = texture->width*current_frame;
	else
		left = texture->width*(current_frame%texture->frames_per_set[0]);	
	int right = left + texture->width-1;
	
	//float halfu = 1.0f/(1.0f*(texture->total_width))*0.5f;
	//float halfv = 1.0f/(1.0f*texture->total_height)*0.5f;
	
	_top = static_cast<GLfloat>(top)/heightp2 + texture->m_halfv;
	_bot = static_cast<GLfloat>(bot)/heightp2 + texture->m_halfv;
	_left = static_cast<GLfloat>(left)/(texture->total_width) + texture->m_halfu;
	_right = static_cast<GLfloat>(right)/(texture->total_width) + texture->m_halfu;	
}

void SpriteInternal::Blit()
{	
	/*GLfloat squarecoords[] = {
		0, 0,
		1, 0,
		0, 1,
		1, 1,
	};*/
	
	GLfloat top,bot,left,right;
	GetUVBounds(left,right,top,bot);
	
	/*int heightp2 = texture->GetNextPowerOf2(texture->height);
	GLfloat top = (heightp2-texture->height)/(2.0f*heightp2);
	GLfloat bot = top+(texture->height-1)/(float)heightp2;
	GLfloat left = (texture->width/(float)texture->total_width)*current_frame;
	GLfloat right = left+(texture->width-1)/(float)texture->total_width;*/
	/*squarecoords[0] = left;
	squarecoords[2] = right;	
	squarecoords[4] = left;	
	squarecoords[6] = right;
	
	squarecoords[1] = bot;
	squarecoords[3] = bot;
	squarecoords[5] = top;
	squarecoords[7] = top;*/

	m_vertices[0].U = left;
	m_vertices[0].V = bot;
	m_vertices[1].U = right;
	m_vertices[1].V = bot;
	m_vertices[2].U = left;
	m_vertices[2].V = top;
	m_vertices[3].U = right;
	m_vertices[3].V = top;
	BlitBase();	
}


void SpriteInternal::BlitHFlip()
{
	/*GLfloat squarecoords[] = {
		0, 0,
		1, 0,
		0, 1,
		1, 1,
	};
	
	int heightp2 = texture->GetNextPowerOf2(texture->height);
	GLfloat top = (heightp2-texture->height)/(2.0f*heightp2);
	GLfloat bot = top+(texture->height-1)/(float)heightp2;
	GLfloat left = (texture->width/(float)texture->total_width)*current_frame;
	GLfloat right = left+(texture->width-1)/(float)texture->total_width;*/
		
	GLfloat top,bot,left,right;
	GetUVBounds(left,right,top,bot);
	
	/*squarecoords[0] = right;
	squarecoords[2] = left;	
	squarecoords[4] = right;	
	squarecoords[6] = left;
	
	squarecoords[1] = bot;
	squarecoords[3] = bot;
	squarecoords[5] = top;
	squarecoords[7] = top;*/
	
	m_vertices[0].U = right;
	m_vertices[0].V = bot;
	m_vertices[1].U = left;
	m_vertices[1].V = bot;
	m_vertices[2].U = right;
	m_vertices[2].V = top;
	m_vertices[3].U = left;
	m_vertices[3].V = top;
	
	BlitBase();

}

void SpriteInternal::BlitVFlip()
{	
	/*GLfloat squarecoords[] = {
		0, 1,
		1, 1,
		0, 0,
		1, 0,
	};
	
	int heightp2 = texture->GetNextPowerOf2(texture->height);
	GLfloat top = (heightp2-texture->height)/(2.0f*heightp2);
	GLfloat bot = top+(texture->height-1)/(float)heightp2;
	GLfloat left = (texture->width/(float)texture->total_width)*current_frame;
	GLfloat right = left+(texture->width-1)/(float)texture->total_width;*/	
	
	GLfloat top,bot,left,right;
	GetUVBounds(left,right,top,bot);
	
	/*squarecoords[0] = left;
	squarecoords[2] = right;	
	squarecoords[4] = left;	
	squarecoords[6] = right;
	
	squarecoords[1] = top;
	squarecoords[3] = top;
	squarecoords[5] = bot;
	squarecoords[7] = bot;*/
	
	m_vertices[0].U = left;
	m_vertices[0].V = top;
	m_vertices[1].U = right;
	m_vertices[1].V = top;
	m_vertices[2].U = left;
	m_vertices[2].V = bot;
	m_vertices[3].U = right;
	m_vertices[3].V = bot;
	
	BlitBase();
}

void SpriteInternal::BlitHVFlip()
{
	/*GLfloat squarecoords[] = {
		0, 1,
		1, 1,
		0, 0,
		1, 0,
	};
	
	int heightp2 = texture->GetNextPowerOf2(texture->height);
	GLfloat top = (heightp2-texture->height)/(2.0f*heightp2);
	GLfloat bot = top+(texture->height-1)/(float)heightp2;
	GLfloat left = (texture->width/(float)texture->total_width)*current_frame;
	GLfloat right = left+(texture->width-1)/(float)texture->total_width;*/	
	
	GLfloat top,bot,left,right;
	GetUVBounds(left,right,top,bot);
	
	/*squarecoords[0] = right;
	squarecoords[2] = left;	
	squarecoords[4] = right;	
	squarecoords[6] = left;
	
	squarecoords[1] = top;
	squarecoords[3] = top;
	squarecoords[5] = bot;
	squarecoords[7] = bot;*/
	
	m_vertices[0].U = right;
	m_vertices[0].V = top;
	m_vertices[1].U = left;
	m_vertices[1].V = top;
	m_vertices[2].U = right;
	m_vertices[2].V = bot;
	m_vertices[3].U = left;
	m_vertices[3].V = bot;
	
	BlitBase();
}

void SpriteInternal::BlitO()
{
	Blit();	
}

void SpriteInternal::BlitHO()
{
	BlitHFlip();
}

void SpriteInternal::BlitVO()
{
	BlitVFlip();
}

void SpriteInternal::BlitHVO()
{
	BlitHVFlip();
}

void SpriteInternal::SetFrameSet(int set)
{
	if(m_singleSetMode)
		return;
	if(current_frame_set == set) return;
	auto_stop = false;
	current_frame_set = set;
	if(disabled) return;
	int max_set = texture->num_frame_sets;
	if(current_frame_set > max_set-1) current_frame_set = max_set-1;
	max_frame = texture->frames_per_set[current_frame_set] - 1;

}

void SpriteInternal::NextFrameSet()
{
	if(m_singleSetMode)
		return;
	int max_set = texture->num_frame_sets;
	current_frame_set++;
	if(current_frame_set > max_set-1) current_frame_set = 0;
	max_frame = texture->frames_per_set[current_frame_set] - 1;

}

void SpriteInternal::SetTexture(TextureStruct *arg)
{
//	if(texture != NOT_ASSIGNED) texture->ReleaseTexture();
	texture = arg;
//	texture->UseTexture();
	max_frame = texture->frames_per_set[current_frame_set] - 1;
	
	SetFrameSet(0);
	current_frame_set = 0;

}

bool SpriteInternal::IsAnimating()
{
	return auto_animate;
}

void SpriteInternal::AutoStopAnimate()
{
		auto_stop = true;

}

void SpriteInternal::Refresh()
{
		if(image_number >= gengine->GetTextureEntrys())
	{
		disabled = true;
		image_number = NOT_ASSIGNED;
		return;
	}
	else disabled = false;

	texture = gengine->GetTexture(image_number);
	texture->UseTexture();
	auto_animate = texture->default_auto_animate;
	frame_rate = texture->default_frame_rate;
	if(frame_rate < 0.00001f) frame_rate = 0.00001f;
	
	if(!m_singleSetMode)
		max_frame = texture->frames_per_set[0] - 1;
	else
	{
		max_frame = (texture->num_frame_sets-1)*texture->frames_per_set[0];
		max_frame += texture->frames_per_set[texture->num_frame_sets-1] - 1;
	}
	
	starttime = mach_absolute_time();
	time_to_animate = 1.0f/frame_rate;
	SetFrame(0);
	SetFrameSet(0);
}

int SpriteInternal::GetFrameSet()
{
	if(m_singleSetMode)
		return 0;
	else
		return current_frame_set;
}

int SpriteInternal::GetFrame()
{
	return current_frame;
}

void SpriteInternal::SetReverseAnimation(bool arg)
{
	reverse_animation = arg;
}
