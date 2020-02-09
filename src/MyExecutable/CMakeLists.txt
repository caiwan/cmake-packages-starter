include(AssignSourceGroup)

set(APPLICATION MyExecutable)

file(GLOB_RECURSE SOURCE_FILES *.cpp *.c *.inc)
file(GLOB_RECURSE HEADER_FILES *.h *.hpp *.inl)

add_executable(${APPLICATION} ${SOURCE_FILES} ${HEADER_FILES})
target_link_libraries(${APPLICATION} PRIVATE MyLibrary spdlog
    PRIVATE project_warnings
    )

if (MSVC)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /EHsc /Ob1")
endif (MSVC)

set_target_properties(${APPLICATION} PROPERTIES DEBUG_POSTFIX "d")
assign_source_group(${SOURCE_FILES} ${HEADER_FILES})
install(TARGETS ${APPLICATION} DESTINATION bin)

add_dependencies(${APPLICATION} ExternalDependencies)
