-- ITEC 340
-- Move Log Trgger 

CREATE OR REPLACE TRIGGER Move_Log
AFTER UPDATE OF Room_ID
ON Explorer 
FOR EACH ROW

BEGIN
	INSERT INTO Move_Log (Name, Move_Num, From_Room, To_Room, Move_Date)
	VALUES (:NEW.name, move_seq.nextval, :OLD.room_ID, :NEW.room_ID, CURRENT_TIMESTAMP);
END;
/

SHOW ERRORS


