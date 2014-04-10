// StylusControl.cpp: implementation of the StylusControl class.
//
//////////////////////////////////////////////////////////////////////


#include "StylusControl.h"
#include "AssetList.h"

using namespace CR::Graphics;

extern GraphicsEngine *graphics_engine;

#define STOP 0
#define UP 4
#define DOWN 5
#define LEFT 6
#define RIGHT 7


//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

StylusControl::StylusControl()
{
	stylus_sprite = graphics_engine->CreateSprite1();
	stylus_sprite->SetImage(CR::AssetList::Stylus_Buttons);
	stylus_menu = graphics_engine->CreateSprite1();
	stylus_menu->SetImage(CR::AssetList::stylus_menu_and_weapon_buttons);
	stylus_attack = graphics_engine->CreateSprite1();
	stylus_attack->SetImage(CR::AssetList::stylus_attack_and_jump_buttons);
	state = STOP;
	attack1 = false;
	attack2 = false;
	menu = false;
	jump = false;
	status = false;
	score = false;

}

StylusControl::~StylusControl()
{
	stylus_sprite->Release();
	stylus_menu->Release();
	stylus_attack->Release();
}

void StylusControl::Attack1(bool dn)
{
	attack1 = dn;

}

void StylusControl::Attack2(bool dn)
{
	attack2 = dn;

}

void StylusControl::Jump(bool dn)
{
	jump = dn;

}

void StylusControl::Menu(bool dn)
{
	menu = dn;

}

void StylusControl::Status(bool dn)
{
	status = dn;

}

void StylusControl::Score(bool dn)
{
	score = dn;

}

void StylusControl::Stop()
{
	state = STOP;
}

void StylusControl::Up()
{
	state = UP;
}

void StylusControl::Down()
{
	state = DOWN;
}

void StylusControl::Left()
{
	state = LEFT;
}

void StylusControl::Right()
{
	state = RIGHT;
}

void StylusControl::Render()
{
/*//motion buttons
	stylus_sprite->SetPositionAbsalute(131,277);
	if(status) stylus_sprite->SetFrame(1);
		else stylus_sprite->SetFrame(0);
	stylus_sprite->Render();
	stylus_sprite->SetPositionAbsalute(156,277);
	if(score) stylus_sprite->SetFrame(3);
		else stylus_sprite->SetFrame(2);
	stylus_sprite->Render();

// action buttons	
	stylus_menu->SetPositionAbsalute(143,303);
	if(menu) stylus_menu->SetFrame(1);
		else stylus_menu->SetFrame(0);
	stylus_menu->Render();
	stylus_attack->SetPositionAbsalute(200,263);
	if(attack1) stylus_attack->SetFrame(1);
		else stylus_attack->SetFrame(0);
	stylus_attack->Render();
	stylus_attack->SetPositionAbsalute(200,298);
	if(jump) stylus_attack->SetFrame(3);
		else stylus_attack->SetFrame(2);
	stylus_attack->Render();
*/

}

bool StylusControl::GetMenuStatus()
{
	return menu;
}
