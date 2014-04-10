/*
 *  MachineGun.h
 *  Steph
 *
 *  Created by Robert Shoemate on 4/13/09.
 *  Copyright 2009 Conjured Realms LLC. All rights reserved.
 *
 */

#pragma once
#include "Weapon.h"
#include "Gun.h"

class MachineGun : public Gun
{
	public:
		MachineGun();
		virtual ~MachineGun();
		Projectile* Attack();
};