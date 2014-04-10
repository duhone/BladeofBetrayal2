// HealthObject.cpp: implementation of the HealthObject class.
//
//////////////////////////////////////////////////////////////////////


#include "HealthObject.h"
#include "AssetList.h"
#include "ObjectFactory.h"
#include "ObjectIds.h"

namespace
{
	template<int Type,int Key>
	Object* CreateHealth()	{return new HealthObject<Type,Key>(); }
		
	const bool createdsmall = g_objectFactory::Instance().RegisterCreater(c_smallHealth,CreateHealth<1,0>);
	const bool createdlarge = g_objectFactory::Instance().RegisterCreater(c_largeHealth,CreateHealth<2,0>);
	const bool createdupgradenkey = g_objectFactory::Instance().RegisterCreater(c_healthUpgradeNKey,CreateHealth<3,0>);
	const bool createdupgradebkey = g_objectFactory::Instance().RegisterCreater(c_healthUpgradeBKey,CreateHealth<3,1>);
	const bool createdupgradeokey = g_objectFactory::Instance().RegisterCreater(c_healthUpgradeOKey,CreateHealth<3,2>);
	const bool createdupgradegkey = g_objectFactory::Instance().RegisterCreater(c_healthUpgradeGKey,CreateHealth<3,3>);
	const bool createdupgraderkey = g_objectFactory::Instance().RegisterCreater(c_healthUpgradeRKey,CreateHealth<3,4>);
}

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

template<int Type,int Key>
HealthObject<Type,Key>::HealthObject()
{	
	hasUpgrade = false;
	InitObject();
}

template<int Type,int Key>
HealthObject<Type,Key>::~HealthObject()
{
}

template<int Type,int Key>
void HealthObject<Type,Key>::InitObject()
{
	gotObject = false;
	isCollidable = true;
	
	state = 0;
	draw = true;
	
	// Determine the type of health crate
	if(Type == 1)// small health crate
	{
			health_amount = 5;
			sprite->SetImage(CR::AssetList::Regular_crate);
			sprite2->SetImage(CR::AssetList::Small_Health);
	}
	else if(Type == 2)// large health crate
	{
			health_amount = 20;
			sprite->SetImage(CR::AssetList::Regular_crate);
			sprite2->SetImage(CR::AssetList::Large_Health);
	}
	else if(Type == 3)// health upgrade
	{
			health_amount = 20;
			sprite->SetImage(CR::AssetList::Item_Chest);
			if(hasUpgrade)
				sprite3->SetImage(CR::AssetList::Large_Health);
			else
				sprite3->SetImage(CR::AssetList::Health_Upgrade);
	}
	
	if(Type == 3)
	{
		if(Key < 3)
			sprite->SetFrameSet(Key);
		else
			sprite->SetFrameSet(Key+1);
		sprite->SetAutoAnimate(true);
	}
	else
	{
		sprite->SetAutoAnimate(false);
		sprite->SetFrameSet(0);	
	}
		
	sprite->SetFrame(0);
	sprite->SetFrameRate(2);
	
	if(Type == 3)
	{
		sprite3->SetAutoAnimate(true);
		sprite3->SetFrameSet(0);
		sprite3->SetFrame(0);
		sprite3->SetFrameRate(5);
	}
	else
	{
		sprite2->SetAutoAnimate(true);
		sprite2->SetFrameSet(0);
		sprite2->SetFrame(0);
		sprite2->SetFrameRate(5);
	}
	
	draw2 = false;
	draw3 = false;
}

template<int Type,int Key>
bool HealthObject<Type,Key>::CollideCheck(IPlayer* arg,int& x,int& y,bool& m,bool& ladder,bool& my,HPTRect& temprectt,int& ltype)
{
	//if(!arg->GetStateFlags()->S_IS_PLAYER) return false;
	int tempy;
	switch(state)
	{
		case 0:
		case 1:
			tempy = y;
			if(tempy < 0) tempy++;
			arg->SetWorldLoc(x,tempy);
			if(y != 0) y = -100;
			if(x != 0) x = -100;
			break;
		case 2:
			if(!arg->GetStateFlags()->S_IS_PLAYER) return false;
			if(Type == 3 && !hasUpgrade)
			{
				Projectile *temp = new ProjectileUpgrade("HEALTH UPGRADE +5");
				(*arg->GetProjectileList()).push_back(temp);
				soundPlayer->PlaySound(blip);
				arg->IncNumLifeBars();
				arg->AddSpecialItems();
				SetPointValue(P_HEALTH_UPGRADE);
				hasUpgrade = true;
				arg->AddLife(health_amount);
			}
			else 
			{
				soundPlayer->PlaySound(blip);
				arg->AddLife(health_amount);
				arg->AddBasicItem();
				if(Type == 1) SetPointValue(P_HEALTH_A);
				else SetPointValue(P_HEALTH_B);
			}
			state = 3;
			draw2 = false;
			draw3 = false;
			gotObject = true;
			//return true;
			//return false;
			break;
		}
	
	return false;
}
	
template<int Type,int Key>
void HealthObject<Type,Key>::Update()
{
	switch(state)
	{
	case 0:
		draw = true;
		break;
	case 1:
		if(!sprite->IsAnimating())
		{
			state = 2;
			if(Type == 3) draw3 = true;
		}

		break;
	};
}
	
template<int Type,int Key>
bool HealthObject<Type,Key>::WeaponCollideCheck(IPlayer* arg)
{
	if(!arg->GetStateFlags()->S_IS_PLAYER) return false;
	if(Type == 3 && Key != 0 && arg->GetAttack() != Key)
		return false;
	
	switch(state)
	{
	case 0:
		state = 1;
			soundPlayer->PlaySound(cratebreak);
		//sprite->SetFrameSet(1);
		if(Type == 3)				
			sprite->SetFrameSet(6);
		sprite->SetAutoAnimate(true);
		sprite->AutoStopAnimate();
		sprite->SetFrameRate(10);
			
		SetPointValue(P_DEST_BLOCK_RED);
		if(Type != 3) draw2 = true;
			isCollidable = false;
		break;
	};
	return false;
}
	
template<int Type,int Key>
bool HealthObject<Type,Key>::ProjectileCollideCheck(IPlayer *arg0, Projectile* arg)
{
	if(!arg->GetSource())
	{
		arg->DeActivate();
		return false;
	}
	if(Type == 3 && Key != 0)
		return false;
	switch(state)
	{
	case 0:
		state = 1;
			soundPlayer->PlaySound(cratebreak);
		//sprite->SetFrameSet(1);
		if(Type == 3)				
			sprite->SetFrameSet(6);
		sprite->SetAutoAnimate(true);
		sprite->AutoStopAnimate();
		sprite->SetFrameRate(10);
		ProjectileFlags& proj_flags = arg->GetProjectileFlags();

		SetPointValue(P_DEST_BLOCK_RED);

		if(!proj_flags.S_NON_PROJECTILE) arg->DeActivate();
		if(Type != 3) draw2 = true;
			isCollidable = false;
		//return false;
		break;
	};
//	ProjectileFlags& proj_flags = arg->GetProjectileFlags();

//	if(!proj_flags.S_NON_PROJECTILE) arg->DeActivate();
	return false;
}
	
template<int Type,int Key>
void HealthObject<Type,Key>::SetState(int _value)
{	
	state = _value;
	
	if (state == 1)// crate in process of opening, just open it
		state = 2;
	
	// open the crate, if it was in an open state
	/*if (state == 0 && type != 3)
	{
		sprite->SetFrameSet(0);	
		sprite->SetFrame(0);
		sprite->SetFrameRate(2);
	}
	else */if (state == 1 || state == 2 || state == 3)
	{
		//sprite->SetFrameSet(1);
		if(Type == 3)				
			sprite->SetFrameSet(6);
		sprite->SetAutoAnimate(true);
		sprite->AutoStopAnimate();
		sprite->SetFrameRate(10);
		if(Type != 3) draw2 = true;
	}
	
	switch (state)
	{
		case 0:
			// do nothing
			//draw = true;
			break;
		case 1: // in process of opening
			break;
		case 2: // crate was open w/item floating on it
			if(Type == 3) draw3 = true;
			break;
		case 3: // crate states complete
			draw2 = false;
			draw3 = false;
			gotObject = true;
			break;
	}
}
	
template<int Type,int Key>
int HealthObject<Type,Key>::GetUpgradeType()
{
	if (Type == 3)
		return LEVELSTATETYPE_HEALTH;
	else
		return LEVELSTATETYPE_NOTUPGRADE;
}
	
template<int Type,int Key>
void HealthObject<Type,Key>::SetUpgradeState(bool hasUpgrade)
{
	if (GetUpgradeType() != LEVELSTATETYPE_HEALTH)
		return;
	
	int tState = state;
	this->hasUpgrade = hasUpgrade;
	if (hasUpgrade)
	{
		// Initialize the object if it has not been used (check for resumeGame);
		//if (state < 3)
			InitObject();
		//sprite->SetImage(CR::AssetList::Item_Chest);
	}
	
	SetState(tState);
}