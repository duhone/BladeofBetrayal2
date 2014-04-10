/*
 *  SoundFX.h
 *  Steph
 *
 *  Created by Eric Duhon on 6/21/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */
#include "Sound.h"

using namespace CR::Utility;


namespace CR
{
	namespace Sound
	{		
		class SoundFX : public ISoundFX
			{
			public:
				virtual void Play() {}
				virtual bool Playing() const {return false;}
				virtual void Location(const CR::Math::PointF &_location)  {}
				virtual void Velocity(const CR::Math::Vector3F &_velocity)  {}
			};
	}
}