/*
 *  MissionSelectMenuPage.cpp
 *  BoB
 *
 *  Created by Robert Shoemate on 1/22/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "MissionSelectMenuPage.h"
#include "Menu.h"

//extern Input_Engine *input_engine;

MissionSelectMenuPage::MissionSelectMenuPage(Menu *menu, SaveGameManager *savedGames) : IMenuPage(menu)
{
	this->savedGames = savedGames;
	
	menuButton = new Input_Button();
	menuButton->SetSpriteAndBounds(12, 11, CR::AssetList::menu_menu_buttons);
	menuButton->SetSoundOn(true);
	input_objects.push_back(menuButton);
	
	missionSelect = new Input_MissionSelect(savedGames);
	missionSelect->SetPosition(95, 185);
	input_objects.push_back(missionSelect);
}

MissionSelectMenuPage::~MissionSelectMenuPage()
{
	delete menuButton;
}

int MissionSelectMenuPage::GetBackgroundImage() const
{
	return CR::AssetList::menu_background_01;
}

void MissionSelectMenuPage::Update(float time)
{
	missionSelect->Update(time);
	
	if (missionSelect->StartLevel())
	{
		menu->SetStartLevel(missionSelect->LevelToStart());
		menu->ChangeState(menu_start_game);
	}
}

void MissionSelectMenuPage::Render()
{
	menuButton->Render();
	missionSelect->Render();
}

void MissionSelectMenuPage::InputChanged()
{
	if (menuButton->WasPressed())
		menu->ChangeState(menu_main);
}