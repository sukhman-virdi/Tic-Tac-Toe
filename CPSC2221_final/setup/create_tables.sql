-- ------------------------------------------------------------
-- TicTacToe Platform Database Setup Script
-- ------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS tictactoe;
USE tictactoe;

-- ------------------------------------------------------------
-- DROP TABLES
-- ------------------------------------------------------------

DROP TABLE IF EXISTS Joins;
DROP TABLE IF EXISTS Oversees;
DROP TABLE IF EXISTS Edits;
DROP TABLE IF EXISTS Awarded;
DROP TABLE IF EXISTS Plays_inMatch;
DROP TABLE IF EXISTS Move_MadeIn;
DROP TABLE IF EXISTS Match_Contained;
DROP TABLE IF EXISTS Tournament_Managed;
DROP TABLE IF EXISTS PrizeMoney;
DROP TABLE IF EXISTS Achievement;
DROP TABLE IF EXISTS TournamentManager;
DROP TABLE IF EXISTS Player;
DROP TABLE IF EXISTS Admin;
DROP TABLE IF EXISTS GameUser;
DROP TABLE IF EXISTS Department;

-- ------------------------------------------------------------
-- CREATE TABLES
-- ------------------------------------------------------------

CREATE TABLE Department (
    Level INT PRIMARY KEY,
    Department VARCHAR(40)
);
 
CREATE TABLE GameUser (
    UserID INT PRIMARY KEY,
    Username VARCHAR(40) UNIQUE NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(40) NOT NULL
);
 
CREATE TABLE Admin (
    AdminID INT PRIMARY KEY,
    Name VARCHAR(40),
    Email VARCHAR(40) UNIQUE NOT NULL,
    Password VARCHAR(30) NOT NULL,
    Level INT,
    FOREIGN KEY (Level) REFERENCES Department(Level)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
 
CREATE TABLE Player (
    PlayerID INT PRIMARY KEY,
    TotalWins INT DEFAULT 0,
    TotalLosses INT DEFAULT 0,
    TotalDraws INT DEFAULT 0,
    RankingPoints INT DEFAULT 0,
    FOREIGN KEY (PlayerID) REFERENCES GameUser(UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
 
CREATE TABLE TournamentManager (
    ManagerID INT PRIMARY KEY,
    Tournaments_Organized INT DEFAULT 0,
    FOREIGN KEY (ManagerID) REFERENCES GameUser(UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
 
CREATE TABLE Achievement (
    AchievementID INT PRIMARY KEY,
    Title VARCHAR(40) UNIQUE NOT NULL,
    Description VARCHAR(800)
);
 
CREATE TABLE PrizeMoney (
    Difficulty INT PRIMARY KEY,
    PrizeMoney INT DEFAULT 0
);
 
CREATE TABLE Tournament_Managed (
    TournamentID INT PRIMARY KEY,
    Name VARCHAR(50) UNIQUE NOT NULL,
    Difficulty INT,
    StartDate DATE,
    ManagerID INT NOT NULL,
    SupervisorID INT NOT NULL,
    FOREIGN KEY (Difficulty) REFERENCES PrizeMoney(Difficulty)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (SupervisorID) REFERENCES Admin(AdminID)
        ON UPDATE CASCADE,
    FOREIGN KEY (ManagerID) REFERENCES TournamentManager(ManagerID)
        ON UPDATE CASCADE
);
 
CREATE TABLE Match_Contained (
    MatchID INT PRIMARY KEY,
    Match_Date DATE DEFAULT (CURRENT_DATE),
    Match_Time TIME DEFAULT (CURRENT_TIME),
    Winner_ID INT,
    TournamentID INT, -- can be null to save mactches with AI
    FOREIGN KEY (TournamentID) REFERENCES Tournament_Managed(TournamentID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Winner_ID) REFERENCES Player(PlayerID)
        ON UPDATE CASCADE
);
 
CREATE TABLE Move_MadeIn (
    MatchID INT,
    Move_Number INT,
    Position VARCHAR(20),
    PRIMARY KEY (MatchID, Move_Number),
    FOREIGN KEY (MatchID) REFERENCES Match_Contained(MatchID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
 
CREATE TABLE Plays_inMatch (
    MatchID INT PRIMARY KEY,
    Player1_ID INT NOT NULL,
    Player2_ID INT NOT NULL,
    FOREIGN KEY (Player1_ID) REFERENCES Player(PlayerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Player2_ID) REFERENCES Player(PlayerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
 
CREATE TABLE Awarded (
    UserID INT,
    AchievementID INT,
    AwardDate DATE DEFAULT (CURRENT_DATE),
    PRIMARY KEY (UserID, AchievementID),
    FOREIGN KEY (UserID) REFERENCES GameUser(UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (AchievementID) REFERENCES Achievement(AchievementID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
 
CREATE TABLE Edits (
    AdminID INT,
    AchievementID INT,
    EditDate DATE DEFAULT (CURRENT_DATE),
    PRIMARY KEY (AdminID, AchievementID),
    FOREIGN KEY (AdminID) REFERENCES Admin(AdminID)
        ON UPDATE CASCADE,
    FOREIGN KEY (AchievementID) REFERENCES Achievement(AchievementID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
 
CREATE TABLE Oversees (
    AdminID INT,
    UserID INT,
    Admin_Comments VARCHAR(255),
    PRIMARY KEY (AdminID, UserID),
    FOREIGN KEY (AdminID) REFERENCES Admin(AdminID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (UserID) REFERENCES GameUser(UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
 
CREATE TABLE Joins (
    PlayerID INT,
    TournamentID INT,
    JoinDate DATE DEFAULT (CURRENT_DATE),
    PRIMARY KEY (PlayerID, TournamentID),
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (TournamentID) REFERENCES Tournament_Managed(TournamentID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ------------------------------------------------------------
-- INSERT DATA
-- ------------------------------------------------------------

INSERT INTO Department VALUES (1, 'Operations');
INSERT INTO Department VALUES (2, 'Management');
INSERT INTO Department VALUES (3, 'Moderation');
INSERT INTO Department VALUES (4, 'Support');
INSERT INTO Department VALUES (5, 'Development');
 
INSERT INTO GameUser VALUES (1, 'alex99', 'alex99@email.com', 'pass1234');
INSERT INTO GameUser VALUES (2, 'sarah_j', 'sarah@email.com', 'pass5678');
INSERT INTO GameUser VALUES (3, 'mikegamer', 'mike@email.com', 'pass9012');
INSERT INTO GameUser VALUES (4, 'lisa_play', 'lisa@email.com', 'pass3456');
INSERT INTO GameUser VALUES (5, 'john_doe', 'john@email.com', 'pass7890');
INSERT INTO GameUser VALUES (6, 'emma_win', 'emma@email.com', 'pass1111');
INSERT INTO GameUser VALUES (7, 'admin_tom', 'tom_user@email.com', 'pass2222');
INSERT INTO GameUser VALUES (8, 'admin_sue', 'sue_user@email.com', 'pass3333');
INSERT INTO GameUser VALUES (9, 'manager_bob', 'bob@email.com', 'pass4444');
INSERT INTO GameUser VALUES (10, 'manager_ann', 'ann@email.com', 'pass5555');
INSERT INTO GameUser VALUES (11, 'manager_carl', 'carl@email.com', 'pass6666');
INSERT INTO GameUser VALUES (12, 'manager_diana', 'diana@email.com', 'pass7777');
INSERT INTO GameUser VALUES (13, 'manager_evan', 'evan@email.com', 'pass8888');
 
INSERT INTO Admin VALUES (1, 'Tom Harris', 'tom@email.com', 'pass2222', 2);
INSERT INTO Admin VALUES (2, 'Sue White', 'sue@email.com', 'pass3333', 1);
INSERT INTO Admin VALUES (3, 'James Brown', 'james@email.com', 'pass6666', 3);
INSERT INTO Admin VALUES (4, 'Lucy Green', 'lucy@email.com', 'pass7777', 4);
INSERT INTO Admin VALUES (5, 'Mark Black', 'mark@email.com', 'pass8888', 5);
 
INSERT INTO Player VALUES (1, 10, 3, 2, 850);
INSERT INTO Player VALUES (2, 7,  5, 1, 720);
INSERT INTO Player VALUES (3, 15, 2, 3, 950);
INSERT INTO Player VALUES (4, 4,  8, 2, 480);
INSERT INTO Player VALUES (5, 6,  6, 4, 600);
INSERT INTO Player VALUES (6, 12, 1, 1, 900);

-- needed to save games with AI
INSERT IGNORE INTO GameUser (UserID, Username, Email, Password) VALUES (0, 'AI', 'ai@system', 'N/A');
INSERT IGNORE INTO Player   (PlayerID) VALUES (0);
 
INSERT INTO TournamentManager VALUES (9,  3);
INSERT INTO TournamentManager VALUES (10, 5);
INSERT INTO TournamentManager VALUES (11, 2);
INSERT INTO TournamentManager VALUES (12, 1);
INSERT INTO TournamentManager VALUES (13, 4);
 
INSERT INTO Achievement VALUES (1, 'First Win',    'Win your first match');
INSERT INTO Achievement VALUES (2, 'Veteran',      'Play 50 matches');
INSERT INTO Achievement VALUES (3, 'Undefeated',   'Win 10 matches in a row');
INSERT INTO Achievement VALUES (4, 'Sharp Mind',   'Complete a match in under 20 moves');
INSERT INTO Achievement VALUES (5, 'Grand Master', 'Reach 1000 ranking points');
 
INSERT INTO PrizeMoney VALUES (1, 100);
INSERT INTO PrizeMoney VALUES (2, 250);
INSERT INTO PrizeMoney VALUES (3, 500);
INSERT INTO PrizeMoney VALUES (4, 1000);
INSERT INTO PrizeMoney VALUES (5, 2000);
 
INSERT INTO Tournament_Managed VALUES (1, 'Spring Cup',     2, '2025-03-01', 9,  1);
INSERT INTO Tournament_Managed VALUES (2, 'Summer Clash',   3, '2025-06-15', 9,  2);
INSERT INTO Tournament_Managed VALUES (3, 'Autumn Open',    1, '2025-09-10', 10, 3);
INSERT INTO Tournament_Managed VALUES (4, 'Winter Classic', 4, '2025-12-01', 10, 4);
INSERT INTO Tournament_Managed VALUES (5, 'Grand Finale',   5, '2025-11-20', 9,  5);
 
INSERT INTO Match_Contained VALUES (1, '2025-03-05', '14:00:00', 1, 1);
INSERT INTO Match_Contained VALUES (2, '2025-03-06', '15:30:00', 3, 1);
INSERT INTO Match_Contained VALUES (3, '2025-06-20', '10:00:00', 2, 2);
INSERT INTO Match_Contained VALUES (4, '2025-09-12', '09:00:00', 5, 3);
INSERT INTO Match_Contained VALUES (5, '2025-12-05', '16:00:00', 6, 4);
 
INSERT INTO Move_MadeIn VALUES (1, 1, 'MiddleMiddle');
INSERT INTO Move_MadeIn VALUES (1, 2, 'TopLeft');
INSERT INTO Move_MadeIn VALUES (1, 3, 'TopRight');
INSERT INTO Move_MadeIn VALUES (1, 4, 'BottomLeft');
INSERT INTO Move_MadeIn VALUES (1, 5, 'BottomRight');
INSERT INTO Move_MadeIn VALUES (2, 1, 'TopMiddle');
INSERT INTO Move_MadeIn VALUES (2, 2, 'MiddleLeft');
INSERT INTO Move_MadeIn VALUES (2, 3, 'MiddleRight');
INSERT INTO Move_MadeIn VALUES (3, 1, 'MiddleMiddle');
INSERT INTO Move_MadeIn VALUES (3, 2, 'TopLeft');
 
INSERT INTO Plays_inMatch VALUES (1, 1, 2);
INSERT INTO Plays_inMatch VALUES (2, 3, 4);
INSERT INTO Plays_inMatch VALUES (3, 2, 5);
INSERT INTO Plays_inMatch VALUES (4, 5, 6);
INSERT INTO Plays_inMatch VALUES (5, 6, 3);
 
INSERT INTO Awarded VALUES (1, 1, '2025-03-05');
INSERT INTO Awarded VALUES (3, 1, '2025-03-06');
INSERT INTO Awarded VALUES (3, 3, '2025-06-20');
INSERT INTO Awarded VALUES (2, 2, '2025-09-12');
INSERT INTO Awarded VALUES (6, 5, '2025-12-05');
 
INSERT INTO Edits VALUES (1, 1, '2025-01-10');
INSERT INTO Edits VALUES (2, 2, '2025-02-15');
INSERT INTO Edits VALUES (3, 3, '2025-03-20');
INSERT INTO Edits VALUES (4, 4, '2025-04-25');
INSERT INTO Edits VALUES (5, 5, '2025-05-30');
 
INSERT INTO Oversees VALUES (1, 1, 'Good standing');
INSERT INTO Oversees VALUES (1, 2, 'Occasional disputes');
INSERT INTO Oversees VALUES (2, 3, 'No issues');
INSERT INTO Oversees VALUES (3, 4, 'Under review');
INSERT INTO Oversees VALUES (4, 5, 'Excellent behavior');
INSERT INTO Oversees VALUES (5, 6, 'No issues');
 
INSERT INTO Joins VALUES (1, 1, '2025-02-20');
INSERT INTO Joins VALUES (2, 1, '2025-02-21');
INSERT INTO Joins VALUES (3, 2, '2025-05-30');
INSERT INTO Joins VALUES (4, 3, '2025-08-25');
INSERT INTO Joins VALUES (5, 4, '2025-11-10');
INSERT INTO Joins VALUES (6, 5, '2025-11-01');

-- ------------------------------------------------------------
-- TRIGGERS
-- ------------------------------------------------------------

-- Drop triggers if they already exist
DROP TRIGGER IF EXISTS after_match_winner_update;
DROP TRIGGER IF EXISTS after_tournament_insert;

-- ------------------------------------------------------------
-- Trigger 1: Auto-update Player stats when a Match Winner is set,
-- increment TotalWins for the winner and TotalLosses for the loser

DELIMITER $$

CREATE TRIGGER after_match_winner_update
AFTER UPDATE ON Match_Contained
FOR EACH ROW
BEGIN
	-- Fire if winner is just set
	IF OLD.Winner_ID IS NULL AND NEW.Winner_ID IS NOT NULL THEN

		UPDATE Player
		SET TotalWins = TotalWins + 1
		WHERE PlayerID = NEW.Winner_ID;

		UPDATE Player
		SET TotalLosses = TotalLosses + 1
		WHERE PlayerID = (
			SELECT CASE
				WHEN Player1_ID = NEW.Winner_ID THEN Player2_ID
				ELSE Player1_ID
			END
			FROM Plays_inMatch
			WHERE MatchID = NEW.MatchID
		);

	END IF;
END$$

-- ------------------------------------------------------------
-- Trigger 2: Auto-increment Tournaments_Organized for a Manager,
-- automatically update the manager's Tournaments_Organized count

CREATE TRIGGER after_tournament_insert
AFTER INSERT ON Tournament_Managed
FOR EACH ROW
BEGIN
	UPDATE TournamentManager
	SET Tournaments_Organized = Tournaments_Organized + 1
	WHERE ManagerID = NEW.ManagerID;
END$$

DELIMITER ;
