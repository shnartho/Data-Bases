CREATE DATABASE New;

USE TestDB;

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

CREATE TABLE University_Year (
    university_year_id     INT             NOT NULL,
    university_id       INT             NOT NULL,
    year   INT           NOT NULL,
    num_students      INT            NOT NULL,
    student_staff_ratio       INT             NOT NULL,
    pct_female_students        INT             NOT NULL,
    CONSTRAINT greaterThen CHECK (year > 1700 AND num_students >=0),
    FOREIGN KEY (university_id) REFERENCES University (id) ON DELETE CASCADE,
    PRIMARY KEY (university_year_id)
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

INSERT INTO University_Year(university_year_id,university_id,year,num_students,student_staff_ratio,pct_female_students)
VALUES
(1, 1, 2015, 303, 405, 5, 40),
(2, 2, 2016, 302, 403, 4, 45),
(3, 3, 2017, 305, 406, 6, 48);


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


SELECT 
    id AS University ID, 
    university_name University Name
FROM University;

ALTER TABLE Country
ADD country_address varchar(255),
MODIFY COLUMN country_name varchar(100);

ALTER TABLE University_Ranking_Year
DROP CONSTRAINT greaterThen;

ALTER TABLE University_Ranking_Year
ADD CONSTRAINT greaterThe
CHECK (year >1800 AND score >= 0 AND score <= 10)

DELETE FROM University WHERE id=54;

UPDATE University
SET university_name = '‘Wrocław University of
Science and Technology'
WHERE id=5;
