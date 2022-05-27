
CREATE TABLE Clients(
    ClientID   INT,
    ClientName VARCHAR(50) NOT NULL,
    Address VARCHAR(100), 
    Email VARCHAR(30) UNIQUE,
    Phone INT,
    Business VARCHAR(30) NOT NULL, --Business type of client like Manufacturer, Reseller ...
    PRIMARY KEY (ClientID)
)

CREATE TABLE Projects(
    ProjectID INT,
    Description VARCHAR(100), --Description of project like Accounting, Payroll, ...
    StartDate DATE,  --Start date of project
    PlannedEndDate DATE,  --Planned end date of project
    ActualEndDate DATE ,
    Budget INT CHECK(Budget > 0),
    ClientID INT,
    CHECK(ActualEndDate > PlannedEndDate),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)

)

CREATE TABLE Departments(
    DepartmentNo  INT,
    DepartmentName VARCHAR(100) NOT NULL,
    PRIMARY KEY (DepartmentNo)

)

CREATE TABLE Employees(
    EmployeeNo  INT,
    EmployeeName  VARCHAR(20) NOT NULL,
    Job VARCHAR(20),
    Salary INT CHECK(Salary > 1700),
    DepartmentNo INT,  --DepartmentNo as per departments table
    PRIMARY KEY (EmployeeNo),
    FOREIGN KEY (DepartmentNo) REFERENCES Departments(DepartmentNo)
)

CREATE TABLE EmployeeProjectTasks(
    ProjectID INT,
    EmployeeNo INT,
    StartDate DATE,  --Start date when employee begins task on this project
    EndDate DATE,   --End date when employee finishes task on this project
    Task VARCHAR(30),  --Task performed by employee like designing, coding ..
    Status VARCHAR(30),  -- Status of task like ‘in progress’, ‘complete’,‘cancelled’
    PRIMARY KEY (ProjectID, EmployeeNo),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
    FOREIGN KEY (EmployeeNo) REFERENCES Employees(EmployeeNo)

)

INSERT INTO Clients(ClientID, ClientName, Address, Email, Phone, Business)
VALUES 
(1, 'Nayem', 'Portugal', 'shnartho@yahoo.com', 920485163, 'MoslinMeta'),
(2, 'Belmahi', 'Morrocco', 'belmahi@yahoo.com', 920485162, 'BelmahiMeta');

INSERT INTO Projects(ProjectID, Description, StartDate, PlannedEndDate, ActualEndDate, Budget, ClientID)
VALUES 
(1, 'Accounting', GETDATE(), GETDATE()+1, GETDATE()+2, 2500, 1),
(2, 'Payroll', GETDATE(), 2022-05-05, 2021-06-06, 2502, 2);

INSERT INTO Departments(DepartmentNo, DepartmentName)
VALUES 
(1, 'Main Department'),
(2, 'Secondary Department');

INSERT INTO Employees(EmployeeNo, EmplouyeeName, Job, Salary, DepartmentNo)
VALUES 
(1, 'Nayem Pagla', 'Caretaker', 2500, 1),
(2, 'Maheera', 'Doctor', 4000, 2);

SELECT GETDATE()
INSERT INTO EmployeeProjectTasks
(ProjectID, EmployeeNo, StartDate, EndDate, Task, Status)
VALUES 
(1, 1, '2022-02-02', '2022-03-05', 'Data Entry', 'in progress'),
(2, 2, '2022-02-02', '2022-03-05', 'Sergery', 'Complete');

select * FROM Employees where EmployeeName like 'M%';

select EmployeeNo, EmployeeName
from table Employees 
order by len(EmployeeName) desc;


select Departments.DepartmentName, Employees.EmployeeName, Employees.Salary
from LAB5 
order by Salary desc;

--task 1
CREATE PROCEDURE Employees_GetAll
AS
SELECT EmployeeNo, EmplouyeeName, Job, Salary FROM Employees;


EXEC Employees_GetAll;


-- task 2
CREATE PROCEDURE Employees_Insert
@employeeNo int,
@emplouyeeName VARCHAR(20),
@job VARCHAR(20),
@salary int,
@departmentNo int
AS
BEGIN
INSERT INTO employees(employeeNo,emplouyeeName,job,salary,departmentNo) VALUES(@employeeNo,@emplouyeeName,@job,@salary,@departmentNo)
END;	

EXEC Employees_Insert @employeeNO = 100,@emplouyeeName =  'NayemKhan', @job = 'Engineer', @salary = 5200, @departmentNo = 2;

-- task 3
alter PROCEDURE Clients_Update
@clientName varchar(50),
@clientID int
AS
BEGIN
UPDATE Clients SET clientName = @clientName
WHERE clientID = @clientID
END;

EXEC Clients_Update @clientID = 1 , @clientName ='Nayem Khan';


-- task 4
CREATE PROCEDURE Employees_Delete
@employeeNo int
AS 
BEGIN
DELETE FROM Employees
WHERE employeeNo = @employeeNo
END;

EXEC Employees_Delete @employeeNo = 100;

--task 5
SELECT * FROM Departments;

ALTER TABLE Departments ADD NumberOfEmployees int;
ALTER TABLE Departments DROP COLUMN NumberOfEmployees;

SELECT * FROM Departments;
SELECT * FROM Employees;

UPDATE Departments
SET NumberOfEmployees = 2;
WHERE DepartmentNo = 2;

CREATE TRIGGER trigger1
ON employees
AFTER INSERT
AS
BEGIN
--INSERT INTO Departments(NumberOfEmployees) VALUES (NumberOfEmployees + 1)
--WHERE Employees.DepartmentNo = Depapart
update Departments
set NumberOfEmployees = NumberOfEmployees +1
where DepartmentNo = (
select DepartmentNo from inserted
)

END;

SELECT * FROM Employees;


