/*
 *  Sound.h
 *  Steph
 *
 *  Created by Eric Duhon on 5/30/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */
#pragma once
#include <tr1/memory>
#include "../Utility/Singleton.h"
#include "../Math/Point.h"
#include "../Math/Vector.h"
#include "../Utility/Guid.h"
#include "../Database/DatabaseFwd.h"

namespace CR
{
	namespace Sound
	{		
		class ISoundFX
		{
		public:
			virtual void Play() = 0;
			virtual bool Playing() const = 0;
			virtual void Location(const CR::Math::PointF &_location) = 0;
			virtual void Velocity(const CR::Math::Vector3F &_velocity) = 0;
		protected:
			ISoundFX() {}
			virtual ~ISoundFX() {}
		};
		
		class ISound : public CR::Utility::Singleton<ISound>
		{			
			friend class CR::Utility::Singleton<ISound>;
		public:		
			void SetDatabase(CR::Database::IDatabase* const _database);
			std::tr1::shared_ptr<ISoundFX> CreateSoundFX(const CR::Utility::Guid &_id);
			void Mute(bool isMuted);
			bool Mute() const;
		protected:
			ISound();
			virtual ~ISound();	
		private:
			class SoundImpl *m_soundImpl;
		};
	}
}
