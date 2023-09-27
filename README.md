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

Download and expand package. Add package location to `CMAKE_PREFIX_PATH` in CMakeLists.txt as follows

```
set(
    CMAKE_PREFIX_PATH
        ./openmp-16.0.0-Darwin/
)
```
