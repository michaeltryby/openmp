


add_executable(
    test
    test.cpp
)

target_compile_options(
    test
    PUBLIC
        -Xpreprocessor
        -fopenmp
)

target_link_libraries(
    test
    PUBLIC
        omp
)
