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
    cron \
    && docker-php-ext-install pdo pdo_mysql intl gd pcntl \
    && rm -rf /var/lib/apt/lists/*

# Composer ekle
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Çalışma dizini
WORKDIR /app

# Laravel dosyalarını kopyala
COPY . .

# Laravel scheduler için cron job ekle
RUN echo "* * * * * cd /app && /usr/local/bin/php artisan schedule:run >> /var/log/cron.log 2>&1" > /etc/cron.d/laravel-scheduler \
    && chmod 0644 /etc/cron.d/laravel-scheduler \
    && crontab /etc/cron.d/laravel-scheduler

# Log dizinini oluştur
RUN mkdir -p /var/log && touch /var/log/cron.log

# CMD: cron + Laravel migrate + tail
CMD sh -c "service cron start && composer update && php artisan migrate:fresh --seed && tail -f /dev/null"
