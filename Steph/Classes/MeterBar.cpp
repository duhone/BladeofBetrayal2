/*
 *  MeterBar.cpp
 *  BoB
 *
 *  Created by Robert Shoemate on 1/29/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "MeterBar.h"
#include "AssetList.h"
#include <algorithm>

using namespace std;
using namespace CR::Graphics;

extern GraphicsEngine *graphics_engine;

MeterBar::MeterBar(MeterBarColor mbColor)
{
	colorMeterSprite = graphics_engine->CreateSprite1();
	if (mbColor == Green)
		colorMeterSprite->SetImage(CR::AssetList::meter_bar_green);
	else if (mbColor == Red)
		colorMeterSprite->SetImage(CR::AssetList::meter_bar_red);
	
	leftEdgeSprite = graphics_engine->CreateSprite1();
	leftEdgeSprite->SetImage(CR::AssetList::meter_bar_left_edge);
	
	rightEdgeSprite = graphics_engine->CreateSprite1();
	rightEdgeSprite->SetImage(CR::AssetList::meter_bar_right_edge);
	
	emptyMeterSprite = graphics_engine->CreateSprite1();
	emptyMeterSprite->SetImage(CR::AssetList::meter_bar_empty);
	
	percentFull = 0;
	totalBars = 15;
}

MeterBar::~MeterBar()
{
	colorMeterSprite->Release();
	leftEdgeSprite->Release();
	rightEdgeSprite->Release();
	emptyMeterSprite->Release();
}

void MeterBar::SetPosition(int x, int y)
{
	pos.x = x;
	pos.y = y;
	
	leftEdgeSprite->SetPositionAbsalute(pos.x, pos.y);	
}

void MeterBar::SetPercentFull(float p)
{
	percentFull = max(0.0f,p);
}

void MeterBar::SetTotalBars(int totalBars)
{
	this->totalBars = totalBars;
}

void MeterBar::Render()
{
	int pFill = totalBars * percentFull;
	
	leftEdgeSprite->Render();
	
	int xPos = pos.x + colorMeterSprite->GetFrameWidth();
	int yPos = pos.y;
	/*for (int i = 0; i < totalBars; i++)
	{
		if (i < pFill)
		{
			colorMeterSprite->SetPositionAbsalute(xPos, yPos);
			colorMeterSprite->Render();
			xPos += colorMeterSprite->GetFrameWidth();
		}
		else
		{
			emptyMeterSprite->SetPositionAbsalute(xPos, yPos);
			emptyMeterSprite->Render();
			xPos += emptyMeterSprite->GetFrameWidth();
		}
	}*/
	
	colorMeterSprite->SetPositionAbsalute(xPos, yPos);
	colorMeterSprite->RenderBatch(pFill);
	xPos += colorMeterSprite->GetFrameWidth()*pFill;
	emptyMeterSprite->SetPositionAbsalute(xPos, yPos);
	emptyMeterSprite->RenderBatch(totalBars-pFill);
	xPos += emptyMeterSprite->GetFrameWidth()*(totalBars-pFill);
	
	rightEdgeSprite->SetPositionAbsalute(xPos, yPos);
	rightEdgeSprite->Render();
}