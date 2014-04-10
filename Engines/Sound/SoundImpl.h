/*
 *  SoundImpl.h
 *  Steph
 *
 *  Created by Eric Duhon on 6/21/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */
#include "Sound.h"

namespace CR
{
	namespace Sound
	{
		class SoundImpl
		{			
			friend class CR::Utility::Singleton<ISound>;
		public:		
			SoundImpl();
			virtual ~SoundImpl();
			void SetDatabase(CR::Database::IDatabase* const _database);
			std::tr1::shared_ptr<ISoundFX> CreateSoundFX(const CR::Utility::Guid &_id);
			void Mute(bool isMuted);
			bool Mute() const;
		private:
			CR::Database::IDatabase* m_database;
		};
	}
}