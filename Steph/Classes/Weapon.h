/*
 *  Weapon.h
 *  Steph
 *
 *  Created by Robert Shoemate on 4/11/09.
 *  Copyright 2009 Conjured Realms LLC. All rights reserved.
 *
 */
#pragma once
#include "Graphics.h"
#include "Projectile.h"

#include <math.h>
#include <list>

class Weapon
{
public:
	Weapon();
	virtual ~Weapon();
	void SetPlayerSprite(CR::Graphics::Sprite *playerSprite);	
	virtual Projectile* Attack() = 0;
	
	virtual void SetPositionAbsolute(int x, int y);
	virtual void Update(bool direction, float analog_x, float analog_y, int xLocation, int yLocation) = 0;
	void Render();
	virtual bool IsAttacking();
protected:
	void SetDamageAmount(int damage);
	
	int m_damage;
	float m_analogx;
	float m_analogy;
	float m_xLocation;
	float m_yLocation;
	bool m_direction;
	CR::Graphics::Sprite *m_playerSprite;
	
	
};