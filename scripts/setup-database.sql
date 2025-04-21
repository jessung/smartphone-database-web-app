DROP DATABASE IF EXISTS smartphones;
CREATE DATABASE smartphones;

DROP USER IF EXISTS 'jes';
CREATE USER 'jes' IDENTIFIED WITH mysql_native_password BY 'password';

GRANT ALL ON smartphones.* TO 'jes';