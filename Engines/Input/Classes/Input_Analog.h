/*
 *  Input_Analog.h
 *  BoB
 *
 *  Created by Robert Shoemate on 1/19/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */
#pragma once

#import <UIKit/UIKit.h>
#include "Input_Object.h"

class Input_Analog : public Input_Object
{
public:
	Input_Analog();
	~Input_Analog();
	
	void SetPosition(float analog_center_x, float analog_center_y);
	void SetRadius(int r, int rMax, int fuzz);
	float GetAnalogX(CGPoint touchLocation);
	float GetAnalogY(CGPoint touchLocation);
	bool IsInAnalogBounds(CGPoint touchLocation);
	bool IsInAnalogFudge(CGPoint touchLocation);
	
	void TouchesBeganImpl(UIView *view, NSSet *touches);
	void TouchesMovedImpl(UIView *view, NSSet *touches);
	void TouchesEndedImpl(UIView *view, NSSet *touches);
	void TouchesCancelledImpl(UIView *view, NSSet *touches);
	
	float AnalogX() const {return analog_x;}
	float AnalogY() const {return analog_y;}
	float OldAnalogX() const {return old_analog_x;}
	float OldAnalogY() const {return old_analog_y;}
	
	void Reset();
	void Render();
	virtual void FreeResources();
private:
	float analog_center_x;
	float analog_center_y;
	
	float analog_radius;
	float analog_radius_max; // outer band of radius that allows full analog movement
	float analog_radius_fudge; // if user drags finger out of analog, keeps working
	
	float analog_x;
	float analog_y;
	
	float old_analog_x;
	float old_analog_y;
	
	UITouch *touch;
	CR::Graphics::Sprite* analogSprite;
	
	bool fudgeAvailable;
};