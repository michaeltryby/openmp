


cmake_minimum_required(
    VERSION
        3.27
)


include(
    FetchContent
)

FetchContent_Declare(
  libomp-darwin
    URL
        https://github.com/michaeltryby/openmp/releases/download/v16.0.0/openmp-16.0.0-Darwin.tar.gz
    URL_HASH
        SHA256=4556d19fab4460e356aff566976d289b4b00b3fca88101113782b0d467f1428d
)

FetchContent_MakeAvailable(
    libomp-darwin
)

set(
    CMAKE_PREFIX_PATH
        ${CMAKE_BINARY_DIR}/_deps/libomp-darwin-src/
)


project(
  test
    LANGUAGES
        CXX
)

set(
    CMAKE_OSX_DEPLOYMENT_TARGET
        11.0
)

set(
    CMAKE_OSX_ARCHITECTURES
        x86_64
        arm64
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
