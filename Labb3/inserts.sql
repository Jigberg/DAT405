INSERT INTO Dept VALUES ('DI', 'Data- och informationsteknik');
INSERT INTO Dept VALUES ('MS', 'Mek snubbarna');

INSERT INTO Program VALUES ('Informationsteknik', 'IT');
INSERT INTO Program VALUES ('Automation och Mekatronik', 'ZZ');

INSERT INTO Students VALUES ('9812152792','Lukas Jigberg','mittCid','Informationsteknik');
INSERT INTO Students VALUES ('2222222222','Boris Borisson','password','Automation och Mekatronik');
INSERT INTO Students VALUES ('3333333333','Torsten Torstensson','senap','Informationsteknik');
INSERT INTO Students VALUES ('4444444444','Klant Ballé','lösenord','Automation och Mekatronik');
INSERT INTO Students VALUES ('5555555555','Klantus Ballé','något_annat','Automation och Mekatronik');
INSERT INTO Students VALUES ('6666666666','Klanta Ballé','något_mer','Automation och Mekatronik');

INSERT INTO Branches VALUES ('SystemVetenskap','Informationsteknik');
INSERT INTO Branches VALUES ('Artificiell Intelligens','Automation och Mekatronik');
INSERT INTO Branches VALUES ('Hållbar Utveckling','Automation och Mekatronik');

INSERT INTO BelongsTo VALUES ('9812152792', 'SystemVetenskap', 'Informationsteknik');
INSERT INTO BelongsTo VALUES ('2222222222', 'Artificiell Intelligens', 'Automation och Mekatronik');
INSERT INTO BelongsTo VALUES ('3333333333', 'SystemVetenskap', 'Informationsteknik');
INSERT INTO BelongsTo VALUES ('4444444444', 'Hållbar Utveckling', 'Automation och Mekatronik');
INSERT INTO BelongsTo VALUES ('5555555555', 'Hållbar Utveckling', 'Automation och Mekatronik');
INSERT INTO BelongsTo VALUES ('6666666666', 'Hållbar Utveckling', 'Automation och Mekatronik');

INSERT INTO Courses VALUES ('TDA357','Databaser',22.5,'DI');
INSERT INTO Courses VALUES ('DAT405','AI for losers',20,'DI');
INSERT INTO Courses VALUES ('ASS404','Anatomi for beginners',20,'DI');
INSERT INTO Courses VALUES ('PIS123','Häv for beginers',30,'MS');
INSERT INTO Courses VALUES ('TDP123','Lär dig läsa',60,'MS');
INSERT INTO Courses VALUES ('SSY098','Image analysis',7.5,'MS');
INSERT INTO Courses VALUES ('PLT123','plantera',30,'MS');


INSERT INTO LimitedCourses VALUES ('TDP123',1);
INSERT INTO LimitedCourses VALUES ('SSY098',2);

INSERT INTO Classifications VALUES ('math');
INSERT INTO Classifications VALUES ('research');
INSERT INTO Classifications VALUES ('seminar');

INSERT INTO Classified VALUES ('TDA357','math');
INSERT INTO Classified VALUES ('DAT405','math');
INSERT INTO Classified VALUES ('DAT405','research');
INSERT INTO Classified VALUES ('TDP123','seminar');

INSERT INTO MandatoryProgram VALUES ('TDA357','Informationsteknik');

INSERT INTO MandatoryBranch VALUES ('DAT405', 'SystemVetenskap', 'Informationsteknik');
INSERT INTO MandatoryBranch VALUES ('SSY098', 'Artificiell Intelligens', 'Automation och Mekatronik');

INSERT INTO RecommendedBranch VALUES ('TDP123', 'Hållbar Utveckling', 'Automation och Mekatronik');

INSERT INTO Registered VALUES ('9812152792','TDA357');
INSERT INTO Registered VALUES ('2222222222','SSY098');
INSERT INTO Registered VALUES ('3333333333','TDA357');
INSERT INTO Registered VALUES ('4444444444','TDP123');
INSERT INTO Registered VALUES ('4444444444','SSY098');
INSERT INTO Registered VALUES ('2222222222','PIS123');

INSERT INTO Taken VALUES('4444444444','PLT123','5');
INSERT INTO Taken VALUES('4444444444','PIS123','5');
INSERT INTO Taken VALUES('3333333333','ASS404','5');

--INSERT INTO Taken VALUES('5555555555','TDP123','4');
INSERT INTO Taken VALUES('5555555555','SSY098','3');

INSERT INTO Taken VALUES('5555555555','PLT123','U');
INSERT INTO Taken VALUES('9812152792','ASS404','U');

INSERT INTO WaitingList VALUES('2222222222','TDP123',1);
INSERT INTO WaitingList VALUES('5555555555','TDP123',2);
INSERT INTO WaitingList VALUES('6666666666','SSY098',1);
