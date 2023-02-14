


# Sets default install prefix when cmakecache is initialized for first time
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/install CACHE PATH "..." FORCE)
endif()


include(FetchContent)

cmake_policy(SET CMP0135 NEW)

FetchContent_Declare(
    OpenMP
    URL
        https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/openmp-14.0.0.src.tar.xz
    URL_HASH
        SHA256=28a1cbdd3dfdd331e4ed2dda2b4477fc418e455c883bd0d1d6acc331118e4688
    OVERRIDE_FIND_PACKAGE
)

set(OPENMP_STANDALONE_BUILD TRUE)
set(LIBOMP_INSTALL_ALIASES OFF)

FetchContent_MakeAvailable(
    OpenMP
)

add_subdirectory(
    ${CMAKE_BINARY_DIR}/_deps/openmp-src/openmp-14.0.0.src
    ${CMAKE_BINARY_DIR}/_deps/openmp-build
)

target_include_directories(
    omp
    INTERFACE
    $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/_deps/openmp-build/runtime/src>
    $<INSTALL_INTERFACE:/usr/local/include>
)


# Define install locations (will be prepended by install prefix)
 include(GNUInstallDirs)

install(
    TARGETS
        omp
    EXPORT
        openmpTargets
    RUNTIME DESTINATION
        ${BINDIR}
    LIBRARY DESTINATION
        ${LIBDIR}
)

install(
    EXPORT
        openmpTargets
    DESTINATION
        "cmake"
    FILE
        openmp-config.cmake
)

set(CPACK_GENERATOR "TGZ")
set(CPACK_PACKAGE_VENDOR "")
set(CPACK_ARCHIVE_FILE_NAME "openmp")

include(CPack)
