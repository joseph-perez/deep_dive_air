-- destroy the tables first
DROP TABLE IF EXISTS ticket;
DROP TABLE IF EXISTS profile;
DROP TABLE IF EXISTS login;
DROP TABLE IF EXISTS flight;

CREATE TABLE flight
(
    -- NOT null makes the attribute required
    flightNumber SMALLINT(4) UNSIGNED NOT NULL,
    flightDeparture CHAR(3) NOT NULL,
    flightDestination CHAR(3) NOT NULL,
    PRIMARY KEY (flightNumber)
);

CREATE TABLE login
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    email VARCHAR(40) NOT NULL,
    password CHAR(128) NOT NULL,
    salt CHAR(64) NOT NULL,
    PRIMARY KEY(id),
    -- a UNIQUE index enforces the email can't be duplicated
    UNIQUE(email)
);

CREATE TABLE profile
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    dateOfBirth DATE NOT NULL,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    phoneNumber VARCHAR(15) NOT NULL,
    userId INT UNSIGNED NOT NULL,
    -- foreign keys must be indexed first
    INDEX(userId),
    -- then declare the relation
    FOREIGN KEY (userId) REFERENCES login(id) ON UPDATE CASCADE,
    PRIMARY KEY(id)
);

CREATE TABLE ticket
(
    flightNumber SMALLINT(4) UNSIGNED NOT NULL,
    profileId INT UNSIGNED NOT NULL,
    dateTime DATE NOT NULL,
    price DECIMAL(7, 2) NOT NULL,
    seat CHAR(3) NOT NULL,
    ticketNumber VARCHAR(25) NOT NULL,
    PRIMARY KEY(flightNumber, profileId),
    -- create index for foreign keys
    INDEX(flightNumber),
    INDEX(profileId),
    -- create foreign keys
    FOREIGN KEY(flightNumber)  REFERENCES flight(flightNumber),
    FOREIGN KEY(profileId)  REFERENCES profile(id)
);