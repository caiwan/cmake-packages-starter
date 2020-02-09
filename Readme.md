# CMake boilerplate project

Boilerplate project for application built with CMake.

## Features 

Uses [CPM.cmake](https://github.com/TheLartians/CPM.cmake)

- Testing with GTest
- Sample for download external dependencies using `ExternalProject_Add` 
- Sample for pure CMake project `Assimp` as external dependency
- Sample for non-CMake single-header library `stb` as external dependency

---
- https://github.com/oracle2025/cppcheck-cmake-example
    - https://github.com/danmar/cppcheck/blob/master/tools/git-pre-commit-cppcheck
    - https://github.com/kbenzie/git-cmake-format
    - https://stackoverflow.com/questions/40325957/how-do-i-add-valgrind-tests-to-my-cmake-test-target
    - syntastic/linters.vim


## Usage 

Configure project
```
mkdir build
cmake ../
```

Execute target `ExternalDependencies` to download and compile all the dependencies 

```
cmake --build ./ --target ExternalDependencies --config Debug
```

And / or compile and install the rest of the project optimized for release with `MinSizeRel`

```
cmake --build ./ --target Install --config MinSizeRel
```

## Testing 

```
TBD
```
