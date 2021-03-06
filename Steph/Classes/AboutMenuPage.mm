/*
 *  AboutMenuPage.cpp
 *  BoB
 *
 *  Created by Robert Shoemate on 2/1/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "AboutMenuPage.h"
#include "menu.h"

AboutMenuPage::AboutMenuPage(Menu *menu, SaveGameManager *savedGames) : IMenuPage(menu)
{
	this->savedGames = savedGames;
	
	menuButton = new Input_Button();
	menuButton->SetSpriteAndBounds(12, 11, CR::AssetList::menu_menu_buttons);
	menuButton->SetSoundOn(true);
	input_objects.push_back(menuButton);
	
	aboutSprite = graphics_engine->CreateSprite1();
	aboutSprite->SetImage(CR::AssetList::menu_about_01);
	aboutSprite->SetPositionAbsalute(240, 160);
}

AboutMenuPage::~AboutMenuPage()
{
	delete menuButton;
	aboutSprite->Release();
}

int AboutMenuPage::GetBackgroundImage() const
{
	return CR::AssetList::menu_about_background;
}

void AboutMenuPage::Update(float time)
{
	//menuButton->Render();
}

void AboutMenuPage::Render()
{
	menuButton->Render();
	aboutSprite->Render();
}

void AboutMenuPage::InputChanged()
{
	if (menuButton->WasPressed())
		menu->ChangeState(menu_main);
}
