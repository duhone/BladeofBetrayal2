/*
 *  Input_WeaponSelect.h
 *  BoB
 *
 *  Created by Robert Shoemate on 1/29/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */
#pragma once
#include "Input_Object.h"
#include "HPTPoint.h"
#include "Player.h"

class Input_WeaponSelect : public Input_Object
{
public:
	Input_WeaponSelect(Player *player);
	~Input_WeaponSelect();
	void TouchesBeganImpl(UIView *view, NSSet *touches);
	void TouchesMovedImpl(UIView *view, NSSet *touches);
	void TouchesEndedImpl(UIView *view, NSSet *touches);
	void TouchesCancelledImpl(UIView *view, NSSet *touches);
	void Reset();
	void Update(float time);
	void Render();
	void FreeResources();
	
	void SetPosition(float x, float y, int boundFuzz);
	
	// Properties
	bool CurrentWeapon() const {return currWeapon;}
	//void Temp(int _value) {temp = _value;}
	
private:
	int currWeapon;
	CR::Graphics::Sprite* weaponIconsSprite;
	CR::Graphics::Sprite* grenadeIconSprite;
	HPTPoint pos;
	Player *player;
	Rect bounds;
	int boundFuzz;
	bool isDown;
	UITouch *touch;
};