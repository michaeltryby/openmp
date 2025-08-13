#
# openmp.cmake - CMake configuration for OpenMP dependency on MacOS
#
# Created:  Oct 29, 2024
# Modified:
#
# Author: Michael E. Tryby
#         US EPA ORD/CESER
#



# Sets default install prefix when cmakecache is initialized for first time
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(
        CMAKE_INSTALL_PREFIX
            ${CMAKE_BINARY_DIR}/install CACHE PATH "..." FORCE
    )
endif()

# Append local dir to module search path
list(
    APPEND CMAKE_MODULE_PATH
        ${CMAKE_BINARY_DIR}/_deps/llvm_cmake-src/Modules
)


include(FetchContent)

cmake_policy(SET CMP0135 NEW)

# v16.0.0
# FetchContent_Declare(
#   llvm_cmake
#     URL
#         https://github.com/llvm/llvm-project/releases/download/llvmorg-16.0.0/cmake-16.0.0.src.tar.xz
#     URL_HASH
#         SHA256=04e62ab7d0168688d9102680adf8eabe7b04275f333fe20eef8ab5a3a8ea9fcc
# )

# FetchContent_Declare(
#   OpenMP
#     URL
#         https://github.com/llvm/llvm-project/releases/download/llvmorg-16.0.0/openmp-16.0.0.src.tar.xz
#     URL_HASH
#         SHA256=e30f69c6533157ec4399193ac6b158807610815accfbed98695d72074e4bedd0
#     OVERRIDE_FIND_PACKAGE
# )

# v17.0.1 (v17.0.0 was yanked)
FetchContent_Declare(
  llvm_cmake
    URL
        https://github.com/llvm/llvm-project/releases/download/llvmorg-17.0.1/cmake-17.0.1.src.tar.xz
    URL_HASH
        SHA256=46e745d9bdcd2e18719a47b080e65fd476e1f6c4bbaa5947e4dee057458b78bc
)

FetchContent_Declare(
  OpenMP
    URL
        https://github.com/llvm/llvm-project/releases/download/llvmorg-17.0.1/openmp-17.0.1.src.tar.xz
    URL_HASH
        SHA256=d4a25c04d1bc035990a85f172bfe29a38f21ff87448f7fbae165fa780cb95717
    OVERRIDE_FIND_PACKAGE
)

set(
    OPENMP_STANDALONE_BUILD
        TRUE
)
set(
    LIBOMP_INSTALL_ALIASES
        OFF
)

FetchContent_MakeAvailable(
    llvm_cmake
    OpenMP
)


target_compile_options(
  omp
    INTERFACE
        -Xclang
        -fopenmp
)

target_include_directories(
  omp
    INTERFACE
        $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/_deps/openmp-build/runtime/src>
        $<INSTALL_INTERFACE:/include>
)


# Configure install
include(
    GNUInstallDirs
)

install(
    TARGETS
        omp
    EXPORT
        OpenMP_Targets
    RUNTIME
        DESTINATION
            ${CMAKE_INSTALL_BINDIR}
    LIBRARY
        DESTINATION
            ${CMAKE_INSTALL_LIBDIR}
)

# Export from build tree
export(
    EXPORT
        OpenMP_Targets
    NAMESPACE
        OpenMP::
    FILE
        "${CMAKE_CURRENT_BINARY_DIR}/OpenMP_Targets.cmake"
)


add_library(
  OpenMP::OpenMP_CXX
    ALIAS
        omp
)


set(
    CPACK_GENERATOR
        "TGZ"
)
set(
    CPACK_PACKAGE_VENDOR
        ""
)
# Convert system name to lowercase for consistency
string(TOLOWER "${CMAKE_SYSTEM_NAME}" SYSTEM_NAME_LOWER)

# Set package filename with platform and architecture
set(CPACK_ARCHIVE_FILE_NAME "openmp-v${PROJECT_VERSION}-${SYSTEM_NAME_LOWER}-${CMAKE_SYSTEM_PROCESSOR}")


include(CPack)
