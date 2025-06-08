cmake_minimum_required(VERSION 3.11)
project(lab080 LANGUAGES CXX)

# Устанавливаем стандарт C++ (если нужно)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Вариант 1: Используем FetchContent для GTest (рекомендуется)
include(FetchContent)
FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/refs/tags/v1.13.0.tar.gz
)
FetchContent_MakeAvailable(googletest)
add_library(print STATIC src/print.cpp)
target_include_directories(print PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)
# Вариант 2: Или используем системный GTest (если установлен)
# find_package(GTest REQUIRED)
# Создаем исполняемый файл
add_executable(demo /home/kali/workspace/projects/lab080/demo/main.cpp)
target_link_libraries(demo PRIVATE print)
# Подключаем зависимости (только если используем GTest)
if(TARGET GTest::GTest)
    target_link_libraries(demo PRIVATE GTest::GTest GTest::Main)
endif()

# Добавляем текущую директорию в пути поиска заголовков
target_include_directories(demo PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
)

# Для CTest (если нужно)
enable_testing()
add_test(NAME demo_test COMMAND demo)
