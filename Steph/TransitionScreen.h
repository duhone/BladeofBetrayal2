// TransitionScreen.h: interface for the TransitionScreen class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_TRANSITIONSCREEN_H__308BC67A_5359_4D4A_B694_B42DCDE297EB__INCLUDED_)
#define AFX_TRANSITIONSCREEN_H__308BC67A_5359_4D4A_B694_B42DCDE297EB__INCLUDED_


#include "../Engines/Graphics/Classes/Graphics.h"
#include "CRSoundPlayer.h"

extern CR::Graphics::GraphicsEngine* graphics_engine;

extern CRSoundPlayer *soundPlayer;

class TransitionScreen  
{
public:
	TransitionScreen(bool arg);
	virtual ~TransitionScreen();

	void SetTime(float arg);
	void Begin(bool arg);
	void Update();
	void End();
	void Render();
	bool sActive;
private:
	CR::Graphics::Sprite* background;
	CR::Graphics::Sprite* slider;
	CR::Graphics::Sprite* banner;

	float time;
	bool mode;
	float dx;
	float dy;
	float delaytimer;
	unsigned int starttime;
	unsigned int currenttime;
	float timerfreq;
	int nframes;
	bool snd_play;
};

#endif // !defined(AFX_TRANSITIONSCREEN_H__308BC67A_5359_4D4A_B694_B42DCDE297EB__INCLUDED_)
