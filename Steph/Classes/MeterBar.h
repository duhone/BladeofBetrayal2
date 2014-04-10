/*
 *  MeterBar.h
 *  BoB
 *
 *  Created by Robert Shoemate on 1/29/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */
#pragma once
#include "Graphics.h"
#include "HPTPoint.h"

enum MeterBarColor
{
	Red,
	Green
};

class MeterBar
{
public:
	MeterBar(MeterBarColor mbColor);
	~MeterBar();
	
	void SetPosition(int x, int y);
	void SetPercentFull(float p); // 0 - 1 
	//void SetLength(int len);
	//void SetFill(int fill);
	void SetTotalBars(int totalBars);
	void Render();
	
private:
	CR::Graphics::Sprite *leftEdgeSprite;
	CR::Graphics::Sprite *emptyMeterSprite;
	CR::Graphics::Sprite *colorMeterSprite;
	CR::Graphics::Sprite *rightEdgeSprite;
	float percentFull;
	HPTPoint pos;
	int totalBars;
};