#pragma once

#import <UIKit/UIKit.h>
#include <vector>
#include <list>

using namespace std;
#include "Input_Object.h"
#include "Input_Button.h"
#include "Input_Analog.h"
#include "Input_MissionSelect.h"
#include "Input_WeaponSelect.h"
#include "Input_Toggle.h"

class Input_Controller
	{
	public:
		virtual void InputChanged() = 0;
		vector<Input_Object*> input_objects;
	};

class Input_Engine
	{
	public:
		Input_Engine();
		virtual ~Input_Engine(){};
		
		bool RegisterInputController(Input_Controller* arg);
		
		void Release();
		void AddRef(){ref_count++;};
		
		void TouchesBegan(UIView *view, NSSet *touches);
		void TouchesMoved(UIView *view, NSSet *touches);
		void TouchesEnded(UIView *view, NSSet *touches);
		void TouchesCancelled(UIView *view, NSSet *touches);
		
		// Input Objects
		//list<Input_Object*> input_objects;
		
		//Input_Button *CreateButton();
		//Input_Analog *CreateAnalogStick();
		
		void ResetControls();
		
	private:
		Input_Controller *input_controller;
		long ref_count;
	};

Input_Engine* GetInputEngine();