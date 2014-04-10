/*
 *  ObjectFactory.h
 *  Steph
 *
 *  Created by Eric Duhon on 4/15/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */
#pragma once

#include "ClassFactory.h"
#include "Object.h"

typedef CR::Utility::Singleton<CR::Utility::ClassFactory<Object,int> > g_objectFactory;
