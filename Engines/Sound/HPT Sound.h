#ifndef HPT_SOUND_ENGINE
#define HPT_SOUND_ENGINE

//HPT Sound Formats
#define HPT_8_8000_MONO      0x00000001
#define HPT_8_8000_STEREO    0x00000002
#define HPT_16_11000_MONO    0x00000003
#define HPT_16_11000_STEREO  0x00000004
#define HPT_16_44000_STEREO  0x00000005

class HPTSoundObject
{
public:
	HPTSoundObject() {};
	virtual ~HPTSoundObject() {};
	virtual void Play() = 0;
	virtual void Release() = 0;
	virtual void ChangeSound(int arg) = 0;
};

class HPTMusicObject
{
public:
	HPTMusicObject() {};
	virtual ~HPTMusicObject() {};
	virtual void Release() = 0;
	virtual void Play() = 0;
	virtual void Stop() = 0;
	virtual void ChangeSong(int arg) = 0;
};

// User Sound Engine
class HPTSoundEngine
{
public:

	HPTSoundEngine() {};
	virtual ~HPTSoundEngine() {};
	virtual void Release() = 0;
	
	virtual bool LoadHSF(char name[]) = 0;
	virtual void LoadHMF(char *name) = 0;
	virtual HPTSoundObject* CreateSoundObject(int arg) = 0;
	virtual HPTMusicObject* GetMusicObject() = 0;
	virtual void SetMidiVolume(int arg) = 0;
	virtual void SetMidiMute(bool arg) = 0;
	virtual void SetVolume(int arg) = 0;
	virtual void SetMute(bool arg) = 0;
};

// Retrieve Sound Engine
HPTSoundEngine *GetHPTSoundEngine();

#endif
