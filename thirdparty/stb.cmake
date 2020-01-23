include (ExternalProject)

SET(PREFIX stb)
SET(GIT_URL https://github.com/nothings/stb.git)
SET(GIT_TAG "1034f5e5c4809ea0a7f4387e0cd37c5184de3cdd")

SET(STB_INSTALL_DIR ${CMAKE_BINARY_DIR}/externals/ CACHE PATH "" FORCE)
SET(STB_SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/src/stb CACHE PATH "" FORCE)

set(STB_PATCH_CMAKE_LISTS "${CMAKE_CURRENT_SOURCE_DIR}/stb/patch_stb_project.cmake")
set(STB_CMAKE_LISTS "${STB_SOURCE_DIR}/CMakeLists.txt")

IF(WIN32)
  string(REPLACE "/" "\\" STB_PATCH_CMAKE_LISTS "${STB_PATCH_CMAKE_LISTS}")
  string(REPLACE "/" "\\" STB_CMAKE_LISTS "${STB_CMAKE_LISTS}")
ENDIF()

ExternalProject_Add(${PREFIX}
  GIT_REPOSITORY "${GIT_URL}"
  GIT_TAG "${GIT_TAG}"
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}"
  SOURCE_DIR ${STB_SOURCE_DIR}
  UPDATE_COMMAND ""
  PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different "${STB_PATCH_CMAKE_LISTS}" "${STB_CMAKE_LISTS}"
  # CONFIGURE_COMMAND ""
  # BUILD_COMMAND ""
  # INSTALL_COMMAND ""
  CMAKE_ARGS ${CL_ARGS} -DASSIMP_BUILD_TESTS=OFF -DCMAKE_INSTALL_PREFIX=${ASSIMP_INSTALL_DIR}
  TEST_COMMAND ""
)

set(STB_INCLUDE_DIR ${STB_INSTALL_DIR}/include)
