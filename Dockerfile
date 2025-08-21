# FrankenPHP resmi imajını kullanıyoruz
FROM dunglas/frankenphp:latest

# Sistem bağımlılıkları
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    curl \
    libpq-dev \
    libxml2-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libfreetype6-dev \
    g++ \
    libicu-dev \
    && docker-php-ext-install pdo pdo_mysql intl gd pcntl \
    && rm -rf /var/lib/apt/lists/*

# Composer ekle
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Çalışma dizini
WORKDIR /app

# Laravel dosyalarını kopyala
COPY . .

CMD sh -c "composer update && tail -f /dev/null"



