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
    EmplouyeeName  VARCHAR(20) NOT NULL,
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
(1, 'Accounting', 12/7/2021, 16/7/2021, 18/7/2021, 2500, 1),
(2, 'Payroll', 12/7/2021, 16/7/2021, 18/7/2021, 2502, 2);

INSERT INTO Departments(DepartmentNo, DepartmentName)
VALUES 
(1, 'Main Department'),
(2, 'Secondary Department');

INSERT INTO Employees(EmployeeNo, EmployeeName, Job, Salary, DepartmentNo)
VALUES 
(1, 'Nayem Pagla', 'Caretaker', 2500, 1);
(2, 'Maheera', 'Doctor', 4000, 2);

INSERT INTO EmployeeProjectTasks(ProjectID, EmployeeNo, StartDate, EndDate, Task, Status)
VALUES 
(1, 1, 22/7/2021, 28/7/2021, 'Data Entry', 'in progress'),
(2, 2, 22/7/2021, 29/7/2021, 'Sergery', 'Complete');

select * FROM Employees where EmployeeName like 'M%';

select EmployeeNo, EmployeeName
from table Employees 
order by len(EmployeeName) desc;


select Departments.DepartmentName, Employees.EmployeeName, Employees.Salary
from LAB5 
order by Salary desc;

--task 1
WITH Clients_CTE(ClientName, Description, Status)
AS
(
  SELECT Clients.ClientName, Projects.Description, EmployeeProjectTasks.Status
  FROM Employees
  GROUP BY ClientName
)
SELECT * FROM Clients_CTE;


-- task 2
WITH Departments_CTE(DepartmentNo, DepartmentName)
AS
(
  SELECT Departments.DepartmentNo, DepartmentName
  FROM Employees LEFT JOIN Departments
  ON Employees.DepartmentNo = Departments.DepartmentNo
  GROUP BY Departments.DepartmentNo, DepartmentName
  HAVING Count(EmployeeNo) >= 3
)
SELECT * FROM Departments_CTE;


-- task 3
WITH Avg_salary(DepartmentNo, average)
AS
(
  SELECT DepartmentNo, AVG(Salary) 
  FROM Employees
  GROUP BY DepartmentNo
)

SELECT Avg_salary.DepartmentNo, average, SUM(CASE WHEN salary >= average THEN 1 ELSE 0 END) AS employees_equal_or_above_average
FROM employees LEFT JOIN Avg_salary ON employees.DepartmentNo = Avg_salary.DepartmentNo
GROUP BY Avg_salary.DepartmentNo, average


-- task 4
SELECT * FROM Employees
 
SELECT * FROM Employees WHERE EmployeeName LIKE 'M%';
 
SELECT * FROM Employees
WHERE
len(EmployeeName) = 
(SELECT max(len(EmployeeName)) FROM Employees);
 
SELECT DepartmentName, EmployeeName, Salary FROM Employees
INNER JOIN Departments ON Employees.DepartmentNo=Departments.DepartmentNo
ORDER BY Salary DESC;


--task 5
SELECT d.DepartmentNo,d.DepartmentName,
COUNT(e.EmployeeNo) as number_of_employees
FROM Departments d,Employees e
WHERE d.DepartmentNo = e.DepartmentNo
GROUP BY d.DepartmentNo,d.DepartmentName
