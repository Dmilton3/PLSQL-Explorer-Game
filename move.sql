-- ITEC 340
-- Move procedure 

SET ECHO ON; 
SET SERVEROUTPUT ON; 

CREATE OR REPLACE PROCEDURE Move (expName IN VARCHAR2) IS

	vRoomID		NUMBER;
	vNextRoomID	NUMBER;

BEGIN
	SELECT Room_ID INTO vRoomID  FROM Explorer WHERE Name = expName;

	SELECT Next_Room_ID INTO vNextRoomID FROM Room WHERE Room_ID = vRoomID;
	dbms_output.put_line('Setting explorer room ' || vNextRoomID); 
	UPDATE Explorer
	SET Room_ID = vNextRoomID
	WHERE Name = expName;

	vRoomID := vNextRoomID;
	
	COMMIT; 
END Move;
/

SHOW ERRORS

