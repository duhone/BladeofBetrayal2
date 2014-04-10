#include "HPTSoundEngineInternal.h"

HPTSoundEngineInternal *m_hptSndEngine = 0;

HPTSoundEngine *GetHPTSoundEngine()
{
	if(m_hptSndEngine == 0)
	{
		m_hptSndEngine = new HPTSoundEngineInternal();
	}

	m_hptSndEngine->AddRef();

	return m_hptSndEngine;	
}
