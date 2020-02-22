# Third party packages

include(project_warnings)



# https://github.com/TheLartians/CPM.cmake
include(CPM)

# --------------------------------------------------------------------------------
# --- Assimp

# TODO Turn off warnings

CPMAddPackage(
  NAME Assimp
  GITHUB_REPOSITORY assimp/assimp
  GIT_TAG v4.1.0
  VERSION 4.1.0
  OPTIONS
  "ASSIMP_BUILD_TESTS OFF"
  "ASSIMP_BUILD_ASSIMP_TOOLS OFF"
)

if (Assimp_ADDED)
    # Patch assimp
    # TODO: Add binary paths to a variable
    # set(ASSIMP_BINARIES ... )
    set(ASSIMP_INCLUDE_DIRS ${Assimp_SOURCE_DIR}/include ${Assimp_BINARY_DIR}/include)
    if (WIN32 AND MSVC)

        if(MSVC_VERSION GREATER_EQUAL 1800 )
            set(ASSIMP_MSVC_VERSION "vc120")
        elseif(MSVC_VERSION GREATER_EQUAL 1900)
            set(ASSIMP_MSVC_VERSION "vc140")
        endif() # TODO: Add version 1910 and 1920 https://cmake.org/cmake/help/latest/variable/MSVC_VERSION.html#variable:MSVC_VERSION

        # set(ASSIMP_LIBRARIES ${CMAKE_BINARY_DIR}/lib/$<CONFIGURATION>/$<TARGET_LINKER_FILE_NAME:assimp>)
        # set(ASSIMP_BINARIES ${CMAKE_BINARY_DIR}/lib/$<CONFIGURATION>/$<TARGET_LINKER_FILE_NAME:assimp>)
        set(ASSIMP_BINARIES $<TARGET_FILE:assimp>)
        set(ASSIMP_LIBRARIES $<TARGET_LINKER_FILE:assimp>)
    else()
        message(FATAL_ERROR "Cannot add Assimp")
    endif()
    message("Assimp_BINARY_DIR = ${Assimp_BINARY_DIR}")
else ()
  message(FATAL_ERROR "Assimp could not be added")
endif ()



# --------------------------------------------------------------------------------
# --- Bulet

CPMAddPackage(
  NAME Bullet
  GITHUB_REPOSITORY bulletphysics/bullet3
  GIT_TAG 2.89
  VERSION 2.89
  OPTIONS
  "BUILD_CPU_DEMOS OFF"
  "BUILD_BULLET2_DEMOS OFF"
  "BUILD_UNIT_TESTS OFF"
  "BUILD_EXTRAS OFF"
  "BUILD_OPENGL3_DEMOS OFF"
)

if (NOT Bullet_ADDED)
  message(FATAL_ERROR "Bullet could not be added")
endif ()

# --------------------------------------------------------------------------------
# --- lua + sol2

CPMAddPackage(
  NAME lua
  GITHUB_REPOSITORY lua/lua
  GIT_TAG v5.3.5
  VERSION 5.3.5
  DOWNLOAD_ONLY YES
)

if (lua_ADDED)
  # lua has no CMakeLists, so we create our own target

  FILE(GLOB lua_sources ${lua_SOURCE_DIR}/*.c)
  add_library(lua STATIC ${lua_sources})

  target_include_directories(lua
    PUBLIC
    $<BUILD_INTERFACE:${lua_SOURCE_DIR}>
    )
else ()
  message(FATAL_ERROR "lua could not be added")
endif ()


CPMAddPackage(
  NAME sol2
  URL https://github.com/ThePhD/sol2/archive/v3.0.2.zip
  VERSION 3.0.2
  DOWNLOAD_ONLY YES
)

if (sol2_ADDED)
  add_library(sol2 INTERFACE IMPORTED)
  target_include_directories(sol2 INTERFACE ${sol2_SOURCE_DIR}/include)
  target_link_libraries(sol2 INTERFACE lua)
else ()
  message(FATAL_ERROR "sol2 could not be added")
endif ()

# --------------------------------------------------------------------------------
# --- spdlog

CPMAddPackage(
  NAME spdlog
  GITHUB_REPOSITORY gabime/spdlog
  GIT_TAG v1.4.2
  VERSION 1.4.2
)

if (NOT spdlog_ADDED)
  message(FATAL_ERROR "spdlog could not be added")
endif ()

# --------------------------------------------------------------------------------
# --- cxxopts

CPMAddPackage(
  NAME cxxopts
  GITHUB_REPOSITORY jarro2783/cxxopts
  VERSION 2.2.0
  OPTIONS
  "CXXOPTS_BUILD_EXAMPLES OFF"
  "CXXOPTS_BUILD_TESTS OFF"
)

if (NOT cxxopts_ADDED)
  message(FATAL_ERROR "cxxopts could not be added")
endif ()

# --------------------------------------------------------------------------------
# --- nlohmann / json

CPMAddPackage(
  NAME nlohmann_json
  VERSION 3.6.1
  # not using the repo as it takes forever to clone
  URL https://github.com/nlohmann/json/releases/download/v3.6.1/include.zip
  URL_HASH SHA256=69cc88207ce91347ea530b227ff0776db82dcb8de6704e1a3d74f4841bc651cf
)

if (nlohmann_json_ADDED)
  add_library(nlohmann_json INTERFACE)
  target_include_directories(nlohmann_json INTERFACE ${nlohmann_json_SOURCE_DIR})
else ()
  message(FATAL_ERROR "nlohmann_json could not be added")
endif ()

# --------------------------------------------------------------------------------
# --- googletest

if (BUILD_TESTS)

  CPMAddPackage(
    NAME googletest
    GITHUB_REPOSITORY google/googletest
    GIT_TAG release-1.8.1
    VERSION 1.8.1
    OPTIONS
    "INSTALL_GTEST OFF"
    "gtest_force_shared_crt ON"
  )

  if (googletest_ADDED)
    set(GTEST_BINARIES $<TARGET_FILE:gtest> $<TARGET_FILE:gmock>)
  else()
    message(FATAL_ERROR "googletest could not be added")
  endif ()

endif ()

# --------------------------------------------------------------------------------
# --- benchmark

if (BUILD_TESTS AND BUILD_BENCHMARKS)
  CPMAddPackage(
    NAME benchmark
    GITHUB_REPOSITORY google/benchmark
    VERSION 1.5.0
    OPTIONS
    "BENCHMARK_ENABLE_TESTING Off"
  )

  if (benchmark_ADDED)
    # patch google benchmark target
    set_target_properties(benchmark PROPERTIES CXX_STANDARD 17)
    set(BENCHMARK_BINARIES $<TARGET_FILE:benchmark>)
  else()
    message(FATAL_ERROR "googletest could not be added")
  endif ()

endif ()

# --------------------------------------------------------------------------------
# --- stb

CPMAddPackage(
  NAME stb
  GIT_TAG f67165c2bb2af3060ecae7d20d6f731173485ad0
  GITHUB_REPOSITORY nothings/stb
  DOWNLOAD_ONLY YES
)

if (stb_ADDED)
  # Headers only, Excl. vorbis
  # No test build, no need for external data, etc.
  add_library(stb INTERFACE)
  target_include_directories(stb INTERFACE ${stb_SOURCE_DIR})

else ()
  message(FATAL_ERROR "stb could not be added")
endif ()

# --------------------------------------------------------------------------------
# --- Bass

if (WIN32)
  CPMAddPackage(
    NAME bass
    VERSION 3.6.1
    # not using the repo as it takes forever to clone
    URL http://www.un4seen.com/files/bass24.zip
    # TODO Fix hash
    # URL_HASH SHA256=69cc88207ce91347ea530b227ff0776db82dcb8de6704e1a3d74f4841bc651cf
    DOWNLOAD_ONLY YES
  )

  if (bass_ADDED)
    if (CMAKE_SIZEOF_VOID_P EQUAL 8)
      set(BASS_ARCHITECTURE "x64")
    elseif (CMAKE_SIZEOF_VOID_P EQUAL 4)
      set(BASS_ARCHITECTURE "")
    endif (CMAKE_SIZEOF_VOID_P EQUAL 8)

    add_library(bass INTERFACE)
    target_include_directories(bass INTERFACE ${bass_SOURCE_DIR}/c/${BASS_ARCHITECTURE})
    target_link_directories(bass INTERFACE ${bass_SOURCE_DIR}/c/${BASS_ARCHITECTURE})

    set(BASS_BINARIES "${bass_SOURCE_DIR}/${BASS_ARCHITECTURE}/bass.dll")

  else ()
    message(FATAL_ERROR "bass could not be added")
  endif ()

endif ()

# --------------------------------------------------------------------------------
# --- External dependency assembly

add_custom_target(ExternalDependencies)
add_dependencies(ExternalDependencies
  assimp
  cxxopts
  sol2
  # TODO Add Bullet
  nlohmann_json
  spdlog
  stb
  )

if (WIN32)
  add_dependencies(ExternalDependencies
    bass
    )
endif ()

if (BUILD_TESTS)
  add_dependencies(ExternalDependencies
    gtest gmock
    )

  if (BUILD_BENCHMARKS)
    add_dependencies(ExternalDependencies
      benchmark
      )
  endif ()

endif ()

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# TODO Hide targets

set (_external_targets
    assimp IrrXML zlib zlibstatic UpdateAssimpLibsDebugSymbolsAndDLLs
    spdlog
    lua
    gtest gtest_main gmock gmock_main
    benchmark benchmark_main
    Bullet2FileLoader Bullet3Collision Bullet3Common Bullet3Dynamics
    Bullet3Geometry Bullet3OpenCL_clew BulletCollision BulletDynamics BulletInverseDynamics
    BulletSoftBody LinearMath
)

foreach(_var IN ITEMS ${_external_targets})
    set_target_properties(${_var} PROPERTIES FOLDER ExternalProjectTargets)
endforeach()


set_target_properties(ExternalDependencies PROPERTIES FOLDER ExternalProjectTargets)


