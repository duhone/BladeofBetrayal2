/*
 *  CRMusicPlayer.cpp
 *  BoB
 *
 *  Created by Robert Shoemate on 2/10/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "CRMusicPlayer.h"

CRMusicPlayer::CRMusicPlayer()
{
	isMuted = false;
	audioPlayer = nil;
	timePassed = 0;
	currTime = 0;
	fadeIn = false;
	fadeOut = false;
	useFinalLoopSong = false;
	finalLoopSong = MUSIC_CUTSCENE;
	ChangeSong(MUSIC_CREDITS);
}

CRMusicPlayer::~CRMusicPlayer()
{
	if (audioPlayer != nil)
	{
		Stop();
		[audioPlayer release];
	}
}

void CRMusicPlayer::ChangeSong(int song)
{	
	NSString *resourceName;
	timePassed = 0;
	currTime = 0;
	fadeIn = false;
	fadeOut = false;
	useFinalLoopSong = false;
	
	switch (song)
	{
		case MUSIC_1A:
			resourceName = [[NSString alloc] initWithString:@"1A"];
			break;
		case MUSIC_1B:
			resourceName = [[NSString alloc] initWithString:@"1B"];
			break;
		case MUSIC_2A:
			resourceName = [[NSString alloc] initWithString:@"2A"];
			break;
		case MUSIC_2B:
			resourceName = [[NSString alloc] initWithString:@"2B"];
			break;
		case MUSIC_3A:
			resourceName = [[NSString alloc] initWithString:@"3A"];
			break;
		case MUSIC_3B:
			resourceName = [[NSString alloc] initWithString:@"3B"];
			break;
		case MUSIC_CREDITS:
			resourceName = [[NSString alloc] initWithString:@"Credits"];
			break;
		case MUSIC_BOSS:
			resourceName = [[NSString alloc] initWithString:@"Boss"];
			break;
		case MUSIC_CUTSCENE:
			resourceName = [[NSString alloc] initWithString:@"Cutscene"];
			break;
		case MUSIC_TITLE:
			resourceName = [[NSString alloc] initWithString:@"TitleTheme"];
			break;
		default:
			break;
	}
	
	if (audioPlayer != nil)
	{
		Stop();
		[audioPlayer release];
	}
	
	NSString *songPath = [[NSBundle mainBundle] pathForResource:resourceName ofType:@"m4a"];  
	NSData *songData = [NSData dataWithContentsOfFile:songPath];
	
	// allocate the audioPlayer
	audioPlayer = [[AVAudioPlayer alloc] initWithData: songData error:NULL];
	[audioPlayer setNumberOfLoops:-1];
	[audioPlayer prepareToPlay];
	//[audioPlayer setVolume:0];
	[resourceName release];
}

void CRMusicPlayer::ChangeSong(int song, int loopSong)
{
	ChangeSong(song);
	useFinalLoopSong = true;
	finalLoopSong = loopSong;
}

void CRMusicPlayer::Play()
{
	Stop();
	/*fadeIn = true;
	timePassed = 0;
	currTime = 0;*/
	
	if (!isMuted)
		[audioPlayer play];
}

void CRMusicPlayer::Stop()
{
	if ([audioPlayer isPlaying])
		[audioPlayer stop];
}

void CRMusicPlayer::Mute(bool isMuted)
{
	this->isMuted = isMuted;
	
	if (isMuted)
		Stop();
}

void CRMusicPlayer::Update()
{
	if (![audioPlayer isPlaying])
		return;
	
	if (useFinalLoopSong)
	{
		if ([audioPlayer duration] - [audioPlayer currentTime] <= 0)
		{
			ChangeSong(finalLoopSong);
			Play();
		}
		
		return;
	}
	
	if (fadeIn || fadeOut)
	{
		timePassed += [audioPlayer currentTime] - currTime;
		currTime = [audioPlayer currentTime];
	}
	
	if ([audioPlayer duration] - [audioPlayer currentTime] <= 8 && fadeOut != true)
		fadeOut = true;
	
	if (fadeIn && [audioPlayer volume] < 1 && timePassed > .3)
	{
		[audioPlayer setVolume:[audioPlayer volume]+.05];
		timePassed = 0;
		
		if ([audioPlayer volume] >= 1)
		{
			[audioPlayer setVolume:1];
			fadeIn = false;
		}
	}
	else if (fadeOut && [audioPlayer volume] > 0 && timePassed > .3)
	{
		[audioPlayer setVolume:[audioPlayer volume]-.05];
		timePassed = 0;
		
		if ([audioPlayer volume] <= 0)
		{
			[audioPlayer setVolume:0];
			fadeOut = false;
			fadeIn = true;
			[audioPlayer setCurrentTime:0];
			currTime = 0;
		}
	}
}