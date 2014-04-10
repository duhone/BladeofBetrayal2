// MenuOption.cpp: implementation of the MenuOption class.
//
//////////////////////////////////////////////////////////////////////

#include "Menu.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////


MenuLabel::MenuLabel()
{
	graphics_engine = GetHPTGraphicsEngine();


}

MenuLabel::~MenuLabel()
{
	graphics_engine->Release();
}


void MenuLabel::Render(Menu *menu)
{
	graphics_engine->Position(xloc,yloc);
	(*graphics_engine) << (char*) text.c_str();
	
}

MenuOption::MenuOption(bool *disableble)
{
//	graphics_engine = GetHPTGraphicsEngine();
	disabled = disableble;
	source_text = NULL;
	left_move = 0;
	right_move = 0;
	up_move = -1;
	dn_move = 1;
}

MenuOption::MenuOption(bool *disableble,const char *arg)
{
//	graphics_engine = GetHPTGraphicsEngine();
	disabled = disableble;
	source_text = (char*)arg;
	left_move = 0;
	right_move = 0;
	up_move = -1;
	dn_move = 1;
}

MenuOption::~MenuOption()
{
//	graphics_engine->Release();
}

void MenuOption::Render(Menu *menu)
{
	bool tempb;
	graphics_engine->Position(xloc,yloc);
	if(source_text != NULL)
		(*graphics_engine) << source_text;
	else
		(*graphics_engine) << (char*) text.c_str();
	
	switch(command)
	{
	case HPTMENU_TOGGLEMUSIC:
		if(menu->GetMusicMute()) (*graphics_engine) << "  -  OFF";
		else (*graphics_engine) << "  -  ON";
		break;
	case HPTMENU_TOGGLESOUND:
		if(menu->GetSoundMute()) (*graphics_engine) << "  -  OFF";
		else (*graphics_engine) << "  -  ON";
		break;
	case HPTMENU_MUSICVOLUME:
		(*graphics_engine) << "  -  "<< menu->GetMusicVolume()*10 << "%";
		break;
	case HPTMENU_SOUNDVOLUME:
		(*graphics_engine) << "  -  "<< menu->GetSoundVolume()*10 << "%";
		break;
	case HPTMENU_RUMBLEEFFECT:
		if(menu->GetRumbleEffect()) (*graphics_engine) << "  -  OFF";
		else (*graphics_engine) << "  -  ON";
		break;

	};
}

void MenuOption::Click(Menu *menu)
{
	switch(command)
	{
	case HPTMENU_NEWGAME:
		menu->NewGame();
		break;
	case HPTMENU_REPLAYINTRO:
		menu->ReplayIntro();
		break;
	case HPTMENU_RESUMEGAME:
		menu->ResumeGame();
		break;
	case HPTMENU_GOTOMENU:
		menu->GoToMenu(data);
		break;
	case HPTMENU_TOGGLEMUSIC:
		menu->SetMusicMute(!menu->GetMusicMute());
		break;
	case HPTMENU_TOGGLESOUND:
		menu->SetMuteSound(!menu->GetSoundMute());
		break;
	case HPTMENU_RUMBLEEFFECT:
		menu->SetRumbleEffect(!menu->GetRumbleEffect());
		break;
	case HPTMENU_NEWGAME_SELECTPROFILE:
		menu->SetProfile(data);
		menu->ClearName();
		menu->GoToMenu(3);
		break;
	case HPTMENU_LOADGAME_SELECTPROFILE:
		
		menu->SetProfile(data);
		menu->SetStephText();
		//menu->ClearName();
		menu->GoToMenu(6);

		break;
	case HPTMENU_ADDCHAR:
		menu->AddCharacter(data);
		break;
	case HPTMENU_CLEARCHAR:
		menu->ClearName();
		break;
	case HPTMENU_BACKCHAR:
		menu->BackCharacter();
		break;
	case HPTMENU_SETDIFFICULTY:
		menu->SetDifficulty(data);
		menu->NewGame();
		break;
	case HPTMENU_LOADGAME_SELECTSPENCER:
		menu->SetQuikSaveText();
		menu->GoToMenu(data);
		break;
	case HPTMENU_LOADGAME_SELECTSTEPH:
		menu->SetQuikSaveText();
		menu->GoToMenu(data);
		break;
	case HPTMENU_LOADGAME_LOADGAME:
		menu->LoadGame(data);
		break;
		
	};


}

bool MenuOption::IsDisabled()
{
	if(disabled == NULL) return false;
	else return (*disabled);
}


void MenuOption::Left(Menu *menu)
{
	menu->ChangeOption(left_move);
	switch(command)
	{
	case HPTMENU_MUSICVOLUME:
		menu->SetMusicVolume(menu->GetMusicVolume() - 1);
		break;
	case HPTMENU_SOUNDVOLUME:
		menu->SetSoundVolume(menu->GetSoundVolume() - 1);
		break;
	case HPTMENU_TOGGLEMUSIC:
		menu->SetMusicMute(!menu->GetMusicMute());
		break;
	case HPTMENU_TOGGLESOUND:
		menu->SetMuteSound(!menu->GetSoundMute());
		break;
	case HPTMENU_RUMBLEEFFECT:
		menu->SetRumbleEffect(!menu->GetRumbleEffect());
		break;
	case HPTMENU_RUMBLESTRENGTH:
		menu->SetRumbleStrength(menu->GetRumbleStrength() - 1);
		break;

	};
}

void MenuOption::Right(Menu *menu)
{
	menu->ChangeOption(right_move);
	switch(command)
	{
	case HPTMENU_MUSICVOLUME:
		menu->SetMusicVolume(menu->GetMusicVolume() + 1);
		break;
	case HPTMENU_SOUNDVOLUME:
		menu->SetSoundVolume(menu->GetSoundVolume() + 1);
		break;
	case HPTMENU_TOGGLEMUSIC:
		menu->SetMusicMute(!menu->GetMusicMute());
		break;
	case HPTMENU_TOGGLESOUND:
		menu->SetMuteSound(!menu->GetSoundMute());
		break;		
	case HPTMENU_RUMBLEEFFECT:
		menu->SetRumbleEffect(!menu->GetRumbleEffect());
		break;
	case HPTMENU_RUMBLESTRENGTH:
		menu->SetRumbleStrength(menu->GetRumbleStrength() + 1);
		break;
	};
}

MenuOption::MenuOption(char *arg)
{
	graphics_engine = GetHPTGraphicsEngine();
	disabled = NULL;
	source_text = arg;
	left_move = 0;
	right_move = 0;
	up_move = -1;
	dn_move = 1;

}

void MenuOption::Up(Menu *menu)
{
	menu->ChangeOption(up_move);
}

void MenuOption::Down(Menu *menu)
{
	menu->ChangeOption(dn_move);

}
