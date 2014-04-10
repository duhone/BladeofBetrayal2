// ProjectilePoints.h: interface for the ProjectilePoints class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_PROJECTILEPOINTS_H__990AFAE4_31A9_44CF_9819_F83C0CC981D3__INCLUDED_)
#define AFX_PROJECTILEPOINTS_H__990AFAE4_31A9_44CF_9819_F83C0CC981D3__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "Projectile.h"
#include <stdio.h>
#include <stdlib.h>

extern CR::Graphics::Font *fnt_green;
extern CR::Graphics::Font *fnt_red;
extern CR::Graphics::Font *fnt_yellow;
extern CR::Graphics::Font *fnt_blue;

class ProjectilePoints : public Projectile  
{
public:
	static void SetModifier(float arg);
	ProjectilePoints(int xPos, int yPos, int nPoints, int fnt = 0, bool type = true);
	virtual ~ProjectilePoints();

	virtual void Update();
	virtual void Render();

private:
	int nPoints;
	bool bType;
	CR::Graphics::Font *fnt;

	//Effects
	bool S_FLICKER;
	static float modifier;
};

#endif // !defined(AFX_PROJECTILEPOINTS_H__990AFAE4_31A9_44CF_9819_F83C0CC981D3__INCLUDED_)
