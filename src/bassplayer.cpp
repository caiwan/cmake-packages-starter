#include "bassplayer.h"

#include <bass.h>

int BassTest::bass()
{
	BASS_Init(-1, 44100, 0, nullptr, nullptr);
	BASS_Free();
	return 0;
}
