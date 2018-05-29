-- ITEC 340  
-- Create initial Explorers schema for exercise
SET ECHO ON; 
SET SERVEROUTPUT ON;


DROP TABLE Explorer_Treasure;

DROP TABLE Explorer;
DROP TABLE Room;
DROP TABLE Treasure; 
DROP TABLE Move_Log;
DROP SEQUENCE move_seq;


CREATE TABLE Explorer_Treasure
(
	Explorer_Name VARCHAR2(20)
,	Treasure_ID   NUMBER(3)
, 	CONSTRAINT ExpTr_PK PRIMARY KEY (Explorer_Name, Treasure_ID)
);
CREATE TABLE Treasure
(
	Treasure_ID NUMBER(3) CONSTRAINT Tr_PK PRIMARY KEY
, 	Name 	VARCHAR2(20)
,	Value 	DECIMAL(5,2)
,	Weight  DECIMAL(5,2)
); 

CREATE TABLE Room
(
	Room_ID			NUMBER
,	Name			VARCHAR2(20)
,	Next_Room_ID	NUMBER 
,	Treasure 	   NUMBER(3) 
, CONSTRAINT Rm_FK FOREIGN KEY (Treasure) REFERENCES Treasure(Treasure_ID)
, CONSTRAINT Room_PK PRIMARY KEY (Room_ID)
); 


CREATE TABLE Explorer
(
	Name			VARCHAR2(20)
,	Room_ID			NUMBER
, 	Max_Weight		DECIMAL(5,2)
, CONSTRAINT Exp_PK PRIMARY KEY (Name)
, CONSTRAINT Exp_Room_FK FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID)
);

COMMIT; 


CREATE TABLE Move_Log
(
	Name		VARCHAR2(5)
,	Move_Num	NUMBER(3)
,	From_Room	NUMBER(3)
,	To_Room		NUMBER(3)
,	Move_Date	TIMESTAMP
);

CREATE SEQUENCE move_seq
	MINVALUE	-1
	START WITH	0;

COMMIT; 

-- Load rooms 

INSERT INTO Treasure(Treasure_ID, Name, Value, Weight)
VALUES (1, 'Golden Pot', '230', 33.5);

INSERT INTO Treasure(Treasure_ID, Name, Value, Weight)
VALUES (2, 'Vodka', 22.4, 3.5);

INSERT INTO Treasure(Treasure_ID, Name, Value, Weight)
VALUES (3, 'Diamonds', '33.4', '10.5');

INSERT INTO Treasure(Treasure_ID, Name, Value, Weight)
VALUES (4, 'Crown', '100.00', '50.00');

INSERT INTO Room (Room_ID, Name, Next_Room_ID, Treasure)
VALUES (1, 'Start Room', 2, 1);

INSERT INTO Room (Room_ID, Name, Next_Room_ID, Treasure)
VALUES (2, 'Davis 216', 3, 2);

INSERT INTO Room (Room_ID, Name, Next_Room_ID, Treasure)
VALUES (3, 'Davis 225', 4, 3);

INSERT INTO Room (Room_ID, Name, Next_Room_ID, Treasure)
VALUES (4, 'the End Room', null, 4);

-- Load explorer 

INSERT INTO Explorer (Name, Room_ID, Max_Weight)
VALUES ('Dora', 1, 50.0);

COMMIT; 
