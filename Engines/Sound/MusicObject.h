/*
 *  MusicObject.h
 *  Sound
 *
 *  Created by Matthew Shoemate on 1/20/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#pragma once

class MusicObject
	{
	public:
		MusicObject() {};
		virtual ~MusicObject() {};
		virtual void Release();
		virtual void Play();
		virtual void Stop();
		virtual void ChangeSong(int arg);
	};
