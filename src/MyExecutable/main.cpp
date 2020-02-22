
#include <spdlog/spdlog.h>
#include "../MyLibrary/assimp.h"

int main()
{

    spdlog::info("Hello");

    AssimpTest test;
    test.DoImport("assets/cube.obj");
    test.DoImport("assets/cube.ply");

    return 0;
}
