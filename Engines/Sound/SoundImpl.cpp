/*
 *  SoundImpl.cpp
 *  Steph
 *
 *  Created by Eric Duhon on 6/21/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "SoundImpl.h"
#include "../Database/Database.h"
#include "SoundFX.h"

using namespace std;
using namespace std::tr1;
using namespace CR::Sound;
using namespace CR::Database;

SoundImpl::SoundImpl() : m_database(NULL)
{
}

SoundImpl::~SoundImpl()
{
}

void SoundImpl::SetDatabase(IDatabase* const _database)
{
	m_database = _database;
}

shared_ptr<ISoundFX> SoundImpl::CreateSoundFX(const CR::Utility::Guid &_id)
{
	return shared_ptr<ISoundFX>(new SoundFX());
}