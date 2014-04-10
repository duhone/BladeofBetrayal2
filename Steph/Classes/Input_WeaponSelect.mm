/*
 *  Input_WeaponSelect.cpp
 *  BoB
 *
 *  Created by Robert Shoemate on 1/29/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "Input_WeaponSelect.h"
#include "AssetList.h"

using namespace CR::Graphics;

extern GraphicsEngine *graphics_engine;

Input_WeaponSelect::Input_WeaponSelect(Player *player)
{
	this->player = player;
	this->weaponIconsSprite = graphics_engine->CreateSprite1();	
	this->weaponIconsSprite->SetImage(CR::AssetList::hud_weapon_icons);
	this->grenadeIconSprite = graphics_engine->CreateSprite1();
	this->grenadeIconSprite->SetImage(CR::AssetList::icon_grenade);
	SetPosition(0, 0, 0);
	currWeapon = 0;
	isDown = false;
	touch = NULL;
	boundFuzz = 0;
}

Input_WeaponSelect::~Input_WeaponSelect()
{
	FreeResources();
}

void Input_WeaponSelect::TouchesBeganImpl(UIView *view, NSSet *touches)
{
	CGPoint glLocation;
	for (UITouch *touch in touches)
	{
		if (this->touch != NULL && touch != this->touch)
			continue;
		
		glLocation = GetGLLocation(view, touch);
		
		if (glLocation.x > bounds.left - boundFuzz && 
			glLocation.x < bounds.right + boundFuzz &&
			glLocation.y > bounds.top - boundFuzz &&
			glLocation.y < bounds.bottom + boundFuzz)
		{
			this->touch = touch;
			isDown = true;
		}
		else
		{
			isDown = false;
		}
	}	
}

void Input_WeaponSelect::TouchesMovedImpl(UIView *view, NSSet *touches)
{
	CGPoint glLocation;
	for (UITouch *touch in touches)
	{
		if (this->touch != NULL && touch != this->touch)
			continue;
		
		glLocation = GetGLLocation(view, touch);
		
		if (glLocation.x > bounds.left - boundFuzz && 
			glLocation.x < bounds.right + boundFuzz &&
			glLocation.y > bounds.top - boundFuzz &&
			glLocation.y < bounds.bottom + boundFuzz)
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

void Input_WeaponSelect::TouchesEndedImpl(UIView *view, NSSet *touches)
{
	for (UITouch *touch in touches)
	{
		if (touch == this->touch)
		{
			if (isDown)
			{
				// Change to the next weapon
			player->SetAttack(player->GetAttack()+1);			}
			
			isDown = false;
			this->touch = NULL;
			break;
		}
	}
}

void Input_WeaponSelect::TouchesCancelledImpl(UIView *view, NSSet *touches)
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

void Input_WeaponSelect::Reset()
{
}

void Input_WeaponSelect::Update(float time)
{
	weaponIconsSprite->SetFrameSet(player->GetAttack() - 1);
}

void Input_WeaponSelect::SetPosition(float x, float y, int boundFuzz)
{
	pos.x = x;
	pos.y = y;
	
	//set the bounds
	Rect r;
	r.top = y - weaponIconsSprite->GetFrameHeight()/2 ;
	r.left = x -  weaponIconsSprite->GetFrameWidth()/2;
	r.bottom = r.top + weaponIconsSprite->GetFrameHeight();
	r.right = r.left + weaponIconsSprite->GetFrameWidth();
	bounds = r;
	this->boundFuzz = boundFuzz;
	// update the position of the sprite
	weaponIconsSprite->SetPositionAbsalute(pos.x, pos.y);
}

void Input_WeaponSelect::Render()
{
	if (player->GetAttack() > 0)
		weaponIconsSprite->Render();
	
	// draw grenade icons for available grenades, 5 per row
	int xPos = bounds.left + 6;
	int yPos;
	
	if (player->GetAttack() > 0)
		yPos = bounds.bottom + 5;
	else
		yPos = bounds.top + 6;
	
	for (int i = 1; i <= player->GetGrenades(); i++)
	{
		grenadeIconSprite->SetPositionAbsalute(xPos, yPos);
		grenadeIconSprite->Render();
		
		if (i % 5 == 0)
		{
			yPos += grenadeIconSprite->GetFrameHeight() + 1;
			xPos = bounds.left + 6;
		}
		else
			xPos += grenadeIconSprite->GetFrameWidth() + 1;
	}
}

void Input_WeaponSelect::FreeResources()
{
	weaponIconsSprite->Release();
	grenadeIconSprite->Release();
}