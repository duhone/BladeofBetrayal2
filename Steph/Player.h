// Player.h: interface for the Player class.
//
//////////////////////////////////////////////////////////////////////

#pragma once

#include "IPlayer.h"
#include "Level.h"
#include "SaveGameManager.h"
#include "Pistol.h"
#include "Shotgun.h"
#include "MachineGun.h"
#include "RocketLauncher.h"

#include <vector>

using namespace std;

#define PLAYER_ANIM_ATTACK_CROUCH              5
#define PLAYER_ANIM_ATTACK_JUMP                4
#define PLAYER_ANIM_ATTACK_STANDARD            9
#define PLAYER_ANIM_ATTACK_ELECTRIC            10
#define PLAYER_ANIM_ATTACK_FLAME               12
#define PLAYER_ANIM_ATTACK_GRENADE             13
#define PLAYER_ANIM_ATTACK_PROJECTILE          14
#define PLAYER_ANIM_ATTACK_QUAKE               15

#define PLAYER_ANIM_MOVE                       0
#define PLAYER_ANIM_STAND                      1
#define PLAYER_ANIM_DAMAGE                     11
#define PLAYER_ANIM_JUMP                       3
#define PLAYER_ANIM_CROUCH                     6
#define PLAYER_ANIM_CRAWL                      17
#define PLAYER_ANIM_VICTORY                    17

#define PLAYER_ANIM_CLIMB_LADDER_SIDE          7
#define PLAYER_ANIM_CLIMB_LADDER_BACK          8
#define PLAYER_ANIM_CLIMB_ROPE_TRANSITION_DOWN 2
#define PLAYER_ANIM_CLIMB_ROPE                 16
#define PLAYER_ANIM_CLIMB_LADDER_TRANSITION    18
#define PLAYER_ANIM_CLIMB_ROPE_TRANSITION      19
#define PLAYER_ANIM_CLIMB_ROPE_DOWN            20

#define PLAYER_ANIM_FALL_TRANSITION            21
#define PLAYER_ANIM_DEATH                      22
#define PLAYER_ANIM_LONG_FALL                  23

#define SHOCK_ATTACK_ENERGY           2
#define FLAME_ATTACK_ENERGY           4
#define GRENADE_ATTACK_ENERGY         5
#define PROJECTILE_ATTACK_ENERGY      10
#define QUAKE_ATTACK_ENERGY           20
#define SHIELD_ATTACK_ENERGY         15

#define FR_WALK 20
#define FR_ATTACK 15
#define FR_JUMP 15

#define MAX_GRENADES 5

class Player : public IPlayer  
{
public:	
	Player();
	virtual ~Player();
	
	// Grenades
	int GetGrenades();
	void SetGrenades(int arg);
	void AddGrenades(int arg);
	void ThrowGrenade();
	
	// Attacks
	virtual void SetAttack(int nAttack);
	void PrevAttack();
	void NextAttack();
	virtual int GetBasicAttackDamage();
	virtual void SetBasicAttackDamage(int arg);
	virtual void AddBasicAttackUpgrade();

	bool IsWeaponAvailable(int arg);
	virtual void AddWeapon(int arg);
	void SetAnalogModY(float arg);
	void SetAnalogX(float arg);
	void FreezeForIntro();
	virtual void setTime(float time);


	// Current Level
	 void SetLevel(Level *curLevel) {Player::curLevel = curLevel;};
	void UpdateLevel();

	// Get Transform To Player Location
	void getViewTransform(float *x, float *y);

	// Collision Bounding Boxes
	virtual HPTRect &GetWeaponWorldLoc();
//	virtual HPTRect &GetWorldLoc();
	void updateWorldLoc();

	virtual Level *GetCurLevel();

	virtual void ProcessPreCalculations();
	virtual void processUpdate();
	virtual void Render();
	virtual void RenderHealthBar();
	virtual void RenderEnergyBar();
	virtual void ResetIPlayer();
	virtual void ResetIPlayerFlags();
	void ResetWeapons();

	//virtual void AddScore(int nPoints);
	virtual void doDamage(int nDamageAmount, bool sDirection,int damage_type);
	virtual void doChemicalDamage(int num);
	virtual void doWaterDamage(int num);
	virtual void ActivateBarrierShield();
	virtual void SetSpencerVictory();

	// Movement State Processors
	virtual void setJumpVelocity();
	virtual void processLeft();
	virtual void processRight();
	virtual void processUp();
	virtual void processDown();
	virtual void processAttack();
	virtual void processAttack2();
	virtual void processDamage();
	virtual void processDeath();
	virtual void stop();
	virtual void UnCrouch();
	bool getSteph() {return steph;};
	void setSteph(bool arg) 
	{
		if(steph_top == NULL && arg == true)
		{
			steph_top = graphics_engine->CreateSprite1();	
			steph_top->SetImage(CR::AssetList::Steph_upper);
		}
		if(steph_top != NULL && arg == false)
		{
			steph_top->Release();
			steph_top = NULL;
		}
		
		if (arg == true)
		{
			weapons1.push_back(new Pistol());
			EquipWeapon(weapons1[0]);
		}
		
		steph = arg;
	};
	void AutoGrabLadder();
	void LadderCompensate();
	void BelowFeetLadderCheck();
	void UnderWaterCheck();
	void FallingCheck();

	bool isTileAboveHead();
	bool isSpecialAttack();

	void EquipWeapon(Weapon *weapon);
	
	bool S_ROPE_PULL;
	bool S_BARRIER_SHIELD;
	CR::Graphics::Sprite *bshield_spr[4];
	CR::Graphics::Sprite *gashelm_spr;

	int  nBarrierOrbs;

	int  ropePullUp;
	int  ropePullDown;

	void LadderDownGrab();
	void LadderDown();
	void LadderUpGrab();
	void LadderUp();

	 void CalcWorldOffset();

	Level *curLevel;
	int xQuakeAttackModifier;
	int yQuakeAttackModifier;
	int xWorldOffset;
	int yWorldOffset;
	int xLevelPos;
	int yLevelPos;
	
	int xFallBegin;
	int yFallBegin;

	float underWaterTimer;

	float deathtimer;
	float bubbletimer;
	float quaketimer;
	int attacks[6];
	char debug_msg[255];
	bool S_JACOB_INVIS;
	int current_weapon;
	
	LevelInfo levelAwards[9];
	
	void InBossBattle(bool _value)
	{
		this->inBossBattle = _value;
		if (inBossBattle)
		{
			bossUsedOnlyBasicAttack = true;
			bossNoDamageTaken = true;
		}
	}
	
	bool inBossBattle;
	bool bossUsedOnlyBasicAttack;
	bool bossNoDamageTaken;
	
	bool goLeft;
	bool goRight;
	bool goUp;
	bool goDown;
	
	void ResetStates();
	
private:
	int number_grenades;
	float barrier_shield_timer;
	int basic_weapon_damage_amount;
	bool S_UNDER_WATER_PREV;
	bool weapons[7];
	
	CR::Graphics::Sprite *steph_top;

	bool steph;	
	
	vector<Weapon*> weapons1;
	Weapon* equippedWeapon;
};