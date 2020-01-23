include(get_all_cmake_args)
get_all_cmake_args(CL_ARGS)

include(${CMAKE_CURRENT_SOURCE_DIR}/assimp.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/gtest.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/nlohmann_json.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/spdlog.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/stb.cmake)

add_custom_target(ExternalDependencies)
add_dependencies(ExternalDependencies
  Assimp
  googletest
  nlohmann_json
  spdlog
  stb
  )

set_target_properties(ExternalDependencies PROPERTIES FOLDER ExternalProjectTargets)

#TODO foreach
#set_target_properties(Assimp PROPERTIES FOLDER ExternalProjectTargets)
#set_target_properties(googletest PROPERTIES FOLDER ExternalProjectTargets)
#set_target_properties(nlohmann_json PROPERTIES FOLDER ExternalProjectTargets)
#set_target_properties(spdlog PROPERTIES FOLDER ExternalProjectTargets)
#set_target_properties(stb PROPERTIES FOLDER ExternalProjectTargets)
