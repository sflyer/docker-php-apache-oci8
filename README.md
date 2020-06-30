# docker-php-apache-oci8
Поместить oracle instant client в папку oracle (в той же папке, что и dockerfile). Скачать можно в https://www.oracle.com/ru/database/technologies/instant-client/downloads.html 

Выполнить в папке с dockerfile для сборки образа:
sudo docker build -t myapp-php-apache .

Запустить контейнер:
sudo docker run -d -p 80:80 --name myapp myapp-php-apache:latest
