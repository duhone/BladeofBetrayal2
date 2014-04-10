/*
 *  CRMusicPlayer.h
 *  BoB
 *
 *  Created by Robert Shoemate on 2/10/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */
#pragma once
#include <AVFoundation/AVFoundation.h>

#define MUSIC_NONE 0
#define MUSIC_1A 1
#define MUSIC_1B 2
#define MUSIC_2A 3
#define MUSIC_2B 4
#define MUSIC_3A 5
#define MUSIC_3B 6
#define MUSIC_BOSS 7
#define MUSIC_CREDITS 8
#define MUSIC_CUTSCENE 9
#define MUSIC_TITLE 10
class CRMusicPlayer
{
public:
	CRMusicPlayer();
	~CRMusicPlayer();
	
	void ChangeSong(int song);
	void ChangeSong(int song, int loopSong);
	
	//void SetFinalLoopSong(int song);
	//void DisableFinalLoopSong();
	
	void Play();
	void Stop();
	void Mute(bool isMuted);
	void Update();
private:
	AVAudioPlayer* audioPlayer;
	bool isMuted;
	NSTimeInterval currTime;
	NSTimeInterval timePassed;
	bool fadeIn;
	bool fadeOut;
	
	bool useFinalLoopSong;
	int finalLoopSong;
};