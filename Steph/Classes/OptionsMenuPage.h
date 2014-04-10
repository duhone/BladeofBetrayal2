/*
 *  OptionsMenuPage.h
 *  BoB
 *
 *  Created by Robert Shoemate on 2/1/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */
#pragma once
#include "IMenuPage.h"
#include "SaveGameManager.h"
#include "Event.h"
#include "CRSoundPlayer.h"
#include "CRMusicPlayer.h"

class Menu;

extern CRMusicPlayer *musicPlayer;
extern CRSoundPlayer *soundPlayer;

class OptionsMenuPage : public IMenuPage
{
public:
	OptionsMenuPage(Menu *menu, SaveGameManager *savedGames);
	~OptionsMenuPage();

	int GetBackgroundImage() const;
	void Update(float time);
	void Render();
	void InputChanged();
	
private:
	SaveGameManager *savedGames;
	SettingsInfo settingsInfo;
	Input_Button *menuButton;
	Input_Toggle *soundToggle;
	Input_Toggle *musicToggle;
	Input_Toggle *analogToggle;
	Input_Toggle *buttonToggle;
	CR::Graphics::Sprite *selectionSprite;
	bool showSelectionSprite;
	
	// Reset Game
	CR::Graphics::Sprite *resetPopupSprite;
	Input_Button *resetButton;
	Input_Button *yesButton;
	Input_Button *noButton;
	
	void OnToggledSound();
	void OnToggledMusic();
	void OnToggledAnalog();
	void OnToggledButton();
	
	void OnResetButtonClicked();
	void OnYesButtonClicked();
	void OnNoButtonClicked();
	
	bool showResetDialog;
};