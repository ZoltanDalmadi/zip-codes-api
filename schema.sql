PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: countries
CREATE TABLE countries (
    id   INTEGER       PRIMARY KEY
                       NOT NULL
                       UNIQUE,
    name VARCHAR (255) UNIQUE
);

-- Table: cities
CREATE TABLE cities (
    id         INTEGER       PRIMARY KEY
                             NOT NULL
                             UNIQUE,
    name       VARCHAR (255) NOT NULL,
    country_id INTEGER       REFERENCES countries (id) 
);

-- Table: zips
CREATE TABLE zips (
    id      INTEGER       PRIMARY KEY
                          NOT NULL
                          UNIQUE,
    name    VARCHAR (255) NOT NULL,
    city_id INTEGER       REFERENCES cities (id) 
);

-- Insert data into countries
INSERT INTO countries (name) VALUES ('HU');
INSERT INTO countries (name) VALUES ('RO');

-- Insert data into cities
INSERT INTO cities (name, country_id) VALUES ('Miskolc', 1);
INSERT INTO cities (name, country_id) VALUES ('Debrecen', 1);
INSERT INTO cities (name, country_id) VALUES ('Brașov', 2);
INSERT INTO cities (name, country_id) VALUES ('Cluj-Napoca', 2);

-- Insert data into zips
INSERT INTO zips (name, city_id) VALUES ('3511', 1);
INSERT INTO zips (name, city_id) VALUES ('3525', 1);
INSERT INTO zips (name, city_id) VALUES ('3528', 1);
INSERT INTO zips (name, city_id) VALUES ('4024', 2);
INSERT INTO zips (name, city_id) VALUES ('4031', 2);
INSERT INTO zips (name, city_id) VALUES ('4030', 2);
INSERT INTO zips (name, city_id) VALUES ('500660', 3);
INSERT INTO zips (name, city_id) VALUES ('500670', 3);
INSERT INTO zips (name, city_id) VALUES ('400920', 4);
INSERT INTO zips (name, city_id) VALUES ('400925', 4);

COMMIT TRANSACTION;

PRAGMA foreign_keys = on;
