/*
 *  IActiveSound.h
 *  Sound
 *
 *  Created by Matthew Shoemate on 1/20/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#pragma once

#include "SoundEngine.h"

class IActiveSound
	{
	public:
		IActiveSound() {};
		virtual ~IActiveSound() {};		
		
		virtual bool IsDone() = 0;
		virtual void StartSound(SoundObject* arg) = 0;
	};
