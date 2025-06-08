# Print Library

Простая библиотека для вывода текста в поток.

## Установка и использование

### Подключение через Hunter

Добавьте в ваш `CMakeLists.txt`:

```cmake
hunter_add_package(print)
find_package(print CONFIG REQUIRED)
target_link_libraries(your_target PRIVATE print::print)
