#include "HelloLogger.h"
#include <spdlog/spdlog.h>
void HelloLogger::SayHello()
{
    spdlog::info("Hello world");
    spdlog::debug("Hello world");
    spdlog::trace("Hello world");
    spdlog::warn("Hello world");
    spdlog::error("Hello world");
    spdlog::critical("Hello world");
}
