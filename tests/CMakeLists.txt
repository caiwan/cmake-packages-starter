enable_testing()

include(GoogleTest)
include("deploy_tests.cmake")

set(_test UnitTests)

set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

file(GLOB_RECURSE SOURCE_FILES *.cpp *.c)
file(GLOB_RECURSE HEADER_FILES *.hpp *.h *.hh)

add_executable(${_test} EXCLUDE_FROM_ALL ${SOURCE_FILES} ${HEADER_FILES})

target_include_directories(${_test} PUBLIC
  ${SPDLOG_INCLUDE_DIR}
  ${GTEST_INCLUDE_DIR}
)

target_link_directories(${_test} PUBLIC
  ${GTEST_LIB_DIR}
  ${SPDLOG_LIB_DIR}
  )

target_link_libraries(${_test}
  MyLibrary
  #  googletest
  ${GTEST_LIBRARIES}
  #  spdlog
  ${SPDLOG_LIBRARIES}
  Threads::Threads
  )


set_target_properties(${_test} PROPERTIES FOLDER tests)

# gtest_add_tests(TARGET ${_test} WORKING_DIRECTORY ${TEST_DEPLOY_DIR} TEST_PREFIX old: TEST_EXECUTOR CTest)
# gtest_discover_tests(${_test} WORKING_DIRECTORY ${TEST_DEPLOY_DIR} TEST_PREFIX new: TEST_EXECUTOR CTest)

if (MSVC)
  set_target_properties(${_test} PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY "${TEST_DEPLOY_DIR}")
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /DGTEST_LINKED_AS_SHARED_LIBRARY=1")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /DGTEST_LINKED_AS_SHARED_LIBRARY=1")
endif (MSVC)

add_test(NAME Tests COMMAND ${_test} WORKING_DIRECTORY ${TEST_DEPLOY_DIR})

add_dependencies(${_test} DeployTests)
