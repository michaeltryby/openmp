


cmake_minimum_required(
    VERSION
        3.27
)

project(
  test
    LANGUAGES
        CXX
)

set(
    CMAKE_PREFIX_PATH
        ./openmp-16.0.0-Darwin/
)


set(CMAKE_FIND_DEBUG_MODE FALSE)
find_package(
    OpenMP
        COMPONENTS
            CXX REQUIRED
)
set(CMAKE_FIND_DEBUG_MODE FALSE)


add_executable(
  test
    test.cpp
)

target_link_libraries(
  test
    PUBLIC
        OpenMP::OpenMP_CXX
)
