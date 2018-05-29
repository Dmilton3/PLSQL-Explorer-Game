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


-- Dewey Milton 
-- Itec 340
-- Trigger To check if explorer is overweight

CREATE OR REPLACE TRIGGER Weight_Chk
BEFORE INSERT
ON Explorer_Treasure
FOR EACH ROW
 
 DECLARE 
 
  weightTest Treasure.Weight%TYPE;
  maxWeight Explorer.Max_Weight%TYPE; 
  totalWeight Treasure.Weight%TYPE; 
  OverWeight EXCEPTION; 

BEGIN  

   dbms_output.put_line('in the Trigger');
   
    totalWeight := 0; 
    maxWeight := 0;
    
  BEGIN 
       
  SELECT SUM(Tr.Weight)
  INTO totalWeight
  FROM Explorer_Treasure ET INNER JOIN Treasure Tr
  ON Tr.Treasure_Id = ET.Treasure_Id
  WHERE ET.Explorer_Name = :New.Explorer_Name;
  

   dbms_output.put_line('After Sum Explorer Weight is ' || totalWeight);
   EXCEPTION
     WHEN no_data_found THEN
     dbms_output.put_line('Exception Found');
  END; 
  
  SELECT Max_Weight
  INTO maxWeight
  FROM Explorer
  WHERE Name = :New.Explorer_Name; 
  
  dbms_output.put_line('Checking ' || :New.Explorer_Name);
    
  SELECT Weight
  INTO weightTest
  FROM Treasure
  WHERE Treasure_Id = :New.Treasure_Id; 
   
  dbms_output.put_line('Weight of the item ' || weightTest); 
    
  totalWeight := totalWeight + weightTest; 
  
  dbms_output.put_line('Explorer Weight ' || totalWeight);

 IF totalWeight > maxWeight THEN 
    RAISE OverWeight; 
 END IF; 
  
 EXCEPTION
   WHEN OverWeight THEN
   dbms_output.put_line('OverWeight');
   ROLLBACK; 
  
END;
/


SHOW ERRORS