


cmake_minimum_required (VERSION 3.24)

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

if (APPLE)
    include(
        extern/openmp.cmake
    )
endif()

find_package(
    OpenMP
        COMPONENTS
            CXX REQUIRED
)

enable_testing()
add_subdirectory(
    tests
)
