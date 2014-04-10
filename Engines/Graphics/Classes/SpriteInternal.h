#ifndef HPT_SPRITE_1_INTERNAL_H
#define HPT_SPRITE_1_INTERNAL_H

#include "Graphics.h"
#include "TexturesInternal.h"
//#include "asm.h"
#include "Vertex.h"
#include "Color.h"

#include <mach/mach.h>
#include <mach/mach_time.h>


namespace CR
{
	namespace Graphics
	{		
		class SpriteInternal;
		
		typedef void (SpriteInternal::*PNTRTOBLT)(void);
		
		class SpriteInternal : public Sprite  
		{
		public:
			__inline void Render(char arg)
			{
				if(!disabled) (this->*(blits[arg]))();
			};
			//void PreLoad();
			void Refresh();
			void SetTexture(TextureStruct *arg);
			SpriteInternal(bool _singleSetMode = false);
			virtual ~SpriteInternal();
			__inline virtual void StepFrame()
			{
				if(!reverse_animation)
				{
					current_frame++;
					if(current_frame > max_frame)
						current_frame = 0;
				}
				else
				{
					current_frame--;
					if(current_frame < 0)
						current_frame = max_frame;
				}

			};
			__inline virtual void SetFrame(int frame)
			{
				if(frame > max_frame) current_frame = 0;
				else current_frame = frame;
			};
			virtual void SetImage(int pallette_entry);
			virtual void SetFrameRate(float rate);
			virtual void UpdateFrameRate(float rate);
			virtual void SetAutoAnimate(bool arg);
			virtual void Render();
			virtual void RenderHFlip();
			virtual void RenderVFlip();
			virtual void RenderHVFlip();
			__inline virtual void SetPositionAbsalute(int x,int y)
			{
				x_position = x;
				y_position = y;
			};
			__inline virtual void SetPositionRelative(int x,int y)
			{
				x_position += x;
				y_position += y;
			};
			virtual void Release();
			virtual void SetFrameSet(int set);
			virtual void NextFrameSet();
			virtual bool IsAnimating();
			virtual void AutoStopAnimate();
			virtual int GetFrameSet();
			virtual int GetFrame();
			virtual int GetFrameWidth()
			{
				return texture->width;
			}
			virtual int GetFrameHeight()
			{
				return texture->height;
			}
			virtual void EnableFrameSkip(bool arg)
			{
				frame_skip = arg;
			}
			virtual void SetReverseAnimation(bool arg);
			virtual void PauseAnimation(bool arg)
			{
				pause = arg;
			}
			
			virtual void RenderBatch(int _num);
			virtual CR::Math::Color32 Color() const {return m_color;}
			virtual void Color(const CR::Math::Color32 &_color) { m_color = _color;}
			virtual bool Lighting() const {return m_lighting;}
			virtual void Lighting(bool _enable) {m_lighting = _enable;}
			
			
		private:
			bool pause;
			bool reverse_animation;
			bool frame_skip;
			//int setxheight;
			bool disabled;
			bool auto_stop;
			int current_frame_set;
			float time_to_animate;
			bool auto_animate;
			float frame_rate;
			float inv_frame_rate;
			int image_number;
			int max_frame;
			int y_position;
			int x_position;
			int current_frame;
			//unsigned int timerfreq;
			uint64_t starttime;
			uint64_t currenttime;
			float inverse_timerfreq;
			TextureStruct *texture;
			PNTRTOBLT blits[16];
			CR::Graphics::Vertex m_vertices[4];
			GLushort m_indices[6];
			bool m_singleSetMode;
			CR::Math::Color32 m_color;
			bool m_lighting;
			
		protected:
			void GetUVBounds(GLfloat &_left,GLfloat &_right,GLfloat &_top,GLfloat &_bot);
			void BlitBase();
			void Blit();
			void BlitHFlip();
			void BlitVFlip();
			void BlitHVFlip();
			void BlitO();
			void BlitHO();
			void BlitVO();
			void BlitHVO();
			void AutoAnimate();
			void ProcessColor();
		};
	}
}

#endif