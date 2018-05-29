-- ITEC 340 
-- Dewey Milton 
-- Grab Procedure and Weight Trigger 

CREATE OR REPLACE PROCEDURE Grab (expName IN VARCHAR2) IS

	 vRoomID Room.Room_ID%TYPE; 
	 vTreasure Treasure.Treasure_Id%TYPE; 
	 OverWeight EXCEPTION; 
	 
	 CURSOR c 
	 IS 
	 	SELECT Treasure 
		FROM Room 
		WHERE Room_ID = vRoomID
		FOR UPDATE of Treasure;
		
BEGIN 
 
	SELECT Room_ID INTO vRoomID FROM Explorer WHERE Name = expName;
	
	OPEN c; 
	FETCH c INTO vTreasure; 
	
	INSERT INTO Explorer_Treasure(Explorer_Name, Treasure_Id)
	VALUES (expName, vTreasure); 
	
	dbms_output.put_line(expName || ' Taking ' || vTreasure); 
	
	UPDATE Room
	Set Treasure = NULL
	WHERE Room_ID = vRoomID; 
	CLOSE c; 
	
	COMMIT;
	
	EXCEPTION 
	WHEN OverWeight THEN 
	dbms_output.put_line('OverWeight Rollback'); 
	ROLLBACK;
	-- Error OverWeight, For some reason doesnt raise in trigger 
	WHEN no_data_found THEN 
	ROLLBACK;  -- Rollback 2
	dbms_output.put_line('Null Value Rollback');
	WHEN OTHERS THEN 
	ROLLBACK; 
	dbms_output.put_line('OverWeight Error RollBack');
	
	END;
	/ 
	
	show errors
