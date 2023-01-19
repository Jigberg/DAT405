CREATE TABLE Dept(
    abbreviation CHAR(2) PRIMARY KEY,
    name VARCHAR NOT NULL UNIQUE
);

Create TABLE Program(
    name VARCHAR PRIMARY KEY,
    abbreviation CHAR(2) NOT NULL UNIQUE
);


CREATE TABLE Students(
    idnr CHAR(10) PRIMARY KEY,
    name VARCHAR NOT NULL,
    login VARCHAR UNIQUE NOT NULL, 
    program VARCHAR NOT NULL,
    FOREIGN KEY (program) REFERENCES Program(name),
    UNIQUE (idnr, program)
);

CREATE TABLE Courses(
    code CHAR(6) PRIMARY KEY,
    name VARCHAR NOT NULL,
    credits FLOAT NOT NULL CHECK (credits > 0),
    department VARCHAR NOT NULL,
    FOREIGN KEY (department) REFERENCES Dept(abbreviation)
);
    
CREATE TABLE Branches(
    name VARCHAR NOT NULL,
    program VARCHAR NOT NULL,
    FOREIGN KEY (program) REFERENCES Program(name),
    PRIMARY KEY (name, program)
);

CREATE TABLE BelongsTo(
    student VARCHAR PRIMARY KEY,
    branch VARCHAR NOT NULL,
    program VARCHAR NOT NULL,
    FOREIGN KEY (student) REFERENCES Students(idnr),
    FOREIGN KEY (student, program) REFERENCES Students(idnr, program),
    FOREIGN KEY (branch, program) REFERENCES Branches(name, program)
);

CREATE TABLE LimitedCourses(
    code CHAR(6) PRIMARY KEY,
    capacity INT NOT NULL CHECK (capacity > 0),
    FOREIGN KEY (code) REFERENCES Courses (code)
);

CREATE TABLE Classifications(
    name VARCHAR PRIMARY KEY
);

CREATE TABLE Classified(
    course CHAR(6) NOT NULL,
    classification VARCHAR NOT NULL,
    PRIMARY KEY (course, classification),
    FOREIGN KEY (course) REFERENCES Courses (code),
    FOREIGN KEY (classification) REFERENCES Classifications (name)
);


CREATE TABLE MandatoryProgram(
    course CHAR(6) NOT NULL,
    program VARCHAR NOT NULL,
    PRIMARY KEY (course, program),
    FOREIGN KEY (program) REFERENCES Program(name),
    FOREIGN KEY (course) REFERENCES Courses (code)
);

CREATE TABLE MandatoryBranch(
    course CHAR(6) NOT NULL,
    branch VARCHAR NOT NULL,
    program VARCHAR NOT NULL,
    PRIMARY KEY (course, branch, program),
    FOREIGN KEY (course) REFERENCES courses (code),
    FOREIGN KEY (branch, program) REFERENCES Branches (name, program)    
);

CREATE TABLE RecommendedBranch(
    course CHAR(6) NOT NULL,
    branch VARCHAR  NOT NULL,
    program VARCHAR NOT NULL,
    PRIMARY KEY (course, branch, program),
    FOREIGN KEY (course) REFERENCES courses (code),
    FOREIGN KEY (branch, program) REFERENCES Branches (name, program)
);

CREATE TABLE Registered(
    student CHAR(10) NOT NULL,
    course CHAR(6) NOT NULL,
    PRIMARY KEY (student, course),
    FOREIGN KEY (student) REFERENCES Students(idnr),
    FOREIGN KEY (course) REFERENCES Courses (code)
);

CREATE TYPE GRADE AS ENUM ('U', '3', '4', '5');

CREATE TABLE Taken(
    student CHAR(10) NOT NULL,
    course CHAR(6) NOT NULL,
    grade GRADE NOT NULL,
    PRIMARY KEY (student, course),
    FOREIGN KEY (student) REFERENCES Students(idnr),
    FOREIGN KEY (course) REFERENCES Courses (code)
);

CREATE TABLE WaitingList(
    student CHAR(10) NOT NULL,
    course CHAR(6) NOT NULL,
    position INT NOT NULL CHECK (position >=0),
    CONSTRAINT UC_WaitingList UNIQUE (course,position),
    FOREIGN KEY (student) REFERENCES Students (idnr),
    FOREIGN KEY (course) REFERENCES LimitedCourses (code),
    PRIMARY KEY (student, course)
);