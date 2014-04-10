/*
 *  Pistol.h
 *  Steph
 *
 *  Created by Robert Shoemate on 4/11/09.
 *  Copyright 2009 Conjured Realms LLC. All rights reserved.
 *
 */
#pragma once
#include "Weapon.h"
#include "Gun.h"

class Pistol : public Gun
{
public:
	Pistol();
	virtual ~Pistol();
	Projectile* Attack();
};