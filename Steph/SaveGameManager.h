// SaveGameManager.h: interface for the SaveGameManager class.
//
//////////////////////////////////////////////////////////////////////

#pragma once

#include <stdlib.h>
#include <vector>
#include <iostream>
#include <fstream>

using namespace std;

#define BOB_SAVE_VERSION 2
#define DEFAULT_SAVE_FILE "crpds_bob.sav"

struct SettingsInfo
{
	bool soundOn;
	bool musicOn;
	bool analogFlip;
	bool buttonFlip;
	SettingsInfo()
	{
		soundOn = true;
		musicOn = true;
		analogFlip = false;
		buttonFlip = false;
	};
};

struct LevelInfo
{
	// TODO: Store retrieved powerups/etc for the current level
	// to prevent the player from getting them again.
	bool bronzeAchievement;
	bool silverAchievement;
	bool goldAchievement;
	LevelInfo()
	{
		bronzeAchievement = false;
		silverAchievement = false;
		goldAchievement = false;
	};
};

struct SaveGameInfo
{
	int level;
	int health;
	int health_bars;
	int energy;
	int energy_max;
	int score;
	int basic_weapon;
	bool weapons[6];
	int grenades;
	int nlives;
	LevelInfo levelInfo[9];
	SettingsInfo settingsInfo;
	SaveGameInfo()
	{
		level = 1;
		health = 25;
		health_bars = 5;
		energy = 25;
		energy_max = 25;
		score = 0;
		basic_weapon = 3;
		weapons[0] = true;//true;
		weapons[1] = true;//false;
		weapons[2] = true;//false;
		weapons[3] = true;//false;
		weapons[4] = true;//false;
		weapons[5] = true;//false;
		grenades = 3;
		nlives = 3;
	};
};

class SaveGameManager
{
public:
	SaveGameManager();
	virtual ~SaveGameManager();
	
	void SaveGame(SaveGameInfo *game);
	void SaveSettings(SettingsInfo *settings);
	void SaveToDisk(char* saveGameFile);
	void LoadFromDisk(char* saveGameFile);
	void Reset();

	SaveGameInfo GetSaveGameInfo() const {return saveGameInfo;}
	SettingsInfo GetSettingsInfo() const {return saveGameInfo.settingsInfo;}
	//void Temp(int _value) {temp = _value;}
private:
	int cur_profile;
	SaveGameInfo saveGameInfo;
};
