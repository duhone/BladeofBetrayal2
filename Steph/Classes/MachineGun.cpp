/*
 *  MachineGun.cpp
 *  Steph
 *
 *  Created by Robert Shoemate on 4/13/09.
 *  Copyright 2009 Conjured Realms LLC. All rights reserved.
 *
 */

#include "MachineGun.h"

MachineGun::MachineGun()
{
	SetDamageAmount(4);
	framesetOffset = 3;
}

MachineGun::~MachineGun()
{
}

Projectile* MachineGun::Attack()
{
	Gun::Attack();
}