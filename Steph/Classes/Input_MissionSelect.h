/*
 *  Input_MissionSelect.h
 *  BoB
 *
 *  Created by Robert Shoemate on 1/22/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#pragma once
#include "graphics.h"
#include "Input_Object.h"
#include "AssetList.h"
#include "SaveGameManager.h"
#include "HPTPoint.h"

class Input_MissionSelect : public Input_Object
{
public:
	Input_MissionSelect(SaveGameManager *savedGames);
	~Input_MissionSelect();
	
	void TouchesBeganImpl(UIView *view, NSSet *touches);
	void TouchesMovedImpl(UIView *view, NSSet *touches);
	void TouchesEndedImpl(UIView *view, NSSet *touches);
	void TouchesCancelledImpl(UIView *view, NSSet *touches);
	void Update(float time);
	void Render();
	void Reset(){};
	virtual void FreeResources();
	void SetPosition(int x, int y);
	bool StartLevel() const {return startLevel;}
	//void Temp(int _value) {temp = _value;}
	int LevelToStart() const {return levelToStart + 1;}
	//void Temp(int _value) {temp = _value;}
	
private:
	CR::Graphics::Sprite* levelSelectBaseSprite;
	CR::Graphics::Sprite* levelSelectPushSprite;
	CR::Graphics::Sprite* medalsSprite;
	CR::Graphics::Sprite* chapterLabelsSprite;
	CR::Graphics::Sprite* chapterTagsSprite;
	CR::Graphics::Sprite* rightArrowSprite;
	CR::Graphics::Sprite* leftArrowSprite;
	CR::Graphics::Sprite* missionSelectIcons;
	
	//SaveGameInfo saveGameInfo;
	SaveGameManager *savedGames;
	UITouch *touch;
	
	// drag information
	bool isDragging;
	bool attemptedDrag;
	bool isDrifting;
	bool draggedRight;
	HPTPoint touchPos;
	
	int chapters;
	int currChapter;
	int focusedChapter;
	int chptWidth;
	
	// mission select location
	HPTPoint maxPos;
	HPTPoint minPos;
	HPTPoint stopPos;
	HPTPoint currPos;
	HPTPoint driftVel;
	
	bool startLevelTimer;
	bool startLevel;
	float timeToStart;
	int levelToStart;
};