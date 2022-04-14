
CREATE TABLE University_Ranking_Year (
    university_id     INT             NOT NULL,
    ranking_criteria_id      INT       NOT NULL,
    year             INT         NOT NULL,
    score          INT          NOT NULL,
    FOREIGN KEY (university_id) REFERENCES University(id),
    FOREIGN KEY (ranking_criteria_id) REFERENCES Ranking_Criteria(id)
);

CREATE TABLE University (
    id      INT             NOT NULL,
    country_id        INT       NOT NULL,
    university_name  VARCHAR(50)     NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (country_id) REFERENCES Country(id)
);

CREATE TABLE Ranking_Criteria (
    id      INT             NOT NULL,
    ranking_system_id        INT       NOT NULL,
    criteria_name  VARCHAR(50)     NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (ranking_system_id) REFERENCES Ranking_System(id)
);

CREATE TABLE Country (
    id      INT             NOT NULL,
    country_name  VARCHAR(50)     NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Ranking_System (
    id      INT             NOT NULL,
    system_name  VARCHAR(50)     NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Country (
    id      INT             NOT NULL,
    country_name  VARCHAR(50)     NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE Ranking_System (
    id      INT             NOT NULL,
    system_name  VARCHAR(50)     NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE University (
    id      INT             NOT NULL,
    country_id        INT       NOT NULL,
    university_name  VARCHAR(50)     NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (country_id) REFERENCES Country(id)
);

CREATE TABLE Ranking_Criteria (
    id      INT             NOT NULL,
    ranking_system_id        INT       NOT NULL,
    criteria_name  VARCHAR(50)     NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (ranking_system_id) REFERENCES Ranking_System(id)
);

CREATE TABLE University_Ranking_Year (
    university_id     INT             NOT NULL,
    ranking_criteria_id      INT       NOT NULL,
    year             INT         NOT NULL,
    score          INT          NOT NULL,
    FOREIGN KEY (university_id) REFERENCES University(id),
    FOREIGN KEY (ranking_criteria_id) REFERENCES Ranking_Criteria(id)
);

INSERT INTO Country(id,country_name)
VALUES
(1,'China'),
(2,'Bangladesh'),
(3,'America'),
(4,'South Africa'),
(5,'Portugal'),
(6,'Australia');

INSERT INTO Ranking_System(id,system_name)
VALUES
(1,'In Asia'),
(2,'In Adricaa'),
(3,'In America'),
(4,'In South Asia'),
(5,'In Europe'),
(6,'In Australia');

INSERT INTO University(id,country_id ,university_name)
VALUES
(1, 1, 'Dhaka University'),
(2, 2, 'Warsaw University'),
(3, 3, 'Porto University'),
(4, 4, 'Lisbon University'),
(5, 5, 'Wroclaw University');

INSERT INTO Ranking_Criteria(id,ranking_system_id ,criteria_name)
VALUES
(1, 1, 'Science'),
(2, 2, 'Biology'),
(3, 3, 'Math'),
(4, 4, 'Literacy'),
(5, 5, 'All');


INSERT INTO University_Ranking_Year(university_id, ranking_criteria_id, [year], score)
VALUES
(1,1,'2015','2'),
(2,2, '2016','5'),
(3,3, '2017','15'),
(4,4, '2018','25');
