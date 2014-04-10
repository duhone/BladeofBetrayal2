/*
 *  Weapon.cpp
 *  Steph
 *
 *  Created by Robert Shoemate on 4/11/09.
 *  Copyright 2009 Conjured Realms LLC. All rights reserved.
 *
 */

#include "Weapon.h"

using namespace CR::Graphics;

Weapon::Weapon()
{
	m_damage = 0;
	m_analogx = 0;
	m_analogy = 0;
	m_playerSprite = NULL;
	m_direction = false;
}

Weapon::~Weapon()
{
}

void Weapon::SetDamageAmount(int damage)
{
	m_damage = damage;
}

void Weapon::SetPlayerSprite(Sprite *playerSprite)
{
	m_playerSprite = playerSprite;
}

void Weapon::Render()
{
	if (m_direction)
		m_playerSprite->Render();
	else
		m_playerSprite->RenderHFlip();
}

bool Weapon::IsAttacking()
{
	return m_playerSprite->IsAnimating();
}

void Weapon::SetPositionAbsolute(int x, int y)
{
	m_playerSprite->SetPositionAbsalute(x, y);
}