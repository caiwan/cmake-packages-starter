#include "stdafx.h"
#include <gtest/gtest.h>

using ::testing::EmptyTestEventListener;
using ::testing::InitGoogleTest;
using ::testing::Test;
using ::testing::TestCase;
using ::testing::TestEventListeners;
using ::testing::TestInfo;
using ::testing::TestPartResult;
using ::testing::UnitTest;

int main(int argc, char **argv) {
	InitGoogleTest(&argc, argv);
	int res = RUN_ALL_TESTS();
	return res;
}
