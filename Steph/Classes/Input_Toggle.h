/*
 *  Input_Toggle.h
 *  BoB
 *
 *  Created by Robert Shoemate on 2/1/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */
#pragma once
#include "Input_Object.h"
#include "HPTPoint.h"
#include "Event.h"

class Input_Toggle : public Input_Object
{
public:
	Input_Toggle();
	~Input_Toggle();
	
	void TouchesBeganImpl(UIView *view, NSSet *touches);
	void TouchesMovedImpl(UIView *view, NSSet *touches);
	void TouchesEndedImpl(UIView *view, NSSet *touches);
	void TouchesCancelledImpl(UIView *view, NSSet *touches);
	void Reset();
	void Update(float time);
	void Render();
	void FreeResources();
	
	void SetSprite(int nSprite);
	void SetPosition(int x, int y);
	void SetTouchBounds(int x, int y, int width, int height);
	
	bool IsDown() const {return isDown;}
	bool IsToggleOn() const {return toggleOn;}
	void ToggleOn(bool _value)
	{
		toggleOn = _value;
		
		if (toggleOn)
			objectSprite->SetFrameSet(0);
		else
			objectSprite->SetFrameSet(1);
	}
	
	Event OnToggled;
	void SetSoundOn(bool isOn) { soundOn = isOn; }
private:
	CR::Graphics::Sprite* objectSprite;
	HPTPoint pos;
	Rect touchBounds;
	bool toggleOn;
	UITouch *touch;
	bool isDown;
	
	bool soundOn;
};