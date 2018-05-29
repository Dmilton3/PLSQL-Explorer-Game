-- ITEC 340
-- Test Explorers Exercise 

SET ECHO ON;
SET SERVEROUTPUT ON;

INSERT INTO Treasure(Treasure_ID, Name, Value, Weight)
VALUES (1, 'Golden Pot', '230', 33.5);

INSERT INTO Treasure(Treasure_ID, Name, Value, Weight)
VALUES (2, 'Vodka', 22.4, 3.5);

INSERT INTO Treasure(Treasure_ID, Name, Value, Weight)
VALUES (3, 'Diamonds', '33.4', '10.5');

INSERT INTO Treasure(Treasure_ID, Name, Value, Weight)
VALUES (4, 'Crown', '100.00', '50.00');

INSERT INTO Explorer (Name, Room_ID, Max_Weight)
VALUES ('Dora', 1, 50.0);

INSERT INTO Explorer (Name, Room_ID, Max_Weight)
VALUES ('Rick', 1, 45); 
 
UPDATE Explorer SET Room_ID = 1 WHERE Name = 'Dora';
UPDATE Explorer SET Room_ID = 1 WHERE Name = 'Rick'; 

EXEC grab('Rick'); 
EXEC grab('Dora'); 

SELECT * 
FROM Explorer_Treasure ET INNER JOIN Room Rm
ON ET.Explorer_Name= Rm.Name; 

EXEC move('Rick'); 
EXEC move('Dora');
EXEC grab('Dora');
EXEC grab('Rick');
 
EXEC move('Rick');
EXEC move('Dora');
EXEC grab('Rick'); 
EXEC grab('Dora');

SELECT * 
FROM Explorer_Treasure ET INNER JOIN Room Rm
ON ET.Explorer_Name= Rm.Name; 

EXEC move('Rick');
EXEC move('Dora');
EXEC grab('Dora');
EXEC grab('Rick'); 

SELECT * 
FROM Explorer_Treasure ET INNER JOIN Room Rm
ON ET.Explorer_Name= Rm.Name; 

EXEC move('Rick');
EXEC move('Dora');
EXEC grab('Rick'); 
EXEC grab('Dora');

SELECT * 
FROM Explorer_Treasure ET INNER JOIN Room Rm
ON ET.Explorer_Name= Rm.Name; 

SELECT	Name, Move_Num, From_Room, To_Room, 
		TO_CHAR(Move_Date, 'DD-MON-YYYY HH24:MI:SSxFF') AS MOVE_TIME
FROM	Move_log;


