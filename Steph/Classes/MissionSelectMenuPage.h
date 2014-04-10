/*
 *  MissionSelectMenuPage.h
 *  BoB
 *
 *  Created by Robert Shoemate on 1/22/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */
#pragma once
#include "IMenuPage.h"
#include "SaveGameManager.h"

class Menu;

class MissionSelectMenuPage : public IMenuPage
{
public:
	MissionSelectMenuPage(Menu *menu, SaveGameManager *savedGames);
	~MissionSelectMenuPage();

	int GetBackgroundImage() const;
	void Update(float time);
	void Render();
	void InputChanged();
	
private:
	SaveGameManager *savedGames;
	Input_Button *menuButton;
	Input_MissionSelect *missionSelect;
	
};