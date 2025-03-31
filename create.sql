-- Create tables for GreenSwap: A Community Plant Exchange Database
-- CS665 Project 1, Part 2

-- Users Table
-- Functional Dependencies:
-- UserID → Username, Email, PasswordHash, JoinDate, Location, ProfileDescription
-- Username → UserID
-- Email → UserID
CREATE TABLE Users (
    UserID INTEGER PRIMARY KEY AUTOINCREMENT,
    Username TEXT UNIQUE NOT NULL,
    Email TEXT UNIQUE NOT NULL,
    PasswordHash TEXT NOT NULL,
    JoinDate DATETIME NOT NULL,
    Location TEXT NOT NULL,
    ProfileDescription TEXT
);

-- Plants Table
-- Functional Dependencies:
-- PlantID → UserID, PlantName, PlantType, Description, AgeOrStage, DateListed, Status
-- PlantID, UserID → PlantName, PlantType, Description, AgeOrStage, DateListed, Status
CREATE TABLE Plants (
    PlantID INTEGER PRIMARY KEY AUTOINCREMENT,
    UserID INTEGER NOT NULL,
    PlantName TEXT NOT NULL,
    PlantType TEXT NOT NULL,
    Description TEXT,
    AgeOrStage TEXT,
    DateListed DATETIME NOT NULL,
    Status TEXT NOT NULL DEFAULT 'Available',
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- Trades Table
-- Functional Dependencies:
-- TradeID → RequestorID, ProviderID, PlantID, RequestDate, Status, CompletionDate, TradeNotes
-- RequestorID, ProviderID, PlantID, RequestDate → TradeID
CREATE TABLE Trades (
    TradeID INTEGER PRIMARY KEY AUTOINCREMENT,
    RequestorID INTEGER NOT NULL,
    ProviderID INTEGER NOT NULL,
    PlantID INTEGER NOT NULL,
    RequestDate DATETIME NOT NULL,
    Status TEXT NOT NULL DEFAULT 'Pending',
    CompletionDate DATETIME,
    TradeNotes TEXT,
    FOREIGN KEY (RequestorID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ProviderID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (PlantID) REFERENCES Plants(PlantID) ON DELETE CASCADE
);

-- PlantCareInfo Table
-- Functional Dependencies:
-- InfoID → PlantTypeName, WateringFrequency, LightRequirements, SoilPreferences, DifficultyLevel, GrowthHabits, CommonIssues
-- PlantTypeName → InfoID, WateringFrequency, LightRequirements, SoilPreferences, DifficultyLevel, GrowthHabits, CommonIssues
CREATE TABLE PlantCareInfo (
    InfoID INTEGER PRIMARY KEY AUTOINCREMENT,
    PlantTypeName TEXT UNIQUE NOT NULL,
    WateringFrequency TEXT NOT NULL,
    LightRequirements TEXT NOT NULL,
    SoilPreferences TEXT,
    DifficultyLevel INTEGER NOT NULL,
    GrowthHabits TEXT,
    CommonIssues TEXT
);

-- Create trigger to update plant status when traded
CREATE TRIGGER update_plant_status_after_trade
AFTER UPDATE ON Trades
WHEN NEW.Status = 'Completed'
BEGIN
    UPDATE Plants
    SET Status = 'Traded'
    WHERE PlantID = NEW.PlantID;
END;