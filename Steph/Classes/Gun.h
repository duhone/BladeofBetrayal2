/*
 *  Gun.h
 *  Steph
 *
 *  Created by Robert Shoemate on 4/13/09.
 *  Copyright 2009 Conjured Realms LLC. All rights reserved.
 *
 */
#pragma once
#include "Weapon.h"
#include "ProjectileStephPistol.h"

enum GunAngle
{
	deg0,
	deg45,
	deg90
};

class Gun : public Weapon
{
public:
	Gun();
	virtual ~Gun();
	virtual Projectile* Attack();
	virtual void Update(bool direction, float analog_x, float analog_y, int xLocation, int yLocation);
	
protected:
	GunAngle m_gunAngle;
	int framesetOffset;
};