/*
 *  Input_Analog.cpp
 *  BoB
 *
 *  Created by Robert Shoemate on 1/19/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "Input_Analog.h"
#include "AssetList.h"

using namespace CR::Graphics;

extern GraphicsEngine *graphics_engine;

Input_Analog::Input_Analog()
{
	touch = NULL;
	analog_center_x = 0;
	analog_center_y = 0;
	analog_radius = 0;
	analog_x = 0;
	analog_y = 0;
	old_analog_x = 0;
	old_analog_y = 0;
	analog_radius_max = 0;
	analog_radius_fudge = 0;
	fudgeAvailable = false;
	
	this->analogSprite = graphics_engine->CreateSprite1();	
	this->analogSprite->SetImage(CR::AssetList::thumb_active_area);
}

Input_Analog::~Input_Analog()
{
	FreeResources();
}

void Input_Analog::SetPosition(float analog_center_x, float analog_center_y)
{
	this->analog_center_x = analog_center_x;
	this->analog_center_y = analog_center_y;
	
	analogSprite->SetPositionAbsalute(analog_center_x, analog_center_y);
}

void Input_Analog::SetRadius(int r, int rMax, int fudge)
{
	this->analog_radius = r; // from the sprite
	this->analog_radius_max = rMax; // the last 10 pixels of the radius will return 1 for the analog
	this->analog_radius_fudge = fudge;
}

float Input_Analog::GetAnalogX(CGPoint touchLocation)
{
	if (IsInAnalogBounds(touchLocation) || IsInAnalogFudge(touchLocation))
	{
		if (touchLocation.x > analog_center_x + analog_radius - analog_radius_max)
			return 1;
		else if (touchLocation.x < analog_center_x - analog_radius + analog_radius_max)
			return -1;
		else
		{
			float pX = (touchLocation.x - analog_center_x)/(analog_radius - analog_radius_max);
			return pX;
		}
	}
	else
		return 0;
}

float Input_Analog::GetAnalogY(CGPoint touchLocation)
{
	if (IsInAnalogBounds(touchLocation) || IsInAnalogFudge(touchLocation))
	{
		if (touchLocation.y > analog_center_y + analog_radius - analog_radius_max)
			return 1;
		else if (touchLocation.y < analog_center_y - analog_radius + analog_radius_max)
			return -1;
		else
		{
			float pY = (touchLocation.y - analog_center_y)/(analog_radius - analog_radius_max);
			return pY;
		}
	}
	else
		return 0;
}

bool Input_Analog::IsInAnalogBounds(CGPoint touchLocation)
{	
	float dX = touchLocation.x - analog_center_x;
	float dY = touchLocation.y - analog_center_y;
	
	float dR = sqrt((float)(dX*dX+dY*dY));
	
	if (dR <= analog_radius)
	{
		fudgeAvailable = true;
		return true;
	}
	else
		return false;
}

bool Input_Analog::IsInAnalogFudge(CGPoint touchLocation)
{
	if (!fudgeAvailable)
		return false;
	
	float dX = touchLocation.x - analog_center_x;
	float dY = touchLocation.y - analog_center_y;
	
	float dR = sqrt((float)(dX*dX+dY*dY));
	
	if (dR <= analog_radius + analog_radius_fudge)
		return true;
	else
		return false;
}

void Input_Analog::TouchesBeganImpl(UIView *view, NSSet *touches)
{
	bool analogSet = true;
	float tmp;
	
	CGPoint pos;
	for (UITouch *touch in touches)
	{
		if (this->touch != NULL && touch != this->touch)
			continue;
		
		// Get the GL position
		pos = [touch locationInView: view];
		tmp = pos.x;
		pos.x = pos.y;
		pos.y = 320-tmp;
		analogSet = false;
		if (IsInAnalogBounds(pos))
		{
			this->touch = touch;
			fudgeAvailable = true;
			
			// Analog X
			old_analog_x = analog_x;
			analog_x = GetAnalogX(pos);
			
			// Analog Y
			old_analog_y = analog_y;
			analog_y = GetAnalogY(pos);
			
			analogSet = true;
		}
		
		if (analogSet)
			break;
	}
	
	if (!analogSet)
	{
		analog_x = 0;
		analog_y = 0;
	}
	
}

void Input_Analog::TouchesMovedImpl(UIView *view, NSSet *touches)
{
	bool analogSet = true;
	float tmp;
	
	CGPoint pos;
	for (UITouch *touch in touches)
	{
		if (this->touch != NULL && touch != this->touch)
			continue;
		
		// Get the GL position
		pos = [touch locationInView: view];
		tmp = pos.x;
		pos.x = pos.y;
		pos.y = 320-tmp;
		analogSet = false;
		if (IsInAnalogBounds(pos) || IsInAnalogFudge(pos))
		{
			this->touch = touch;
			
			// Analog X
			old_analog_x = analog_x;
			analog_x = GetAnalogX(pos);
			
			// Analog Y
			old_analog_y = analog_y;
			analog_y = GetAnalogY(pos);
			
			analogSet = true;
		}
		
		if (analogSet)
			break;
	}
	
	if (!analogSet)
	{
		analog_x = 0;
		analog_y = 0;
	}
}

void Input_Analog::TouchesEndedImpl(UIView *view, NSSet *touches)
{
	for (UITouch *touch in touches)
	{
		if (touch == this->touch)
		{
			analog_x = 0;
			analog_y = 0;
			fudgeAvailable = false;
			this->touch = NULL;
			break;
		}
	}
}

void Input_Analog::TouchesCancelledImpl(UIView *view, NSSet *touches)
{
	for (UITouch *touch in touches)
	{
		if (touch == this->touch)
		{
			analog_x = 0;
			analog_y = 0;
			fudgeAvailable = false;
			this->touch = NULL;
			break;
		}
	}
}

void Input_Analog::Reset()
{
	this->touch = NULL;
	analog_x = 0;
	analog_y = 0;
	old_analog_x = 0;
	old_analog_y = 0;
}

void Input_Analog::Render()
{
	analogSprite->Render();
}

void Input_Analog::FreeResources()
{
	this->analogSprite->Release();
}