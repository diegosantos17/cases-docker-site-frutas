CREATE DATABASE IF NOT EXISTS db_site_frutas;
USE db_site_frutas;

CREATE TABLE IF NOT EXISTS products (
    id INT(11) AUTO_INCREMENT,
    name VARCHAR(255),
    price DECIMAL(10, 2),
    PRIMARY KEY(id)
);

INSERT INTO products VALUE(0, 'Maça', 5);
INSERT INTO products VALUE(0, 'Pera', 7);