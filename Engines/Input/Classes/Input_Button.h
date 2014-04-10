/*
 *  Input_Button.h
 *  BoB
 *
 *  Created by Robert Shoemate on 1/19/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 *  Sprite Requirements:
 *	Total Frames: 2
 *	Frame 1: Up Image
 *	Frame 2: Down Image
 */
#pragma once

#include "Input_Object.h"
#include "Event.h"

class Input_Button : public Input_Object
{
public:
	Input_Button();
	~Input_Button();
	
	void SetButtonBounds(float left, float top, float width, float height);
	void SetSpriteAndBounds(float left, float top, int nSprite);
	
	void TouchesBeganImpl(UIView *view, NSSet *touches);
	void TouchesMovedImpl(UIView *view, NSSet *touches);
	void TouchesEndedImpl(UIView *view, NSSet *touches);
	void TouchesCancelledImpl(UIView *view, NSSet *touches);
	
	bool IsDown() const {return isDown;}
	//void Temp(int _value) {temp = _value;}
	bool WasPressed()
	{
		// reset wasPressed whenever it is checked for
		if (wasPressed)
		{
			wasPressed = false;
			return true;
		}
		
		return false;
	}
	
	bool IsActing()
	{
		// reset isActing whenever it is checked for
		if (isActing)
		{
			isActing = false;
			return true;
		}
		
		return false;
	}
	
	void SetSprite(int nSprite);
	void Reset();
	void Render();
	virtual void FreeResources();
	void SetPosition(int x, int y);
	void SetSoundOn(bool isOn) { soundOn = isOn; }
	Event OnClicked;
private:
	Rect bounds;
	bool isDown;
	bool isActing;
	
	bool wasPressed;
	UITouch *touch;
	CR::Graphics::Sprite* objectSprite;
	
	bool soundOn;
};