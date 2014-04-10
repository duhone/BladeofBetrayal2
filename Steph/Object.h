#ifndef OBJECT_H
#define OBJECT_H

#include "IPlayer.h"
#include "../Engines/Graphics/Classes/graphics.h"
#include "projectile.h"
#include "projectilepoints.h"
#include "PointValues.h"
#include "LevelStateManager.h"
#include "CRSoundPlayer.h"
#include "AssetList.h"

extern CRSoundPlayer *soundPlayer;

class Object  
{
public:
	void SetHFlip();
	virtual bool ProjectileCollideCheck(IPlayer *arg0, Projectile* arg1);
	virtual bool WeaponCollideCheck(IPlayer* arg);
	virtual void Update() {};
	virtual bool OnGround(int y);
	inline void SetScreenTransform(int x,int y)
	{
		screenx_trans = x+worldx;
		screeny_trans = y+worldy;
//		if((screenx_trans < -16) || (screenx_trans > 256) || (screeny_trans < -16) || (screeny_trans > 336))
		if(((unsigned)(496-screenx_trans) < 512)  && ((unsigned)(336-screeny_trans) < 352u))
		{
			culled = false;
		}
		else culled = true;
	};
	inline void SetWorldPosition(int x,int y)
	{
		worldx = x;
		worldy = y;

	};
	inline int  GetXWorldPosition() {return worldx;};
	inline int  GetYWorldPosition() {return worldy;};

	inline void SetPointValue(int nValue) {nPoints = nValue;};
	inline int  GetPointValue() {return nPoints;};

//	inline void SetRenderOffset(int dx, int dy) {x_render_offset = dx; y_render_offset = dy;};
	void Render();
	void SetPallette(int set,int pal_numb);
	static void SetTime(float time_passed);
	Object();
	virtual ~Object();
	virtual bool CollideCheck(IPlayer* arg,int& x,int& y,bool& m,bool& ladder,bool& my,HPTRect& temprectt,int& ltype) = 0;
	bool IsVisable() {return !culled;};	
	virtual int GetState() const {return -1;}
	virtual void SetState(int _value) { }
	
	virtual int GetUpgradeType() { return LEVELSTATETYPE_NOTUPGRADE; }
	virtual void SetUpgradeState(bool hasUpgrade) { }
	virtual bool GetUpgradeState() { return false; }
	virtual void InitObject(int type) {};
	
	virtual bool IsObject() const { return true; }
	virtual bool GotObject() const { return gotObject; }
	virtual bool IsCollidable() const { return isCollidable; }
	
	virtual void Reinitialize(){};
protected:
	static float time;
	CR::Graphics::Sprite* sprite;
	CR::Graphics::Sprite* sprite2;
	CR::Graphics::Sprite* sprite3;
	int pallete;
	bool draw;
	bool draw2;
	bool draw3;
	int worldy;
	int worldx;
	bool gotObject;
	
	bool isCollidable;
	
private:
	bool hflip_object;
/*	int x_render_offset;
	int y_render_offset;
*/	int nPoints;
	int screeny_trans;
	int screenx_trans;
	bool culled;
};

#endif // !defined(AFX_OBJECT_H__9CFBB1FF_F831_4E17_93FE_FBF61FEFC11B__INCLUDED_)
