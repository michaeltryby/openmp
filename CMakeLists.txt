


cmake_minimum_required (VERSION 3.13)

if("${CMAKE_BINARY_DIR}" STREQUAL "${CMAKE_SOURCE_DIR}")
    message(FATAL_ERROR "In-source builds are disabled.")
endif()


project(
  openmp
    VERSION
        16.0.0
)


set(
    CMAKE_OSX_DEPLOYMENT_TARGET
        11.0
)

set(
    CMAKE_OSX_ARCHITECTURES
        x86_64
)


include(
    extern/openmp.cmake
)

enable_testing()
add_subdirectory(
    tests
)
