/*
 *  TallyDisplay.h
 *  BoB
 *
 *  Created by Robert Shoemate on 2/18/09.
 *  Copyright 2009 Conjured Realms LLC. All rights reserved.
 *
 */

#pragma once
#include "Graphics.h"
#include "HPTPoint.h"

#include <string>
#include <stdio.h>

using namespace std;

class TallyDisplay
	{
	public:
		TallyDisplay();
		~TallyDisplay();
		void SetFont(CR::Graphics::Font* displayFont);
		void SetPosition(int x, int y);
		void SetTally(int total, int maxTotal);
		void Render();
		
		void BeginCountUpAnimation() { currTotal = 0; delayTimer = .03;}
		void Update(float time);
		bool DoneAnimating() { return currTotal == total; }
		void SetDoneAnimating();
	private:
		HPTPoint pos;
		float delayTimer;
		CR::Graphics::Font* displayFont;
		//char timeString[6];
		//bool showFrontZero;
		int total;
		int maxTotal;
		int currTotal;
	};