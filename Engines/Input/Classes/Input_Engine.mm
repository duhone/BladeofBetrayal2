#include "input_engine.h"

Input_Engine *inputengine = NULL;

Input_Engine* GetInputEngine()
{
	if(inputengine == NULL) inputengine = new Input_Engine;
	
	inputengine->AddRef();
	
	return inputengine;
}

Input_Engine::Input_Engine()
{
	input_controller = NULL;
	ref_count = 0;	
}	

bool Input_Engine::RegisterInputController(Input_Controller* arg)
{
	//ResetControls();
	input_controller = arg;
	ResetControls();
	return true;
}

void Input_Engine::TouchesBegan(UIView *view, NSSet *touches)
{
	if (input_controller == NULL) return;
	
	for (int i = 0; i < input_controller->input_objects.size(); i++)
	{
		input_controller->input_objects[i]->TouchesBegan(view, touches);
	}
	
	input_controller->InputChanged();
}

void Input_Engine::TouchesMoved(UIView *view, NSSet *touches)
{
	if (input_controller == NULL) return;
	
	for (int i = 0; i < input_controller->input_objects.size(); i++)
	{
		input_controller->input_objects[i]->TouchesMoved(view, touches);
	}
	
	input_controller->InputChanged();
}

void Input_Engine::TouchesEnded(UIView *view, NSSet *touches)
{
	if (input_controller == NULL) return;
	
	for (int i = 0; i < input_controller->input_objects.size(); i++)
	{
		input_controller->input_objects[i]->TouchesEnded(view, touches);
	}
	
	input_controller->InputChanged();
}

void Input_Engine::TouchesCancelled(UIView *view, NSSet *touches)
{
	if (input_controller == NULL) return;
	
	for (int i = 0; i < input_controller->input_objects.size(); i++)
	{
		input_controller->input_objects[i]->TouchesCancelled(view, touches);
	}
	
	input_controller->InputChanged();
}


//Input_Button* Input_Engine::CreateButton()
//{
//	Input_Button *btn = new Input_Button();
//	input_objects.push_front(btn);
//	return btn;
//}

//Input_Analog* Input_Engine::CreateAnalogStick()
//{
//	Input_Analog *analog = new Input_Analog();
//	input_objects.push_front(analog);
//	return analog;
//}

void Input_Engine::Release()
{
	--ref_count;
	
	if(ref_count == 0)
	{
		// delete all input objects
		//for(list<Input_Object*>::iterator tempi = input_objects.begin();tempi != input_objects.end();)
		//{
		//	delete (*tempi);
		//	tempi = input_objects.erase(tempi);
		//}
		
		delete this;
		inputengine=NULL;
	}
}
			
void Input_Engine::ResetControls()
{
	if (input_controller != NULL)
	{
		for (int i = 0; i < input_controller->input_objects.size(); i++)
		{
			input_controller->input_objects[i]->Reset();
		}
	}
}
