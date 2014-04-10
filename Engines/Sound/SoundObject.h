/*
 *  SoundObject.h
 *  Sound
 *
 *  Created by Matthew Shoemate on 1/20/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#pragma once

class SoundObject
	{
	public:
		SoundObject(int arg);
		virtual ~SoundObject();
		virtual void Play();
		virtual void Release();
		virtual void ChangeSound(int arg);
		
	private:
		int _sound;
	};
