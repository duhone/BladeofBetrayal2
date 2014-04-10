/*
 *  TallyDisplay.cpp
 *  BoB
 *
 *  Created by Robert Shoemate on 2/18/09.
 *  Copyright 2009 Conjured Realms LLC. All rights reserved.
 *
 */

#include "TallyDisplay.h"
#include "CRSoundPlayer.h"

using namespace CR::Graphics;

extern GraphicsEngine *graphics_engine;
extern CRSoundPlayer *soundPlayer;

TallyDisplay::TallyDisplay()
{
	SetPosition(0, 0);
	SetTally(0, 0);
	currTotal = 0;
	delayTimer = 0;
}

TallyDisplay::~TallyDisplay()
{
}

void TallyDisplay::SetFont(Font* displayFont)
{
	this->displayFont = displayFont;
}

void TallyDisplay::SetPosition(int x, int y)
{
	pos.x = x;
	pos.y = y;
}

void TallyDisplay::SetTally(int total, int maxTotal)
{
	this->total = total;
	this->currTotal = total;
	this->maxTotal = maxTotal;
}

void TallyDisplay::Update(float time)
{
	delayTimer -= time;
	
	if (delayTimer <= 0 && currTotal < total)
	{
		currTotal++;
		delayTimer = .03;
		if(!soundPlayer->IsPlaying(clickon))
		   soundPlayer->PlaySound(clickon);
	}
}

void TallyDisplay::SetDoneAnimating()
{
	if (DoneAnimating())
		return;

	currTotal = total;
}

void TallyDisplay::Render()
{
	graphics_engine->Position(pos.x, pos.y);
	(*graphics_engine) << displayFont << currTotal << "/" << maxTotal;
}