/*
 *  Pistol.cpp
 *  Steph
 *
 *  Created by Robert Shoemate on 4/11/09.
 *  Copyright 2009 Conjured Realms LLC. All rights reserved.
 *
 */

#include "Pistol.h"

Pistol::Pistol()
{
	SetDamageAmount(4);
	framesetOffset = 1;
}

Pistol::~Pistol()
{
}

Projectile* Pistol::Attack()
{
	Gun::Attack();
}