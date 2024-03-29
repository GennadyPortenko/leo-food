-- ROP SCHEMA IF EXISTS public CASCADE;
-- CREATE SCHEMA public;

DROP TABLE IF EXISTS client CASCADE;
CREATE TABLE client (
  client_id BIGSERIAL PRIMARY KEY
, phone VARCHAR(50) NOT NULL
, email VARCHAR(150)
, active INTEGER NOT NULL
);

DROP TABLE IF EXISTS partner CASCADE;
CREATE TABLE partner (
  partner_id BIGSERIAL PRIMARY KEY
, name VARCHAR(50) NOT NULL
, email VARCHAR(150) NOT NULL
, image VARCHAR(150)
, logo VARCHAR(150)
, main_category_fk INTEGER REFERENCES category(category_id) NOT NULL -- ON UPDATE CASCADE ON DELETE CASCADE
, password VARCHAR(200) NOT NULL
, active INTEGER NOT NULL
, min_time INTEGER NOT NULL
, max_time INTEGER NOT NULL
, min_price INTEGER NOT NULL
);

DROP TABLE IF EXISTS partner_category CASCADE;
CREATE TABLE partner_category (
  partner_id INTEGER REFERENCES partner(partner_id) NOT NULL
, category_id INTEGER REFERENCES category(category_id) NOT NULL
, CONSTRAINT partner_category_pkey PRIMARY KEY (partner_id, category_id)
);

DROP TABLE IF EXISTS role CASCADE;
CREATE TABLE role (
  role_id SERIAL PRIMARY KEY
, role VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS city CASCADE;
CREATE TABLE city (
  city_id SERIAL PRIMARY KEY
, name_en VARCHAR(50) NOT NULL
, name_fr VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS district CASCADE;
CREATE TABLE district (
  district_id SERIAL PRIMARY KEY
, name_en VARCHAR(50) NOT NULL
, name_fr VARCHAR(50) NOT NULL
, city_fk INTEGER REFERENCES city(city_id) NOT NULL -- ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS client_role CASCADE;
CREATE TABLE client_role (
  client_id INTEGER REFERENCES client(client_id) NOT NULL
, role_id INTEGER REFERENCES role(role_id) NOT NULL
, CONSTRAINT client_role_pkey PRIMARY KEY (client_id, role_id)
);

DROP TABLE IF EXISTS partner_role CASCADE;
CREATE TABLE partner_role (
  partner_id INTEGER REFERENCES partner(partner_id) NOT NULL
, role_id INTEGER REFERENCES role(role_id) NOT NULL
, CONSTRAINT partner_role_pkey PRIMARY KEY (partner_id, role_id)
);

DROP TABLE IF EXISTS section CASCADE;
CREATE TABLE section (
  section_id BIGSERIAL PRIMARY KEY
, name VARCHAR(50) NOT NULL
, description TEXT
, partner_fk INTEGER REFERENCES partner(partner_id) NOT NULL -- ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS product CASCADE;
CREATE TABLE product (
  product_id BIGSERIAL PRIMARY KEY
, name VARCHAR(50) NOT NULL
, description TEXT NOT NULL
, image VARCHAR(150)
, section_fk INTEGER REFERENCES section(section_id) NOT NULL -- ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS category CASCADE;
CREATE TABLE category (
  category_id SERIAL PRIMARY KEY
, name_en VARCHAR(50) NOT NULL
, name_fr VARCHAR(50) NOT NULL
);


-- roles initialization

INSERT INTO role (role_id, role)
VALUES (1, 'ROLE_ADMIN'), (2, 'ROLE_USER'), (3, 'ROLE_PARTNER');


-- categories initialization

INSERT INTO category (category_id, name_en, name_fr)
VALUES (1, 'Pizza', 'Pizza'), (2, 'Sushi', 'Sushi'),
       (3, 'Burgers', 'Des Hamburgers'), (4, 'Meat', 'Moi à'),
       (5, 'Pies', 'Tartes'), (6, 'Fast Food', 'Fast Food'),
       (7, 'Asian', 'Asiatique'), (8, 'European', 'Européenne');

-- cities / districts initialization

INSERT INTO city (city_id, name_en, name_fr)
VALUES (1, 'Douala', 'Douala'), (2, 'Yaounde', 'Yaoundé');

INSERT INTO district (district_id, name_en, name_fr, city_fk)
VALUES (1, 'Akwa', 'Akwa', 1), (2, 'Bassa', 'Bassa', 1),
       (3, 'Etoudi', 'Etoudi', 2), (4, 'Bastos', 'Bastos', 2);

