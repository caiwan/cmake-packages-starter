include(assign_source_group)

set(_library MyLibrary)
set(_lib_root ${CMAKE_CURRENT_SOURCE_DIR}/MyLibrary)

file(GLOB_RECURSE SOURCE_FILES
  ${_lib_root}/*.cpp
  ${_lib_root}/*.c
  ${_lib_root}/*.inc
  )

file(GLOB_RECURSE HEADER_FILES
  ${_lib_root}/*.h
  ${_lib_root}/*.hpp
  ${_lib_root}/*.inl
  )

add_library(${_library} STATIC ${SOURCE_FILES} ${HEADER_FILES})
target_link_directories(${_library} PUBLIC ${SPDLOG_LIB_DIR} ${ASSIMP_LIB_DIR})
target_link_libraries(${_library} PUBLIC ${SPDLOG_INCLUDE} ${ASSIMP_LIBRARY})
target_include_directories(${_library} INTERFACE ${CMAKE_CURRENT_SOURCE_DIR} PUBLIC ${STB_INCLUDE_DIR} ${JSON_INCLUDE_DIR})

if (MSVC)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /EHsc /Ob1")
endif (MSVC)

set_target_properties(${_library} PROPERTIES DEBUG_POSTFIX "d")

assign_source_group(${SOURCE_FILES} ${HEADER_FILES})

install(TARGETS ${_library} DESTINATION lib)
install(DIRECTORY ${_lib_root}/ DESTINATION include/${_lib_root} FILES_MATCHING PATTERN "*.h")
install(DIRECTORY ${_lib_root}/ DESTINATION include/${_lib_root} FILES_MATCHING PATTERN "*.hpp")
install(DIRECTORY ${_lib_root}/ DESTINATION include/${_lib_root} FILES_MATCHING PATTERN "*.inl")

add_dependencies(${_library} ExternalDependencies)

add_subdirectory(MyExecutable)
