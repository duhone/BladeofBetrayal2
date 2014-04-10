/*
 *  Gun.cpp
 *  Steph
 *
 *  Created by Robert Shoemate on 4/13/09.
 *  Copyright 2009 Conjured Realms LLC. All rights reserved.
 *
 */

#include "Gun.h"

Gun::Gun()
{
	SetDamageAmount(4);
	framesetOffset = 1;
}

Gun::~Gun()
{
}

Projectile* Gun::Attack()
{
	m_playerSprite->SetFrame(0);
	m_playerSprite->SetFrameRate(8);
	m_playerSprite->SetAutoAnimate(true);
	m_playerSprite->AutoStopAnimate();
}

void Gun::Update(bool direction, float analog_x, float analog_y, int xLocation, int yLocation)
{
	m_direction = direction;
	m_analogx = analog_x;
	m_analogy = analog_y;
	m_xLocation = xLocation;
	m_yLocation = yLocation;
	
	int desiredframe = 1;
	
	if (m_direction)
	{
		if((analog_x > (-3*analog_y)) || (fabs(analog_x) < 0.1f && fabs(analog_y) < 0.1f))
		{
			desiredframe = framesetOffset;
			m_gunAngle = deg0;
		}
		else if((-analog_y) > (3*analog_x))
		{
			desiredframe = framesetOffset + 12;
			m_gunAngle = deg90;
		}
		else
		{
			desiredframe = framesetOffset + 6;
			m_gunAngle = deg45;
		}
		
		if(m_playerSprite->GetFrameSet() != desiredframe)
		{
			m_playerSprite->SetAutoAnimate(false);
			m_playerSprite->SetFrame(0);
			m_playerSprite->SetFrameSet(desiredframe);
		}
		
		SetPositionAbsolute(240 + m_xLocation, 159 + m_yLocation);
	}
	else
	{
		if((-analog_x) > (-3*analog_y) || (fabs(analog_x) < 0.1f && fabs(analog_y) < 0.1f))
		{
			desiredframe = framesetOffset;
			m_gunAngle = deg0;
		}
		else if((-analog_y) > (-3*analog_x))
		{
			desiredframe = framesetOffset + 12;
			m_gunAngle = deg90;
		}
		else
		{
			desiredframe = framesetOffset + 6;
			m_gunAngle = deg45;
		}
		
		if(m_playerSprite->GetFrameSet() != desiredframe)
		{
			m_playerSprite->SetAutoAnimate(false);
			m_playerSprite->SetFrame(0);
			m_playerSprite->SetFrameSet(desiredframe);
		}
		
		SetPositionAbsolute(240 - m_xLocation, 159 + m_yLocation);
	}
}