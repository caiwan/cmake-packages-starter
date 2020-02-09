include(project_warnings)

enable_testing()

include(GoogleTest)
include("deploy_tests.cmake")

set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

file(GLOB_RECURSE SOURCE_FILES unittests/*.cpp unittests/*.c)
file(GLOB_RECURSE HEADER_FILES unittests/*.hpp unittests/*.h unittests/*.hh)

add_executable(UnitTests EXCLUDE_FROM_ALL ${SOURCE_FILES} ${HEADER_FILES})

target_link_libraries(UnitTests PRIVATE
    MyLibrary
    gmock gtest
    spdlog
    Threads::Threads
    PRIVATE project_warnings
    )
#
set_target_properties(UnitTests PROPERTIES FOLDER tests)

# gtest_add_tests(TARGET UnitTests WORKING_DIRECTORY ${TEST_DEPLOY_DIR} TEST_PREFIX old: TEST_EXECUTOR CTest)
# gtest_discover_tests(UnitTests WORKING_DIRECTORY ${TEST_DEPLOY_DIR} TEST_PREFIX new: TEST_EXECUTOR CTest)

#if (MSVC)
#  set_target_properties(UnitTests PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY "${TEST_DEPLOY_DIR}")
#  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /DGTEST_LINKED_AS_SHARED_LIBRARY=1")
#  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /DGTEST_LINKED_AS_SHARED_LIBRARY=1")
#endif (MSVC)
#
add_test(NAME Tests COMMAND UnitTests WORKING_DIRECTORY ${TEST_DEPLOY_DIR})

add_dependencies(UnitTests DeployTests)

# ----

if (BUILD_BENCHMARKS)

    file(GLOB_RECURSE SOURCE_FILES unittests/*.cpp unittests/*.c)
    file(GLOB_RECURSE HEADER_FILES unittests/*.hpp unittests/*.h unittests/*.hh)

    add_executable(Benchmarks EXCLUDE_FROM_ALL ${SOURCE_FILES} ${HEADER_FILES})

    target_link_libraries(Benchmarks PRIVATE
        MyLibrary
        benchmark
        spdlog
        Threads::Threads
        PRIVATE project_warnings
        )
    #
    set_target_properties(Benchmarks PROPERTIES FOLDER tests)

    add_dependencies(Benchmarks DeployTests)

    #  if (MSVC)
    #    set_target_properties(Benchmarks PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY "${TEST_DEPLOY_DIR}")
    #  endif ()

endif ()
