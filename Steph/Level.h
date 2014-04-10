// Level.h: interface for the Level class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_LEVEL_H__2235CB69_418A_477C_BEC7_F612A9AFC387__INCLUDED_)
#define AFX_LEVEL_H__2235CB69_418A_477C_BEC7_F612A9AFC387__INCLUDED_


#include "AILevel.h"
#include "Graphics.h"
#include "HPTPoint.h"
#include "iplayer.h"
#include "object.h"
#include "projectile.h"
#include "GameStateManager.h"
#include "ObjectFactory.h"

using namespace CR::Utility;


class Level : public AILevel  
{
public:
	void UnloadLevel();
	void SetTime(float arg);
	void WeaponCollideCheck(IPlayer* arg);
	void ProjectileCollideCheck(Projectile* arg);
	void Update();
	HPTRect GetWorldBounds();
	void EnableLevel();
	void DisableLevel();
	void SetQuality(int arg);
	void Render();
	void SetLevelPosition(int x,int y);
	int  *GetXRenderOffset() {return &x_render_offset;};
	int  *GetYRenderOffset() {return &y_render_offset;};
//	void SetLevelRenderOffset(int dx, int dy);
	void CollideWithLevel(IPlayer* arg);
	void CollideWithLevelE(IPlayer* arg);
	void LoadLevel(int level_number);
	void ReLoadLevel(int level_number);
	virtual unsigned char GetLevelData(int x,int y);
	Level();
	virtual ~Level();
	virtual bool NextToLadder();
	virtual bool StandingOnGround();
	virtual bool HeadCollission();
	void SetProjectileList(list<Projectile *> *projectile_list);
	void SetPlayer(IPlayer *player);
	list<Object*> GetObjectList() const { return object_list; }
	void LoadObjects(bool _enemiesOnly = false);
	void ResetToSpawnPointData(SpawnPointInfo spawnInfo);
	bool IsCollidable(int xLoc, int yLoc);
private:
	vector<HPTPoint> spointlist;
	vector<HPTPoint> tpointlist;
	int x_render_offset;
	int y_render_offset;
	int level_y_size;
	int level_x_size;
	unsigned char* level_data;
	Object **object_array;
	list<Object*> object_list;
	CR::Graphics::TileBackground *tile_background_back;
	CR::Graphics::TileBackground *tile_background_front;
	HPTRect level_position;
	bool onground;
	bool headcollide;
	bool laddercollide;
	int quality;
	list<Projectile *> *projectile_list;
	IPlayer *player;
protected:
	void LoadLevelData(char *name);
};

#endif // !defined(AFX_LEVEL_H__2235CB69_418A_477C_BEC7_F612A9AFC387__INCLUDED_)
