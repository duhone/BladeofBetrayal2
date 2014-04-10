#pragma once

#include <stdio.h>

#include "Singleton.h"
#include "MusicObject.h"
#include "SoundObject.h"

//HPT Sound Formats
#define HPT_8_8000_MONO      0x00000001
#define HPT_8_8000_STEREO    0x00000002
#define HPT_16_11000_MONO    0x00000003
#define HPT_16_11000_STEREO  0x00000004
#define HPT_16_44000_STEREO  0x00000005

//! Singleton base template class.
/*!
 Derive from this class to create a Singleton class. The template parameter
 is the name of your derived class. Your derived class must be a friend of 
 this template. Friend classes are bad in general, but could not find another
 way to make this work. Make sure the constructor is private in your dervived
 class to insure no one can create an instance of it. You must have a no argument
 constructor. No other constructors will ever be called.
 
 This template is thread safe.
 
 Example:
 \verbatim
 class MyClass : public Syntax::Utility::Singleton<MyClass>
 {
 friend Syntax::Utility::Singleton<MyClass>;
 public:
 ...
 void Test() ...
 private:
 MyClass();
 ~MyClass();
 }
 
 MyClass::Instance().Test();
 \endverbatim
 */

// User Sound Engine
class SoundEngine : public Syntax::Utility::Singleton<SoundEngine>
{
public:
	virtual ~SoundEngine() {};
	SoundEngine() {};

	 void Release();
	
	 bool LoadHSF(char name[]);
	 void LoadHMF(char *name);
	
	SoundObject* CreateSoundObject(int arg) {}
	MusicObject* GetMusicObject() {}
	
	void SetMidiVolume(int arg) {}
	void SetMidiMute(bool arg) {}
	void SetVolume(int arg) {}
	void SetMute(bool arg) {}

private:
	void ReadFile(FILE *arg);
	
	SoundEngine *_soundEngine;
};

// Retrieve Sound Engine
SoundEngine *GetHPTSoundEngine();
