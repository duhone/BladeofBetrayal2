/*
 *  Shotgun.cpp
 *  Steph
 *
 *  Created by Robert Shoemate on 4/13/09.
 *  Copyright 2009 Conjured Realms LLC. All rights reserved.
 *
 */

#include "Shotgun.h"

Shotgun::Shotgun()
{
	SetDamageAmount(4);
	framesetOffset = 2;
}

Shotgun::~Shotgun()
{
}

Projectile* Shotgun::Attack()
{
	Gun::Attack();
}