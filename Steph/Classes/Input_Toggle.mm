/*
 *  Input_Toggle.cpp
 *  BoB
 *
 *  Created by Robert Shoemate on 2/1/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "Input_Toggle.h"

using namespace CR::Graphics;

extern GraphicsEngine *graphics_engine;

Input_Toggle::Input_Toggle()
{
	objectSprite = 0;
	SetPosition(0, 0);
	SetTouchBounds(0, 0, 0, 0);
	toggleOn = false;
	touch = NULL;
}

Input_Toggle::~Input_Toggle()
{
	FreeResources();
}

void Input_Toggle::TouchesBeganImpl(UIView *view, NSSet *touches)
{
	CGPoint glLocation;
	for (UITouch *touch in touches)
	{
		if (this->touch != NULL && touch != this->touch)
			continue;
		
		glLocation = GetGLLocation(view, touch);
		
		if (glLocation.x > touchBounds.left && 
			glLocation.x < touchBounds.right + touchBounds.left &&
			glLocation.y > touchBounds.top &&
			glLocation.y < touchBounds.bottom + touchBounds.top)
		{
			isDown = true;
			this->touch = touch;
		}
		else
		{
			isDown = false;
		}
	}	
}

void Input_Toggle::TouchesMovedImpl(UIView *view, NSSet *touches)
{
	CGPoint glLocation;
	for (UITouch *touch in touches)
	{
		if (this->touch != NULL && touch != this->touch)
			continue;
		
		glLocation = GetGLLocation(view, touch);
		
		if (glLocation.x > touchBounds.left && 
			glLocation.x < touchBounds.right + touchBounds.left &&
			glLocation.y > touchBounds.top &&
			glLocation.y < touchBounds.bottom + touchBounds.top)
		{
			isDown = true;
			this->touch = touch;
		}
		else
		{
			isDown = false;
		}
	}	
}

void Input_Toggle::TouchesEndedImpl(UIView *view, NSSet *touches)
{
	for (UITouch *touch in touches)
	{
		if (touch == this->touch)
		{
			if (isDown)
			{
				toggleOn = !toggleOn;
				if(OnToggled.Size() > 0)
					OnToggled();
				
				if (soundOn)
					soundPlayer->PlaySound(clickon);
			}
			
			isDown = false;
			this->touch = NULL;
			break;
		}
	}
}

void Input_Toggle::TouchesCancelledImpl(UIView *view, NSSet *touches)
{
	for (UITouch *touch in touches)
	{
		if (touch == this->touch)
		{
			isDown = false;
			this->touch = NULL;
			break;
		}
	}
}

void Input_Toggle::Reset()
{
}

void Input_Toggle::Update(float time)
{
	if (objectSprite != 0)
	{
		if (toggleOn)
			objectSprite->SetFrameSet(0);
		else
			objectSprite->SetFrameSet(1);
	}
}

void Input_Toggle::Render()
{
	if (objectSprite != 0)
		objectSprite->Render();
}

void Input_Toggle::FreeResources()
{
	if(	this->objectSprite != 0)
	{
		this->objectSprite->Release();
		this->objectSprite = 0;
	}
}

void Input_Toggle::SetSprite(int nSprite)
{
	if(this->objectSprite == 0)
		this->objectSprite = graphics_engine->CreateSprite1();	
	this->objectSprite->SetImage(nSprite);
	
	this->objectSprite->SetPositionAbsalute(pos.x, pos.y);
	
	if (toggleOn)
		objectSprite->SetFrameSet(0);
	else
		objectSprite->SetFrameSet(1);
}

void Input_Toggle::SetPosition(int x, int y)
{
	pos.x = x;
	pos.y = y;
	
	if (this->objectSprite != 0)
		this->objectSprite->SetPositionAbsalute(pos.x, pos.y);
}

void Input_Toggle::SetTouchBounds(int x, int y, int width, int height)
{
	Rect r;
	r.left = x;
	r.top = y;
	r.right = width;
	r.bottom = height;
	this->touchBounds = r;
}
