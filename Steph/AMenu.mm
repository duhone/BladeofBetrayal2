// AMenu.cpp: implementation of the AMenu class.
//
//////////////////////////////////////////////////////////////////////

#include "AMenu.h"
#include "Menu.h"
//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

AMenu::AMenu()
{
	False = false;
	True = true;
	graphics_engine = GetHPTGraphicsEngine();
	selection = 0;
}

AMenu::~AMenu()
{
	int count;
	for(count = 0;count < options.size();count++)
	{
		MenuOption *temp;
		temp = options[count];
		delete temp;
	}
	for(count = 0;count < labels.size();count++)
	{
		MenuLabel *temp;
		temp = labels[count];
		delete temp;
	}
	graphics_engine->Release();

}

void AMenu::Render(Menu *menu,HPTFont1* sel_font,HPTFont1* unsel_font,HPTFont1* grayed_font)
{
	int count;
	int maxlevel = menu->saved_games->GetProfiles()[menu->saved_games->GetCurrentProfile()].max_level;
	for(count = 0;count < options.size();count++)
	{
		if(options[count]->command == HPTMENU_LOADGAME_LOADGAME)
		{
			options[count]->disabled = &False;
			if(options[count]->data > maxlevel)
			{
				options[count]->disabled = &True;
				continue;
			}
		}
		if(options[count]->IsDisabled()) (*graphics_engine) << grayed_font;
		else if(count == selection) (*graphics_engine) << sel_font;
		else (*graphics_engine) << unsel_font;
		options[count]->Render(menu);
	}
	for(count = 0;count < labels.size();count++)
	{
		(*graphics_engine) << unsel_font;
		labels[count]->Render(menu);
	}
}

void AMenu::AddOption(MenuOption *arg)
{
	options.push_back(arg);
}

void AMenu::Up(Menu *menu)
{
	options[selection]->Up(menu);
/*	selection--;
	if(selection < 0)
		selection = options.size() - 1;
	while(options[selection]->IsDisabled())
	{
		selection--;
		if(selection < 0)
			selection = options.size() - 1;

	}*/
}

void AMenu::Down(Menu *menu)
{
	options[selection]->Down(menu);
/*	selection++;
	if(selection >= options.size())
		selection = 0;
	while(options[selection]->IsDisabled())
	{
		selection++;
		if(selection >= options.size())
			selection = 0;

	}*/
}

void AMenu::Click(Menu *menu)
{
	options[selection]->Click(menu);

}

void AMenu::Left(Menu *menu)
{
	options[selection]->Left(menu);
}

void AMenu::Right(Menu *menu)
{
	options[selection]->Right(menu);
}

void AMenu::ChangeOption(int arg)
{
	if(arg > 0)
	{
		selection += arg;
		while(selection >= options.size())
			selection -= options.size();
		while(options[selection]->IsDisabled())
		{
			selection++;
			if(selection >= options.size())
				selection = 0;

		}
	}
	else if(arg < 0)
	{
		selection += arg;
		while(selection < 0)
			selection += options.size();
		while(options[selection]->IsDisabled())
		{
			selection--;
			if(selection < 0)
				selection = options.size() - 1;

		}
	}

}

void AMenu::AddLabel(MenuLabel *arg)
{
	labels.push_back(arg);

}
