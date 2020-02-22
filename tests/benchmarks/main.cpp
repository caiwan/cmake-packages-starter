#include <benchmark/benchmark.h>

#include <spdlog/spdlog.h>
#include <spdlog/sinks/stdout_color_sinks.h>

int main(int argc, char ** argv)
{
    spdlog::set_pattern("[%E%e%f] [%t] %v");
    spdlog::set_level(spdlog::level::trace);
    benchmark::Initialize(&argc, argv);

    if (benchmark::ReportUnrecognizedArguments(argc, argv)) return 1;
    benchmark::RunSpecifiedBenchmarks();
}
