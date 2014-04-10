// AMenu.h: interface for the AMenu class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_AMENU_H__E4AA90A5_22E1_488A_8018_D990AA819D56__INCLUDED_)
#define AFX_AMENU_H__E4AA90A5_22E1_488A_8018_D990AA819D56__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include<vector>
#include<string>

using namespace std;
#include "../Engines/Graphics/Classes/HPT Graphics.h"
#include "MenuOption.h"


class Menu;

class AMenu  
{
private:
	HPTGraphicsEngine *graphics_engine;
	int selection;
	bool False;
	bool True;
public:
	void AddLabel(MenuLabel *arg);
	void ChangeOption(int arg);
	void Right(Menu *menu);
	void Left(Menu *menu);
	void Click(Menu *menu);
	void Down(Menu *menu);
	void Up(Menu *menu);
	void AddOption(MenuOption *arg);
	void Render(Menu *menu,HPTFont1* sel_font,HPTFont1* unsel_font,HPTFont1* grayed_font);
	AMenu();
	virtual ~AMenu();
	vector<MenuOption*> options;
	vector<MenuLabel*> labels;

};

#endif // !defined(AFX_AMENU_H__E4AA90A5_22E1_488A_8018_D990AA819D56__INCLUDED_)
