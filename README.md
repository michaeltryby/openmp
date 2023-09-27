# OpenMP
cmake build targeting MacOS arch universal2 

Useful for building universal libraries with an OpenMP dependency

## Build

```
% cd build
% cmake -G Xcode ..
% cmake --build . --config Release --target package
```

## Usage

Download and expand package. Add the following calls to your CMakeLists.txt

```
set(
    CMAKE_PREFIX_PATH
        ./openmp-16.0.0-Darwin/
)

find_package(
    OpenMP
        COMPONENTS
            CXX REQUIRED
)

target_link_libraries(
  <target name>
    PUBLIC
        OpenMP::OpenMP_CXX
)
```
