include(project_warnings)

include(AssignSourceGroup)

file(GLOB_RECURSE SOURCE_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/MyLibrary/*.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MyLibrary/*.c
    ${CMAKE_CURRENT_SOURCE_DIR}/MyLibrary/*.inc
    )

file(GLOB_RECURSE HEADER_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/MyLibrary/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/MyLibrary/*.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MyLibrary/*.inl
    )

add_library(MyLibrary STATIC ${SOURCE_FILES} ${HEADER_FILES})

target_link_libraries(MyLibrary
    PUBLIC nlohmann_json
    PRIVATE cxxopts sol2 spdlog stb assimp bass
    PRIVATE project_warnings
    )

# target_include_directories(MyLibrary INTERFACE ${CMAKE_CURRENT_SOURCE_DIR} PRIVATE ${ASSIMP_INCLUDE_DIRS})
target_include_directories(MyLibrary INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})

if (MSVC)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /EHsc /Ob1")
endif (MSVC)

set_target_properties(MyLibrary PROPERTIES DEBUG_POSTFIX "d")

assign_source_group(${SOURCE_FILES} ${HEADER_FILES})

install(TARGETS MyLibrary DESTINATION lib)
install(DIRECTORY ${_lib_root}/ DESTINATION include/${_lib_root} FILES_MATCHING PATTERN "*.h")
install(DIRECTORY ${_lib_root}/ DESTINATION include/${_lib_root} FILES_MATCHING PATTERN "*.hpp")
install(DIRECTORY ${_lib_root}/ DESTINATION include/${_lib_root} FILES_MATCHING PATTERN "*.inl")

add_dependencies(MyLibrary ExternalDependencies)

add_subdirectory(MyExecutable)
