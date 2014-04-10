/*
 *  RocketLauncher.cpp
 *  Steph
 *
 *  Created by Robert Shoemate on 4/13/09.
 *  Copyright 2009 Conjured Realms LLC. All rights reserved.
 *
 */

#include "RocketLauncher.h"

RocketLauncher::RocketLauncher()
{
	SetDamageAmount(4);
	framesetOffset = 4;
}

RocketLauncher::~RocketLauncher()
{
}

Projectile* RocketLauncher::Attack()
{
	Gun::Attack();
}