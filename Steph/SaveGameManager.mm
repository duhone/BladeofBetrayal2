#include "SaveGameManager.h"
#include <stdio.h>
#include <string.h>
#import <UIKit/UIKit.h>

SaveGameManager::SaveGameManager()
{
}

SaveGameManager::~SaveGameManager()
{
}

void SaveGameManager::SaveGame(SaveGameInfo *game)
{
	saveGameInfo.level = game->level;
	saveGameInfo.health = game->health;
	saveGameInfo.health_bars = game->health_bars;
	saveGameInfo.energy = game->energy;
	saveGameInfo.energy_max = game->energy_max;
	saveGameInfo.score = game->score;
	saveGameInfo.basic_weapon = game->basic_weapon;
	saveGameInfo.weapons[0] = game->weapons[0];
	saveGameInfo.weapons[1] = game->weapons[1];
	saveGameInfo.weapons[2] = game->weapons[2];
	saveGameInfo.weapons[3] = game->weapons[3];
	saveGameInfo.weapons[4] = game->weapons[4];
	saveGameInfo.weapons[5] = game->weapons[5];
	saveGameInfo.grenades = game->grenades;
	saveGameInfo.nlives = game->nlives;
	
	for (int i = 0; i < 9; i++)
	{
		saveGameInfo.levelInfo[i] = game->levelInfo[i];
	}
}

void SaveGameManager::SaveSettings(SettingsInfo *settings)
{
	saveGameInfo.settingsInfo.soundOn = settings->soundOn;
	saveGameInfo.settingsInfo.musicOn = settings->musicOn;
	saveGameInfo.settingsInfo.analogFlip = settings->analogFlip;
	saveGameInfo.settingsInfo.buttonFlip = settings->buttonFlip;
}

void SaveGameManager::LoadFromDisk(char* saveGameFile)
{
	// Get the documents directory path of bob.sav
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *file = [documentsDirectory stringByAppendingPathComponent: [[NSString alloc] initWithCString: saveGameFile]];
	const char* fileName = [file cStringUsingEncoding:1];

	if (FILE *file = fopen(fileName, "r"))
	{
		// Read the header tag and version
		char headerTag[7];// = "BoBSav";
		int version = 0;
		
		fread(&headerTag, sizeof(char), 7, file);
		fread(&version, sizeof(int), 1, file);
		
		// check if file read is of the correct version
		if (strcmp(headerTag, "BoBSav") != 0 || version != BOB_SAVE_VERSION)
		{
			// don't read the saveGameInfo structure, this file is corrupt, or an older version
		}
		else
		{
			// SaveGameInfo Structure
			fread(&saveGameInfo, sizeof(struct SaveGameInfo), 1, file);
			
			// Weapons
			for (int i = 0; i < 6; i++)
			{
				fread(&saveGameInfo.weapons[i], sizeof(bool), 1, file);
			}
			
			// Levels
			for (int i = 0; i < 9; i++)
			{
				fread(&saveGameInfo.levelInfo[i], sizeof(LevelInfo), 1, file);
			}
			
			// Settings
			fread(&saveGameInfo.settingsInfo, sizeof(SettingsInfo), 1, file);
		}
		
		fclose(file);		
	}
	else
	{
		// file does not exist, leave default settings
	}
}

void SaveGameManager::SaveToDisk(char* saveGameFile)
{
	// Get the documents directory path of bob.sav
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *file = [documentsDirectory stringByAppendingPathComponent: [[NSString alloc] initWithCString: saveGameFile]];
	const char* fileName = [file cStringUsingEncoding:1];
	
	if (FILE *file = fopen(fileName, "w"))
	{
		// Write the header tag, and file version
		char headerTag[] = "BoBSav";
		int version = BOB_SAVE_VERSION;
		
		fwrite(&headerTag, sizeof(headerTag), 1, file);
		fwrite(&version, sizeof(int), 1, file);
		
		// SaveGameInfo Structure
		fwrite(&saveGameInfo, sizeof(struct SaveGameInfo), 1, file);
		
		// Weapons
		for (int i = 0; i < 6; i++)
		{
			fwrite(&saveGameInfo.weapons[i], sizeof(bool), 1, file);
		}
		
		// Levels
		for (int i = 0; i < 9; i++)
		{
			fwrite(&saveGameInfo.levelInfo[i], sizeof(LevelInfo), 1, file);
		}
		
		// Settings
		fwrite(&saveGameInfo.settingsInfo, sizeof(SettingsInfo), 1, file);
		
		fclose(file);
	}
	else
	{
		// could not open file for writing
	}
}

void SaveGameManager::Reset()
{
	SaveGameInfo defaultSaveGame;
	SaveGame(&defaultSaveGame);
	SaveToDisk(DEFAULT_SAVE_FILE);
}