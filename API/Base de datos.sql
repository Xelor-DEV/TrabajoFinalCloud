CREATE TABLE UserGame (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    user_password VARCHAR(50),
    email VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(50),
    modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    modified_by VARCHAR(50),
    user_state INT DEFAULT 1  
);

CREATE TABLE Login (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    user_password VARCHAR(50),
    user_state INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(50),
    modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    modified_by VARCHAR(50)
);

CREATE TABLE Game1 (
    gameid INT PRIMARY KEY AUTO_INCREMENT,
    userid INT,
    time_in_seconds INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(50),
    modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    modified_by VARCHAR(50),
    user_state INT DEFAULT 1,
    FOREIGN KEY (userid) REFERENCES UserGame(user_id)
);

CREATE TABLE Game2 (
    gameid INT PRIMARY KEY AUTO_INCREMENT,
    userid INT,
    score INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(50),
    modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    modified_by VARCHAR(50),
    user_state INT DEFAULT 1,
    FOREIGN KEY (userid) REFERENCES UserGame(user_id)
);

CREATE TABLE Game3 (
    gameid INT PRIMARY KEY AUTO_INCREMENT,
    userid INT,
    score INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(50),
    modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    modified_by VARCHAR(50),
    user_state INT DEFAULT 1,
    FOREIGN KEY (userid) REFERENCES UserGame(user_id)
);

CREATE TABLE Game4 (
    gameid INT PRIMARY KEY AUTO_INCREMENT,
    userid INT,
    score INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(50),
    modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    modified_by VARCHAR(50),
    user_state INT DEFAULT 1,
    FOREIGN KEY (userid) REFERENCES UserGame(user_id)
);

CREATE TABLE Game5 (
    gameid INT PRIMARY KEY AUTO_INCREMENT,
    userid INT,
    score INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(50),
    modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    modified_by VARCHAR(50),
    user_state INT DEFAULT 1,
    FOREIGN KEY (userid) REFERENCES UserGame(user_id)
);








CREATE VIEW ViewTimeGame1 AS
SELECT
    Game1.gameid AS IDJuego,
    UserGame.username AS NombreUsuario,
    Game1.time_in_seconds AS TiempoEnSegundos,
    Game1.created_at AS FechaCreacion
FROM Game1
INNER JOIN UserGame ON Game1.userid = UserGame.user_id
WHERE Game1.user_state = 1
ORDER BY Game1.time_in_seconds ASC;

CREATE VIEW ViewScoreGame2 AS
SELECT
    Game2.gameid AS IDJuego,
    UserGame.username AS NombreUsuario,
    Game2.score AS Puntuacion,
    Game2.created_at AS FechaCreacion
FROM Game2
INNER JOIN UserGame ON Game2.userid = UserGame.user_id
WHERE Game2.user_state = 1
ORDER BY Game2.score DESC;

CREATE VIEW ViewScoreGame3 AS
SELECT
    Game3.gameid AS IDJuego,
    UserGame.username AS NombreUsuario,
    Game3.score AS Puntuacion,
    Game3.created_at AS FechaCreacion
FROM Game3
INNER JOIN UserGame ON Game3.userid = UserGame.user_id
WHERE Game3.user_state = 1
ORDER BY Game3.score DESC;  

CREATE VIEW ViewScoreGame4 AS
SELECT
    Game4.gameid AS IDJuego,
    UserGame.username AS NombreUsuario,
    Game4.score AS Puntuacion,
    Game4.created_at AS FechaCreacion
FROM Game4
INNER JOIN UserGame ON Game4.userid = UserGame.user_id
WHERE Game4.user_state = 1
ORDER BY Game4.score DESC;

CREATE VIEW ViewScoreGame5 AS
SELECT
    Game5.gameid AS IDJuego,
    UserGame.username AS NombreUsuario,
    Game5.score AS Puntuacion,
    Game5.created_at AS FechaCreacion
FROM Game5
INNER JOIN UserGame ON Game5.userid = UserGame.user_id
WHERE Game5.user_state = 1
ORDER BY Game5.score DESC;

CREATE VIEW ViewAllUsers AS
SELECT
    user_id AS IDUsuario,
    username AS NombreUsuario,
    email AS CorreoElectronico,
    created_at AS FechaCreacion,
    modified_at AS FechaModificacion
FROM UserGame
WHERE user_state = 1
ORDER BY created_at DESC;








CREATE PROCEDURE ReadLogin ()
BEGIN
    SELECT * FROM Login;
END;

CREATE PROCEDURE ReadUserGame 
()
BEGIN
    SELECT * FROM UserGame;
END;

CREATE PROCEDURE ReadGame1 
()
BEGIN
    SELECT * FROM Game1;
END;

CREATE PROCEDURE ReadGame2 
()
BEGIN
    SELECT * FROM Game2;
END;

CREATE PROCEDURE ReadGame3 
()
BEGIN
    SELECT * FROM Game3;
END;

CREATE PROCEDURE ReadGame4 
()
BEGIN
    SELECT * FROM Game4;
END;

CREATE PROCEDURE ReadGame5
()
BEGIN
    SELECT * FROM Game4;
END;








CREATE PROCEDURE UpdateLogin
(
    IN p_id INT,
    IN p_username VARCHAR(50),
    IN p_user_password VARCHAR(50),
    IN p_user_state INT,
    IN p_modified_by VARCHAR(50)
)
BEGIN
    UPDATE Login
    SET username = p_username,
        user_password = p_user_password,
        user_state = p_user_state,
        modified_by = p_modified_by
    WHERE id = p_id;
END;

CREATE PROCEDURE UpdateUserGame 
(
    IN p_user_id INT,
    IN p_username VARCHAR(50),
    IN p_user_password VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_user_state INT,
    IN p_modified_by VARCHAR(50)
)
BEGIN
    UPDATE UserGame
    SET username = p_username,
        user_password = p_user_password,
        email = p_email,
        user_state = p_user_state,
        modified_by = p_modified_by
    WHERE user_id = p_user_id;
END;

CREATE PROCEDURE UpdateGame1 
(
    IN p_gameid INT,
    IN p_userid INT,
    IN p_time_in_seconds INT,
    IN p_user_state INT,
    IN p_modified_by VARCHAR(50)
)
BEGIN
    UPDATE Game1
    SET userid = p_userid,
        time_in_seconds = p_time_in_seconds,
        user_state = p_user_state,
        modified_by = p_modified_by
    WHERE gameid = p_gameid;
END;

CREATE PROCEDURE UpdateGame2 
(
    IN p_gameid INT,
    IN p_userid INT,
    IN p_score INT,
    IN p_user_state INT,
    IN p_modified_by VARCHAR(50)
)
BEGIN
    UPDATE Game2
    SET userid = p_userid,
        score = p_score,
        user_state = p_user_state,
        modified_by = p_modified_by
    WHERE gameid = p_gameid;
END;

CREATE PROCEDURE UpdateGame3 
(
    IN p_gameid INT,
    IN p_userid INT,
    IN p_score INT,
    IN p_user_state INT,
    IN p_modified_by VARCHAR(50)
)
BEGIN
    UPDATE Game3
    SET userid = p_userid,
        score = p_score,
        user_state = p_user_state,
        modified_by = p_modified_by
    WHERE gameid = p_gameid;
END;

CREATE PROCEDURE UpdateGame4 
(
    IN p_gameid INT,
    IN p_userid INT,
    IN p_score INT,
    IN p_user_state INT,
    IN p_modified_by VARCHAR(50)
)
BEGIN
    UPDATE Game4
    SET userid = p_userid,
        score = p_score,
        user_state = p_user_state,
        modified_by = p_modified_by
    WHERE gameid = p_gameid;
END;

CREATE PROCEDURE UpdateGame5 
(
    IN p_gameid INT,
    IN p_userid INT,
    IN p_score INT,
    IN p_user_state INT,
    IN p_modified_by VARCHAR(50)
)
BEGIN
    UPDATE Game5
    SET userid = p_userid,
        score = p_score,
        user_state = p_user_state,
        modified_by = p_modified_by
    WHERE gameid = p_gameid;
END;








CREATE PROCEDURE DeleteLogin
(
    IN p_id INT
)
BEGIN
    UPDATE Login
    SET user_state = 0
    WHERE id = p_id;
END;

CREATE PROCEDURE DeleteUserGame 
(
    IN p_user_id INT
)
BEGIN
    UPDATE UserGame
    SET user_state = 0
    WHERE user_id = p_user_id;
END;

CREATE PROCEDURE DeleteGame1 
(
    IN p_gameid INT
)
BEGIN
    UPDATE Game1
    SET user_state = 0
    WHERE gameid = p_gameid;
END;

CREATE PROCEDURE DeleteGame2 
(
    IN p_gameid INT
)
BEGIN
    UPDATE Game2
    SET user_state = 0
    WHERE gameid = p_gameid;
END;

CREATE PROCEDURE DeleteGame3 
(
    IN p_gameid INT
)
BEGIN
    UPDATE Game3
    SET user_state = 0
    WHERE gameid = p_gameid;
END;

CREATE PROCEDURE DeleteGame4 
(
    IN p_gameid INT
)
BEGIN
    UPDATE Game4
    SET user_state = 0
    WHERE gameid = p_gameid;
END;

CREATE PROCEDURE DeleteGame5 
(
    IN p_gameid INT
)
BEGIN
    UPDATE Game5
    SET user_state = 0
    WHERE gameid = p_gameid;
END;









CREATE PROCEDURE CreateLogin 
(
    IN p_username VARCHAR(50),
    IN p_user_password VARCHAR(50),
    IN p_created_by VARCHAR(50)
)
BEGIN
    DECLARE v_userid INT;
    DECLARE v_user_state INT;

    SELECT user_id, user_state INTO v_userid, v_user_state
    FROM UserGame 
    WHERE username = p_username AND user_password = p_user_password;

    IF v_userid IS NOT NULL AND v_user_state = 1 THEN
        INSERT INTO Login(username, user_password, user_state, created_by)
        VALUES (p_username, p_user_password, v_user_state, p_created_by);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Usuario no encontrado o inactivo';
    END IF;
END;

CREATE PROCEDURE CreateUserGame 
(
    IN p_username VARCHAR(50),
    IN p_user_password VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_created_by VARCHAR(50)
)
BEGIN
    INSERT INTO UserGame (username, user_password, email, created_by, modified_by)
    VALUES (p_username, p_user_password, p_email, p_created_by, p_created_by);
END;

CREATE PROCEDURE CreateGame1 
(
    IN p_userid INT,
    IN p_time_in_seconds INT,
    IN p_created_by VARCHAR(50)
)
BEGIN
    INSERT INTO Game1(userid, time_in_seconds, created_by)
    VALUES (p_userid, p_time_in_seconds, p_created_by);
END;


CREATE PROCEDURE CreateGame2 
(
    IN p_userid INT,
    IN p_score INT,
    IN p_created_by VARCHAR(50)
)
BEGIN
    INSERT INTO Game2(userid, score, created_by)
    VALUES (p_userid, p_score, p_created_by);
END;


CREATE PROCEDURE CreateGame3 
(
    IN p_userid INT,
    IN p_score INT,
    IN p_created_by VARCHAR(50)
)
BEGIN
    INSERT INTO Game3(userid, score, created_by)
    VALUES (p_userid, p_score, p_created_by);
END;


CREATE PROCEDURE CreateGame4 
(
    IN p_userid INT,
    IN p_score INT,
    IN p_created_by VARCHAR(50)
)
BEGIN
    INSERT INTO Game4(userid, score, created_by)
    VALUES (p_userid, p_score, p_created_by);
END;

CREATE PROCEDURE CreateGame5 
(
    IN p_userid INT,
    IN p_score INT,
    IN p_created_by VARCHAR(50)
)
BEGIN
    INSERT INTO Game5(userid, score, created_by)
    VALUES (p_userid, p_score, p_created_by);
END;