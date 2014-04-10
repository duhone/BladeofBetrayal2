/*
 *  HPTInput_Engine.h
 *  Input
 *
 *  Created by Robert Shoemate on 1/5/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef HPTINPUT_ENGINE_H
#define HPTINPUT_ENGINE_H

class HPTInput_Object
	{
	public:	
		HPTInput_Object(){};
		virtual ~HPTInput_Object(){};
		//virtual bool NewInput(long type,long data) = 0;
		virtual void TouchesBegan(UIView *view, NSSet *touches) = 0;
		virtual void TouchesMoved(UIView *view, NSSet *touches) = 0;
		virtual void TouchesEnded(UIView *view, NSSet *touches) = 0;
		virtual void TouchesCancelled(UIView *view, NSSet *touches) = 0;
	};

class HPTInput_Engine
	{
	public:
		HPTInput_Engine(){};
		virtual ~HPTInput_Engine(){};
		
		virtual bool RegisterInputObject(HPTInput_Object* arg)=0;
		virtual void Release()=0;
		
		virtual void TouchesBegan(UIView *view, NSSet *touches) = 0;
		virtual void TouchesMoved(UIView *view, NSSet *touches) = 0;
		virtual void TouchesEnded(UIView *view, NSSet *touches) = 0;
		virtual void TouchesCancelled(UIView *view, NSSet *touches) = 0;
	};

HPTInput_Engine* HPTGetInputEngine();

#endif