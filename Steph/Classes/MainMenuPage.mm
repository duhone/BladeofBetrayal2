/*
 *  MainMenuPage.cpp
 *  BoB
 *
 *  Created by Robert Shoemate on 1/21/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "MainMenuPage.h"
#include "Menu.h"
#import <UIKit/UIApplication.h>

//extern Input_Engine *input_engine;

MainMenuPage::MainMenuPage(Menu *menu, SaveGameManager *savedGames) : IMenuPage(menu)
{
	this->savedGames = savedGames;
	
	// Create input objects
#ifdef BOB_LITE
	buyGameButton = new Input_Button();
	buyGameButton->SetSpriteAndBounds(27, 161, CR::AssetList::menu_about_buttons);
	buyGameButton->SetSoundOn(true);
	input_objects.push_back(buyGameButton);
#endif
	
	resumeGameButton = new Input_Button();
#ifdef BOB_LITE
	resumeGameButton->SetSpriteAndBounds(243, 161, CR::AssetList::menu_resume_game_buttons);
#else
	resumeGameButton->SetSpriteAndBounds(132, 158, CR::AssetList::menu_resume_game_buttons);	
#endif
	resumeGameButton->SetSoundOn(true);
	input_objects.push_back(resumeGameButton);
	
	missionSelectButton = new Input_Button();
	missionSelectButton->SetSpriteAndBounds(27, 210, CR::AssetList::menu_mission_select_buttons);
	missionSelectButton->SetSoundOn(true);
	input_objects.push_back(missionSelectButton);
	
	optionsButton = new Input_Button();
	optionsButton->SetSpriteAndBounds(243, 210, CR::AssetList::menu_options_buttons);
	optionsButton->SetSoundOn(true);
	input_objects.push_back(optionsButton);
	
	instructionsButton = new Input_Button();
	instructionsButton->SetSpriteAndBounds(27, 258, CR::AssetList::menu_instructions_buttons);
	instructionsButton->SetSoundOn(true);
	input_objects.push_back(instructionsButton);
	
	aboutButton = new Input_Button();
	aboutButton->SetSpriteAndBounds(243, 258, CR::AssetList::menu_about_buttons);
	aboutButton->SetSoundOn(true);
	input_objects.push_back(aboutButton);
}

MainMenuPage::~MainMenuPage()
{
	delete resumeGameButton;
	delete missionSelectButton;
	delete optionsButton;
	delete instructionsButton;
	delete aboutButton;
}

int MainMenuPage::GetBackgroundImage() const
{
	return CR::AssetList::menu_background_02;
}

void MainMenuPage::Render()
{
	if (menu->CanResume())
	{
		resumeGameButton->Disabled(false);
		resumeGameButton->Render();
	}
	else
	{
		resumeGameButton->Disabled(true);
		//resumeGameButton->Render();
	}
	
	missionSelectButton->Render();
	optionsButton->Render();
	instructionsButton->Render();
	aboutButton->Render();
	
#ifdef BOB_LITE
	buyGameButton->Render();
#endif
}

void MainMenuPage::InputChanged()
{
	if (resumeGameButton->WasPressed())
	{
		menu->ChangeState(menu_resume_game);
	}
	else if (missionSelectButton->WasPressed())
	{
		menu->ChangeState(menu_mission_select);
	}
	else if (optionsButton->WasPressed())
	{
		menu->ChangeState(menu_options);
	}
	else if (instructionsButton->WasPressed())
	{
		menu->ChangeState(menu_instructions);
	}
	else if (aboutButton->WasPressed())
	{
		menu->ChangeState(menu_about);
	}
#ifdef BOB_LITE
	else if (buyGameButton->WasPressed())
	{
		[[UIApplication sharedApplication] openURL:[[NSURL alloc]  initWithString: [NSString stringWithCString:"itms://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=308315671&mt=8"]]];
	}
#endif
}