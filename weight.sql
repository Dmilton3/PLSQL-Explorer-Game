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