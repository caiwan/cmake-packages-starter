#include <benchmark/benchmark.h>
#include <MyLibrary/assimp.h>
#include <MyLibrary/sol2.h>

static void B_Assimp(benchmark::State & state)
{
    for (auto _ : state) {
        AssimpTest test;
        test.DoImport("assets/cube.obj");
    }
}

static void B_Sol2(benchmark::State & state)
{
    for (auto _ : state) {
        HelloSol2 sol2;
        sol2.HelloFromLua();
    }
}

BENCHMARK(B_Assimp);
BENCHMARK(B_Sol2);
