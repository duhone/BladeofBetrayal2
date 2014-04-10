/*
 *  IMenuPage.h
 *  BoB
 *
 *  Created by Robert Shoemate on 1/21/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */
#pragma once
#include "Input_Engine.h"
#include "AssetList.h"

class Menu;

class IMenuPage : public Input_Controller
{
//protected:
public:
	IMenuPage(Menu *menu)
	{
		this->menu = menu;
	}
	
	virtual ~IMenuPage(){};
	
	
public:
	virtual int GetBackgroundImage() const = 0;
	virtual void Update(float time){}
	virtual void Render() = 0;
	
protected:
	Menu *menu;
};