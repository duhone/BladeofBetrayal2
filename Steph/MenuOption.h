// MenuOption.h: interface for the MenuOption class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_MENUOPTION_H__517D638F_C73F_4B1A_941B_311749CA8B7A__INCLUDED_)
#define AFX_MENUOPTION_H__517D638F_C73F_4B1A_941B_311749CA8B7A__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include<vector>
#include<string>

using namespace std;
#include "../Engines/Graphics/Classes/HPT Graphics.h"
#include "SavedGames.h"

class Menu;

#define HPTMENU_GOTOMENU 10000
#define HPTMENU_NEWGAME 10001
#define HPTMENU_REPLAYINTRO 10002
#define HPTMENU_RESUMEGAME 10003
#define HPTMENU_TOGGLEMUSIC 10004
#define HPTMENU_TOGGLESOUND 10005
#define HPTMENU_MUSICVOLUME 10006
#define HPTMENU_SOUNDVOLUME 10007
#define HPTMENU_RUMBLEEFFECT 10008
#define HPTMENU_RUMBLESTRENGTH 10009
#define HPTMENU_NEWGAME_SELECTPROFILE 10010
#define HPTMENU_ADDCHAR 10011
#define HPTMENU_BACKCHAR 10012
#define HPTMENU_CLEARCHAR 10013
#define HPTMENU_SETDIFFICULTY 10014
#define HPTMENU_LOADGAME_SELECTPROFILE 10015
#define HPTMENU_LOADGAME_LOADGAME 10016
#define HPTMENU_LOADGAME_SELECTSPENCER 10017
#define HPTMENU_LOADGAME_SELECTSTEPH 10018

class MenuLabel
{
protected:
	HPTGraphicsEngine *graphics_engine;
public:
	MenuLabel();
	string text;
	int xloc;
	int yloc;
	virtual ~MenuLabel();
	virtual void Render(Menu *menu);

};

class MenuOption : public MenuLabel 
{
protected:
	char *source_text;
public:
	bool *disabled;
	virtual void Down(Menu *menu);
	virtual void Up(Menu *menu);
	MenuOption(char *arg);
	virtual void Right(Menu *menu);
	virtual void Left(Menu *menu);
	virtual void Click(Menu *menu);
	virtual void Render(Menu *menu);
	int command;
	int data;
	int left_move;
	int right_move;
	int up_move;
	int dn_move;
	bool IsDisabled();
	MenuOption(bool *disableble = NULL);
	MenuOption(bool *disableble,const char *arg);
	virtual ~MenuOption();

};

/*class MenuLabel
{
	MenuOption(bool *disableble = NULL);
	virtual ~MenuOption();

};
*/
#endif // !defined(AFX_MENUOPTION_H__517D638F_C73F_4B1A_941B_311749CA8B7A__INCLUDED_)
