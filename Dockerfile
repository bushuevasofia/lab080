# Базовый образ с более новым cmake
FROM ubuntu:20.04

# Установка зависимостей (добавляем tzdata для корректной работы временной зоны)
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Рабочая директория
WORKDIR /app

# Копируем всё в контейнер (используем .dockerignore для исключения ненужных файлов)
COPY . .

# Создаем директорию для сборки и собираем проект
RUN mkdir -p _build && \
    cd _build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make

# Проверяем, что демо собрано
RUN ls -la /app/_build

# Переменная окружения для логов
ENV LOG_PATH=/home/logs/log.txt
VOLUME /home/logs

# Запуск демо-приложения
CMD ["./_build/demo"]
