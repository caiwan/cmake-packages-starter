#include <gtest/gtest.h>
#include <MyLibrary/hello.h>
#include <MyLibrary/assimp.h>
#include <MyLibrary/stb.h>
#include <MyLibrary/json.h>
#include <MyLibrary/HelloLogger.h>

TEST(SampleTest, HelloWorldTest)
{
  HelloWorld test;
  ASSERT_EQ(5, test.Add(2, 3));
}

TEST(SampleTest, assimp)
{
  AssimpTest test;
  test.DoImport("assets/cube.obj");
  test.DoImport("assets/cube.ply");
}

TEST(SampleTest, json)
{
  JsonTest test;
  test.helloJson("assets/test.json");
}

TEST(SampleTest, stb)
{
  StbTest test;
  test.Stb();
}

TEST(SampleTest, spdlog)
{
  HelloLogger test;
  test.SayHello();
}
