


# cmake_minimum_required(
#     VERSION
#         3.27
# )


# include(
#     FetchContent
# )

# FetchContent_Declare(
#   libomp-darwin
#     URL
#         https://github.com/michaeltryby/openmp/releases/download/v16.0.0/openmp-16.0.0-Darwin.tar.gz
#     URL_HASH
#         SHA256=24d9095bfded801a85e45967eaddee9b341f2e1732cec195ffbfc2b9969074e1
# )

# FetchContent_MakeAvailable(
#     libomp-darwin
# )

# set(
#     CMAKE_PREFIX_PATH
#         ${CMAKE_BINARY_DIR}/_deps/libomp-darwin-src/
# )


project(
  test_omp
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
)


set(CMAKE_FIND_DEBUG_MODE FALSE)
find_package(
    OpenMP
        COMPONENTS
            CXX REQUIRED
)
set(CMAKE_FIND_DEBUG_MODE FALSE)


add_executable(
  test_omp
    test_omp.cpp
)

target_link_libraries(
  test_omp
    PUBLIC
        OpenMP::OpenMP_CXX
)


# Add the test
add_test(
    NAME
        test_omp
    COMMAND
        test_omp
)

# Ensure output is shown on failure
set(
    CMAKE_CTEST_ARGUMENTS
        "--output-on-failure"
)
