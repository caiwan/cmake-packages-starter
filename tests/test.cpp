#include <gtest/gtest.h>
#include "hello.h"
#include "assimp.h"
#include "bassplayer.h"
#include "bullet.h"
#include "stb.h"
#include "json.h"

TEST(Test, hello) {
	HelloWorld test;
	ASSERT_EQ(5, test.add(2, 3));
}

TEST(Test, assimp) {
	AssimpTest test;
	test.doImport();
}

TEST(Test, json) {
	JsonTest test;
	test.helloJson();
}

TEST(Test, stb) {
	StbTest test;
	test.stb();
}

TEST(Test, bass) {
	BassTest test;
	test.bass();
}
