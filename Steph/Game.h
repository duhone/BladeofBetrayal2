// Game.h: interface for the Game class.
//
//////////////////////////////////////////////////////////////////////

#pragma once

#include "Level.h"
#include "../Engines/Input/Classes/input_engine.h"
#include "player.h"
#include "./aiengine/aiengine.h"
#include "enemy.h"
#include "theater.h"
#include "IGame.h"
#include "menu.h"
#include "projectile.h"
#include "BroadcastMessage.h"
#include "ProgressMeter.h"
#include "ProjectilePoints.h"
#include "TransitionScreen.h"
#include "GEnemies.h"
#include "SaveGameManager.h"
#include "LevelStateManager.h"
#include "MeterBar.h"
#include "TimeDisplay.h"
#include "TallyDisplay.h"
#include "CRMusicPlayer.h"
#include "CRSoundPlayer.h"
#include "FSM.h"
#include <vector>
#include <list>
#include <string>

char *hptstrcat(char *x,char *y);

/*enum GAME_STATE 
{
//	game_special = 1,
	game_end = 2,
	game_start = 3,
	game_movie = 4,
	game_credits = 5,
	game_paused = 6,
	game_menu = 7,
	game_ingame = 8,
//	game_test = 9,
	game_death = 10,
//	game_demo = 11,
	game_scores = 12,
	game_new_score = 13,
	FORCE_DWORD = 0x7fffffff
};*/

typedef int GAME_STATE;

#define	game_end 0
#define	game_start 1
#define	game_movie 2
#define	game_credits 3
#define	game_paused 4
#define	game_menu 5
#define	game_ingame 6
#define	game_death 7
#define game_level_load 8
#define game_level_end 9

class Game: public Input_Controller, public IGame
{
public:
	Game();
	virtual ~Game();
	
	//IGame
	virtual void StartGame(int nLevel, bool skipMovie);
	virtual void SetVideoQuality(int arg);
	virtual int GetVideoQuality();
	virtual bool GetEnableStatus();
	virtual void SetEnableStatus(bool arg);
	virtual void Resume();
	virtual void ReplayIntro();
	virtual SaveGameManager *GetSaveGameManager() { return &saved_games; }
	virtual GameStateManager *GetGameStateManager() { return &gameStateManager; }
	virtual LevelStateManager *GetLevelStateManager() { return &levelStateManager; }
	
	//Game
	void SetSpawnPoints();
	void UpdateHUD();
	void RenderHUD();
	void Render();
	void ProcessDemo();
	void EndLevelScreen();
	void ProcessDeath();
	void PlayerDeathState1();
	void PlayerDeathState2();
	void PlayerDeathState3();
	void PlayerDeathState4();
	void Initialize();
	void PlayerDeath();
	void EndLevel();
	void LoadLevel1();
	void LoadLevel2();
	void LoadLevel3();
	void LoadLevel4();
	void LoadLevel5();
	void LoadLevel6();
	void LoadLevel7();
	void LoadLevel8();
	void LoadLevel9();
	void LevelTransition(bool arg = true);
	void LoadLevel(int arg);
	void InputChanged();
	void ProcessMovie();
	void ProcessMenu();
	void ProcessGame();
	void ProcessPause();
	void ProcessCredits();
	void ProcessTest();
	void ProcessStart();
	void ProcessEnd();
	void ProcessLevelLoad();
	void ProcessEndLevel();
	void ChangeState(GAME_STATE newState);
	void ApplicationTerminated();
	void ExecuteGame();

	int GetCompletionPercent();
	int GetAchievementsCount();
	
	GAME_STATE ActiveGState;
	GAME_STATE RequestGState;
	GAME_STATE PauseGState;
	int video_quality;
	Level *level_class;
	CR::Graphics::Background *static_background;
	Player *player;
	AIEngine* ai_engine;
	AIObject aiobject;
	std::vector<Enemy*> enemys;
	std::vector<Enemy*> activeEnemys;
//	Font* blue12;
	CR::Graphics::Font* gothic12;
	CR::Graphics::Font* gothic10r;
	CR::Graphics::Font* bankGothic;
		void CaptureSpawnPointInfo();
	
	float AnalogX() const { return analogStick->AnalogX();}
	float AnalogY() const { return analogStick->AnalogY();}
private:
	//Event handlers
	void OnClickedLevelLoadScreen();
	void OnClickedPauseButton();
	void OnClickedResumeGameButton();
	void OnClickedQuitGameButton();
	void LoadLevelPhase1();
	void LoadLevelPhase2();
	void LoadLevelPhase3();
	void LoadLevelPhase4();
	void LoadLevelPhase5();
	
	SpawnPointInfo m_SpawnPointInfo;

	
	void SaveLevelState();
	void SaveGameState(bool canResume);
	void SaveGame();
	
	int new_score_entry;
	bool enable_score;
	bool enable_status;
	int enemy_hits;
	int player_hits;
	bool disable_input;
	int screen_size;
	int level_end_efficiency;
	int level_end_score;
	int basic_bonus_points;
	int treasure_bonus_points;
	int special_bonus_points;
	int combat_bonus;
	int bonus_points;
	unsigned int avail_mem;
	bool new_level;
	bool key_pressed;
	int current_level;
	Theater *cut_scenes;
	unsigned int starttime;
	unsigned int currenttime;
	float timerfreq;
	int nframes;

	float time;
	
	Menu *menu;
	CR::Graphics::Background* level_load;
	CR::Graphics::Background* level_end;
	std::list<Projectile*> projectile_list;
	SaveGameManager saved_games;
	GameStateManager gameStateManager;
	LevelStateManager levelStateManager;
	ProgressMeter *m_ProgressMeter;
	
	// Performance Variables
	float frame_rate_count;
	float frame_rate;
	
	// Input Engine
	Input_Analog *analogStick;
	Input_Button *jumpButton;
	Input_Button *attackButton;
	Input_Button *grenadeButton;
	Input_Button *pauseButton;
	Input_WeaponSelect *weaponSelect;
	Input_Button *resumeGameButton;
	Input_Button *quitGameButton;
	Input_Button* loadScreenButton;
	Input_Button* endScreenButton;
	Input_Button* deathScreenButton;
	
	// HUD Sprites
	MeterBar *healthMeterBar;
	MeterBar *energyMeterBar;
	TimeDisplay *timeDisplay;
	
	// Other Sprites
	CR::Graphics::Sprite *pauseBackground;
	TransitionScreen *transition;
	CR::Graphics::Sprite *loadingButton;
	CR::Graphics::Sprite *awardInfo;
	CR::Graphics::Sprite *loadingLevelTags;
	CR::Graphics::Sprite *loadingObjectiveTags;
	//Sprite *tallyFont;
	CR::Graphics::Sprite *endTally;
	CR::Graphics::Sprite *medalsSprite;
	TimeDisplay *endTimeDisplay;
	bool bronzeAwardReceived;
	bool silverAwardReceived;
	bool goldAwardReceived;
	
	TallyDisplay *itemsTallyDisplay;
	TallyDisplay *enemiesTallyDisplay;
	int tallyNumEnemies;
	int tallyNumDeadEnemies;
	int tallyNumObjects;
	int tallyNumGotObjects;
	
	std::string m_levelLoadingText;
	int m_levelLoadImage;
	int m_levelStaticBackground;
	int m_levelLoadState;
	float m_playTime;
	
	CR::Utility::SimpleFSM<5> m_levelEndFSM;
	CR::Utility::SimpleFSM<4> m_playerDeathFSM;
	
	void LevelEndState1();
	void LevelEndState2();
	void LevelEndState3();
	void LevelEndState4();
	void LevelEndState5();

	void OnEndScreenClick()
	{
		if (endTimeDisplay->DoneAnimating() && enemiesTallyDisplay->DoneAnimating() && itemsTallyDisplay->DoneAnimating())
		{
			m_levelEndFSM++;
		}
		else
		{
			endTimeDisplay->SetDoneAnimating();
			enemiesTallyDisplay->SetDoneAnimating();
			itemsTallyDisplay->SetDoneAnimating();
		}
		
		
		//transition->Begin(false, 0);
	}
	
	void OnClickedDeathScreen()
	{
		m_playerDeathFSM++;
	}
	
	bool resumeGame;
	void InitializeLevelState();
	
	std::vector<float> levelAchievementTimes;
	
	bool GotGoldAchievement();
	bool GotSilverAchievement();
	bool GotBronzeAchievement();
};
