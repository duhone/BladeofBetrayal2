/*
 *  OptionsMenuPage.cpp
 *  BoB
 *
 *  Created by Robert Shoemate on 2/1/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "OptionsMenuPage.h"
#include "menu.h"
#include "AssetList.h"

using namespace CR::Graphics;

extern GraphicsEngine *graphics_engine;

OptionsMenuPage::OptionsMenuPage(Menu *menu, SaveGameManager *savedGames) : IMenuPage(menu)
{
	this->savedGames = savedGames;
	showSelectionSprite = false;
	
	settingsInfo.soundOn = savedGames->GetSettingsInfo().soundOn;
	settingsInfo.musicOn = savedGames->GetSettingsInfo().musicOn;
	settingsInfo.analogFlip = savedGames->GetSettingsInfo().analogFlip;
	settingsInfo.buttonFlip = savedGames->GetSettingsInfo().buttonFlip;
	
	selectionSprite = graphics_engine->CreateSprite1();
	selectionSprite->SetImage(CR::AssetList::options_selected);
	
	menuButton = new Input_Button();
	menuButton->SetSpriteAndBounds(12, 11, CR::AssetList::menu_menu_buttons);
	menuButton->SetSoundOn(true);
	input_objects.push_back(menuButton);
	
	soundToggle = new Input_Toggle();
	soundToggle->SetSprite(CR::AssetList::options_on_off);
	soundToggle->SetPosition(405, 82);
	soundToggle->SetTouchBounds(0, 54, 480, 58);
	soundToggle->OnToggled += Delegate(this, &OptionsMenuPage::OnToggledSound);
	soundToggle->ToggleOn(settingsInfo.soundOn);
	soundToggle->SetSoundOn(true);
	input_objects.push_back(soundToggle);
	
	musicToggle = new Input_Toggle();
	musicToggle->SetSprite(CR::AssetList::options_on_off);
	musicToggle->SetPosition(405, 143);
	musicToggle->SetTouchBounds(0, 115, 480, 58);
	musicToggle->OnToggled += Delegate(this, &OptionsMenuPage::OnToggledMusic);
	musicToggle->ToggleOn(settingsInfo.musicOn);
	musicToggle->SetSoundOn(true);
	input_objects.push_back(musicToggle);
	
	analogToggle = new Input_Toggle();
	analogToggle->SetSprite(CR::AssetList::options_on_off);
	analogToggle->SetPosition(405, 204);
	analogToggle->SetTouchBounds(0, 178, 480, 58);
	analogToggle->OnToggled += Delegate(this, &OptionsMenuPage::OnToggledAnalog);
	analogToggle->ToggleOn(settingsInfo.analogFlip);
	analogToggle->SetSoundOn(true);
	input_objects.push_back(analogToggle);
	
	buttonToggle = new Input_Toggle();
	buttonToggle->SetSprite(CR::AssetList::options_on_off);
	buttonToggle->SetPosition(405, 266);
	buttonToggle->SetTouchBounds(0, 238, 480, 58);
	buttonToggle->OnToggled += Delegate(this, &OptionsMenuPage::OnToggledButton);
	buttonToggle->ToggleOn(settingsInfo.buttonFlip);
	buttonToggle->SetSoundOn(true);
	input_objects.push_back(buttonToggle);
	
	resetButton = new Input_Button();
	resetButton->SetSpriteAndBounds(327, 11, CR::AssetList::button_data_reset);
	resetButton->OnClicked += Delegate(this, &OptionsMenuPage::OnResetButtonClicked);
	input_objects.push_back(resetButton);
	resetButton->SetSoundOn(true);
	resetButton->Disabled(false);
	
	yesButton = new Input_Button();
	yesButton->SetSpriteAndBounds(137, 133, CR::AssetList::button_yes);
	yesButton->OnClicked += Delegate(this, &OptionsMenuPage::OnYesButtonClicked);
	input_objects.push_back(yesButton);
	yesButton->SetSoundOn(true);
	yesButton->Disabled(true);
	
	noButton = new Input_Button();
	noButton->SetSpriteAndBounds(252, 133, CR::AssetList::button_no);
	noButton->OnClicked += Delegate(this, &OptionsMenuPage::OnNoButtonClicked);
	input_objects.push_back(noButton);
	noButton->SetSoundOn(true);
	noButton->Disabled(true);
	
	resetPopupSprite = graphics_engine->CreateSprite1();
	resetPopupSprite->SetImage(CR::AssetList::reset_popup);
	resetPopupSprite->SetPositionAbsalute(240, 160);
	showResetDialog = false;
}

OptionsMenuPage::~OptionsMenuPage()
{
	delete menuButton;
	delete soundToggle;
	delete musicToggle;
	delete analogToggle;
	delete buttonToggle;
	delete resetButton;
	delete yesButton;
	delete noButton;
	selectionSprite->Release();
	resetPopupSprite->Release();
}

int OptionsMenuPage::GetBackgroundImage() const
{
	return CR::AssetList::menu_options_background;
}

void OptionsMenuPage::Update(float time)
{
	//menuButton->Render();
	menuButton->Update(time);
	soundToggle->Update(time);
	musicToggle->Update(time);
	analogToggle->Update(time);
	buttonToggle->Update(time);
	resetButton->Update(time);
	yesButton->Update(time);
	noButton->Update(time);
}

void OptionsMenuPage::Render()
{
	menuButton->Render();
	
	if (showSelectionSprite)
		selectionSprite->Render();
	
	soundToggle->Render();
	musicToggle->Render();
	analogToggle->Render();
	buttonToggle->Render();
	resetButton->Render();
	
	if (showResetDialog)
	{
		resetPopupSprite->Render();
		yesButton->Render();
		noButton->Render();
	}
}

void OptionsMenuPage::InputChanged()
{
	if (menuButton->WasPressed())
	{
		// save settings here
		savedGames->SaveSettings(&settingsInfo);
		savedGames->SaveToDisk(DEFAULT_SAVE_FILE);
		menu->ChangeState(menu_main);
	}
	
	if (soundToggle->IsDown())
	{
		showSelectionSprite = true;
		selectionSprite->SetPositionAbsalute(276, 83);
	}
	else if (musicToggle->IsDown())
	{
		showSelectionSprite = true;
		selectionSprite->SetPositionAbsalute(276, 142);
	}
	else if (analogToggle->IsDown())
	{
		showSelectionSprite = true;
		selectionSprite->SetPositionAbsalute(276, 202);
	}
	else if (buttonToggle->IsDown())
	{
		showSelectionSprite = true;
		selectionSprite->SetPositionAbsalute(276, 264);
	}
}


void OptionsMenuPage::OnToggledSound()
{
	// TODO: Toggle sound in sound engine
	settingsInfo.soundOn = soundToggle->IsToggleOn();
	
	soundPlayer->Mute(!settingsInfo.soundOn);
}

void OptionsMenuPage::OnToggledMusic()
{
	// TODO: Toggle music in sound engine
	settingsInfo.musicOn = musicToggle->IsToggleOn();
	
	musicPlayer->Mute(!settingsInfo.musicOn);
	if (settingsInfo.musicOn)
		musicPlayer->Play();
}

void OptionsMenuPage::OnToggledAnalog()
{
	settingsInfo.analogFlip = analogToggle->IsToggleOn();
}

void OptionsMenuPage::OnToggledButton()
{
	settingsInfo.buttonFlip = buttonToggle->IsToggleOn();
}


void OptionsMenuPage::OnResetButtonClicked()
{
	yesButton->Disabled(false);
	noButton->Disabled(false);
	menuButton->Disabled(true);
	soundToggle->Disabled(true);
	musicToggle->Disabled(true);
	analogToggle->Disabled(true);
	buttonToggle->Disabled(true);
	resetButton->Disabled(true);
	
	showResetDialog = true;
}

void OptionsMenuPage::OnYesButtonClicked()
{	
	menu->GetGame()->GetSaveGameManager()->Reset();
	menu->GetGame()->GetGameStateManager()->Reset();
	menu->GetGame()->GetLevelStateManager()->Reset();
	menu->SetCanResume(false);
	
	
	yesButton->Disabled(true);
	noButton->Disabled(true);
	menuButton->Disabled(false);
	soundToggle->Disabled(false);
	musicToggle->Disabled(false);
	analogToggle->Disabled(false);
	buttonToggle->Disabled(false);
	resetButton->Disabled(false);
	
	showResetDialog = false;
}

void OptionsMenuPage::OnNoButtonClicked()
{
	yesButton->Disabled(true);
	noButton->Disabled(true);
	menuButton->Disabled(false);
	soundToggle->Disabled(false);
	musicToggle->Disabled(false);
	analogToggle->Disabled(false);
	buttonToggle->Disabled(false);
	resetButton->Disabled(false);
	
	showResetDialog = false;
}
