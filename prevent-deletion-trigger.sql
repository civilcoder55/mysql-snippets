DELIMITER $$
CREATE TRIGGER prevent_deletion
BEFORE DELETE ON users
FOR EACH ROW
BEGIN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'deletion prevented on users table';
END$$
DELIMITER ;
