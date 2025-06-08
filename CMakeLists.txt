cmake_minimum_required(VERSION 3.11)
project(lab080 LANGUAGES CXX)

# Устанавливаем стандарт C++
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Используем FetchContent для GTest
include(FetchContent)
FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/refs/tags/v1.13.0.tar.gz
)
FetchContent_MakeAvailable(googletest)

# Создаем библиотеку print
add_library(print STATIC src/print.cpp)
target_include_directories(print PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

# Создаем исполняемый файл demo (используем относительные пути)
add_executable(demo demo/main.cpp)
target_link_libraries(demo PRIVATE print)

# Подключаем GTest если используется
if(TARGET GTest::GTest)
    target_link_libraries(demo PRIVATE GTest::GTest GTest::Main)
endif()

# Добавляем пути поиска заголовков
target_include_directories(demo PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

# Для CTest
enable_testing()
add_test(NAME demo_test COMMAND demo)
