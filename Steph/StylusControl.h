// StylusControl.h: interface for the StylusControl class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_STYLUSCONTROL_H__7622931B_F5A4_4A17_B19A_1099A9EBDBF7__INCLUDED_)
#define AFX_STYLUSCONTROL_H__7622931B_F5A4_4A17_B19A_1099A9EBDBF7__INCLUDED_

#include"../Engines/Graphics/Classes/graphics.h"


class StylusControl  
{
public:
	bool GetMenuStatus();
	void Render();
	void Right();
	void Left();
	void Down();
	void Up();
	void Stop();
	void Attack1(bool dn);
	void Attack2(bool dn);
	void Jump(bool dn);
	void Menu(bool dn);
	void Status(bool dn);
	void Score(bool dn);
	StylusControl();
	virtual ~StylusControl();
private:
	int state;
	CR::Graphics::Sprite *stylus_sprite;
	CR::Graphics::Sprite *stylus_menu;
	CR::Graphics::Sprite *stylus_attack;
	bool attack1,attack2,menu,jump,score,status;
};

#endif // !defined(AFX_STYLUSCONTROL_H__7622931B_F5A4_4A17_B19A_1099A9EBDBF7__INCLUDED_)
