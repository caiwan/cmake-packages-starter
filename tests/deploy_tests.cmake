include(CopyStaticFiles)

set(TEST_DEPLOY_TARGET DeployTests)
set(TEST_DEPLOY_DIR ${CMAKE_BINARY_DIR}/tests/environment)

# This target takes and copies all the asset files into a test environment folder

add_custom_target(${TEST_DEPLOY_TARGET})

recurse_copy_static_files(
    TARGET ${TEST_DEPLOY_TARGET}
    SOURCE ${CMAKE_CURRENT_SOURCE_DIR}/assets
    DESTINATION ${CMAKE_BINARY_DIR}/tests/environment/assets
)

set_target_properties(DeployTests PROPERTIES FOLDER tests)

add_dependencies(DeployTests ExternalDependencies)
