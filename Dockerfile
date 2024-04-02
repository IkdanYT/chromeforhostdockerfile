# Используем официальный образ Python как основу
FROM python:3.9-slim

# Устанавливаем необходимые пакеты и WebDriver
RUN apt-get update \
    && apt-get install -y wget gnupg2 unzip \
    && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt-get install -y ./google-chrome-stable_current_amd64.deb \
    && rm ./google-chrome-stable_current_amd64.deb \
    && wget https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip \
    && mv chromedriver /usr/bin/chromedriver \
    && chown root:root /usr/bin/chromedriver \
    && chmod +x /usr/bin/chromedriver \
    && rm chromedriver_linux64.zip \
    && apt-get clean

# Установка библиотеки Selenium
RUN pip install selenium

# Копируем скрипт Python в контейнер
COPY check_server.py /app/check_server.py

# Задаем рабочую директорию
WORKDIR /app

# Команда для запуска скрипта
CMD ["python", "check_server.py"]
