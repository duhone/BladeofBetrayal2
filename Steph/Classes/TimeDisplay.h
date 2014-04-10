/*
 *  TimeDisplay.h
 *  BoB
 *
 *  Created by Robert Shoemate on 1/30/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */
#pragma once
#include "Graphics.h"
#include "HPTPoint.h"

#include <string>
#include <stdio.h>

using namespace std;

class TimeDisplay
{
public:
	TimeDisplay();
	~TimeDisplay();
	void SetFont(CR::Graphics::Font* displayFont);
	void SetPosition(int x, int y);
	void SetTime(float currTime);
	void Render();
	void SetShowFrontZero(bool showFrontZero) { this->showFrontZero = showFrontZero; }
	
	void BeginCountUpAnimation(float maxTime) { this->maxTime = maxTime; timeCount = 0; delayTimer = .009; doneAnimating = false;}
	void Update(float time);
	bool DoneAnimating() { return doneAnimating; }
	void SetDoneAnimating();
	
	float GetCurrTime() { return currTime; }
private:
	HPTPoint pos;
	float currTime;
	CR::Graphics::Font* displayFont;
	char timeString[6];
	bool showFrontZero;
	
	float timeCount;
	float maxTime;
	float delayTimer;
	bool doneAnimating;
};