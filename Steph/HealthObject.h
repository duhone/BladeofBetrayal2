// HealthObject.h: interface for the HealthObject class.
//
//////////////////////////////////////////////////////////////////////

#pragma once

#include "Object.h"


template<int Type,int Key>
class HealthObject : public Object  
{
public:
	virtual bool WeaponCollideCheck(IPlayer* arg);
	virtual void Update();
	HealthObject();
	virtual ~HealthObject();
	virtual bool CollideCheck(IPlayer* arg,int& x,int& y,bool& m,bool& ladder,bool& my,HPTRect& temprectt,int& ltype);
	virtual bool ProjectileCollideCheck(IPlayer *arg0, Projectile* arg);
	int GetState() const {return state;}
	void SetState(int _value);
	
	int GetUpgradeType();
	void SetUpgradeState(bool hasUpgrade);
	bool GetUpgradeState() { return hasUpgrade; }
	void InitObject();
	
	void Reinitialize(){InitObject();}
private:

	int state;
	int health_amount;
	bool hasUpgrade;
};
