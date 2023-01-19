CREATE OR REPLACE VIEW BasicInformation AS (
    SELECT Students.idnr, Students.name, Students.login, Students.program, BelongsTo.branch AS branch
    FROM Students
    LEFT JOIN BelongsTo ON Students.idnr = BelongsTo.student
);

CREATE OR REPLACE VIEW FinishedCourses AS (
    SELECT Taken.student, Taken.course, Taken.grade, Courses.credits 
    FROM Taken
    LEFT JOIN Courses ON Taken.course = Courses.code
);

CREATE OR REPLACE VIEW PassedCourses AS (
    SELECT FinishedCourses.student, FinishedCourses.course, FinishedCourses.credits
    FROM FinishedCourses
    WHERE (FinishedCourses.grade != 'U')
);

CREATE OR REPLACE VIEW Registrations(student, course, status) AS (
    (SELECT Registered.student, Registered.course, 'registered' AS status FROM Registered)
    UNION
    (SELECT WaitingList.student, WaitingList.course, 'waiting' AS status FROM WaitingList)  
);


CREATE OR REPLACE VIEW UnreadMandatory AS (
    SELECT idnr AS student, course
    FROM BasicInformation
    JOIN MandatoryProgram ON MandatoryProgram.program=BasicInformation.program
    UNION
    SELECT idnr AS student, course
    FROM BasicInformation
    JOIN MandatoryBranch ON MandatoryBranch.branch = BasicInformation.branch AND MandatoryBranch.program = BasicInformation.program
    EXCEPT
    SELECT student, course
    FROM PassedCourses
);


------------


CREATE OR REPLACE VIEW TotalCredits AS (
    SELECT PassedCourses.student, SUM(PassedCourses.credits) AS total
    FROM PassedCourses
    GROUP BY student
);


CREATE OR REPLACE VIEW MandatoryLeft AS (
    SELECT UnreadMandatory.student, COUNT(UnreadMandatory.student) AS total
    FROM UnreadMandatory
    GROUP BY student
);

CREATE OR REPLACE VIEW MathCredits AS (
    SELECT PassedCourses.student, SUM(PassedCourses.credits) AS total
    FROM passedcourses, Classified
    WHERE PassedCourses.course = Classified.course AND Classified.classification = 'math'
    GROUP BY student
);


CREATE OR REPLACE VIEW ResearchCredits AS (
    SELECT PassedCourses.student, SUM(PassedCourses.credits) AS total
    FROM PassedCourses
    JOIN Classified ON PassedCourses.course=Classified.course
    WHERE Classification ='research'
    GROUP BY student   
);

CREATE OR REPLACE VIEW SeminarCourses AS (
    SELECT PassedCourses.student, COUNT(PassedCourses.student) AS total
    FROM PassedCourses
    JOIN Classified ON PassedCourses.course=Classified.course
    WHERE Classification ='seminar'
    GROUP BY student
);

CREATE OR REPLACE VIEW RecommendedCoursePoints AS (
    SELECT BasicInformation.idnr, BasicInformation.program, BasicInformation.branch, RecommendedBranch.course, PassedCourses.credits
    FROM BasicInformation
    JOIN RecommendedBranch ON BasicInformation.program=RecommendedBranch.program AND BasicInformation.branch=RecommendedBranch.branch
    JOIN PassedCourses ON RecommendedBranch.course=passedcourses.course AND BasicInformation.idnr=passedcourses.student
);

CREATE OR REPLACE VIEW PassedRecommended AS (
    SELECT RecommendedCoursePoints.idnr AS student, SUM(RecommendedCoursePoints.credits) AS total
    FROM RecommendedCoursePoints
    GROUP BY student
);


CREATE OR REPLACE VIEW PathToGraduation AS (
    SELECT
    BasicInformation.idnr AS student,
    COALESCE(TotalCredits.total, 0) AS totalCredits,
    COALESCE(MandatoryLeft.total, 0) AS mandatoryLeft,
    COALESCE(MathCredits.total, 0) AS mathCredits,
    COALESCE(ResearchCredits.total, 0) AS researchCredits,
    COALESCE(SeminarCourses.total, 0) AS seminarCourses,
    COALESCE(MandatoryLeft.total IS NULL AND MathCredits.total > 19 AND
    ResearchCredits.total > 9 AND SeminarCourses.total > 0 AND PassedRecommended.total > 9, false) AS qualified
    FROM BasicInformation
    LEFT JOIN totalCredits ON idnr=totalCredits.student
    LEFT JOIN mandatoryLeft ON idnr=mandatoryLeft.student
    LEFT JOIN mathCredits ON idnr=mathCredits.student
    LEFT JOIN researchCredits ON idnr=researchCredits.student
    LEFT JOIN seminarCourses ON idnr=seminarCourses.student
    LEFT JOIN PassedRecommended ON idnr=PassedRecommended.student
);