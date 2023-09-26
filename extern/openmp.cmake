


# Sets default install prefix when cmakecache is initialized for first time
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/install CACHE PATH "..." FORCE)
endif()

# Append local dir to module search path
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/Modules)


include(FetchContent)

cmake_policy(SET CMP0135 NEW)


FetchContent_Declare(
    OpenMP
    URL
        https://github.com/llvm/llvm-project/releases/download/llvmorg-15.0.0/openmp-15.0.0.src.tar.xz
    URL_HASH
        SHA256=7ee0d1c6a0426a34f102aa5c3a2c307807a4885ce347cb51fbc7e5effd6891c6
    OVERRIDE_FIND_PACKAGE
)


set(OPENMP_STANDALONE_BUILD
    TRUE
)
set(LIBOMP_INSTALL_ALIASES
    OFF
)

FetchContent_MakeAvailable(
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
    RUNTIME DESTINATION
        ${BINDIR}
    LIBRARY DESTINATION
        ${LIBDIR}
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


set(CPACK_GENERATOR "TGZ")
set(CPACK_PACKAGE_VENDOR "")
set(CPACK_ARCHIVE_FILE_NAME "openmp")

include(CPack)
