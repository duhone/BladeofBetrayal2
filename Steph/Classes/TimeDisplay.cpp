/*
 *  TimeDisplay.cpp
 *  BoB
 *
 *  Created by Robert Shoemate on 1/30/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "TimeDisplay.h"
#include "CRSoundPlayer.h"

using namespace CR::Graphics;

extern GraphicsEngine *graphics_engine;
extern CRSoundPlayer *soundPlayer;

TimeDisplay::TimeDisplay()
{
	SetPosition(0, 0);
	SetTime(0);
	showFrontZero = true;
	
	timeCount = 0;
	delayTimer = 0;
	doneAnimating = true;
}

TimeDisplay::~TimeDisplay()
{
}

void TimeDisplay::SetFont(Font* displayFont)
{
	this->displayFont = displayFont;
}

void TimeDisplay::SetPosition(int x, int y)
{
	pos.x = x;
	pos.y = y;
}

void TimeDisplay::SetTime(float currTime)
{
	this->currTime = currTime;
	
	if (currTime < 5999) // (99:99
	{
		int minutes = (int)currTime/60;
		int seconds = (int)currTime%60;
		
		if (minutes > 9 || !showFrontZero)
			if (seconds > 9)
				sprintf(timeString, "%d:%d", minutes, seconds);
			else
				sprintf(timeString, "%d:0%d", minutes, seconds);
		else
			if (seconds > 9)
				sprintf(timeString, "0%d:%d", minutes, seconds);
			else
				sprintf(timeString, "0%d:0%d", minutes, seconds);
	}
	else
		sprintf(timeString, "%d:%d", 99, 99);
}

void TimeDisplay::Update(float time)
{
	delayTimer -= time;
	
	if (delayTimer <= 0 && timeCount < maxTime)
	{
		timeCount++;
		delayTimer = .009;
		SetTime(timeCount);
		if(!soundPlayer->IsPlaying(clickon))
			soundPlayer->PlaySound(clickon);
	}
	
	if (timeCount >= maxTime)
		doneAnimating = true;
}

void TimeDisplay::SetDoneAnimating()
{
	if (doneAnimating)
		return;
	
	timeCount = maxTime;
	SetTime(timeCount);
	doneAnimating = true;
}

void TimeDisplay::Render()
{
	graphics_engine->Position(pos.x, pos.y);
	(*graphics_engine) << displayFont << timeString;
}