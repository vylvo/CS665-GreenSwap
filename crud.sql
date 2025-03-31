-- Sample CRUD operations for GreenSwap: A Community Plant Exchange Database
-- CS665 Project 1, Part 2

-- CREATE OPERATIONS

-- Add a new user
INSERT INTO Users (Username, Email, PasswordHash, JoinDate, Location, ProfileDescription)
VALUES ('HerbGardener', 'herb.gardener@email.com', 'hashed_password_8', DATETIME('now'), 'Denver, CO', 'Specializing in culinary herbs');

-- Add a new plant
INSERT INTO Plants (UserID, PlantName, PlantType, Description, AgeOrStage, DateListed, Status)
VALUES (
    (SELECT UserID FROM Users WHERE Username = 'HerbGardener'),
    'Basil Plant',
    'Herb',
    'Italian large leaf basil',
    'Mature',
    DATETIME('now'),
    'Available'
);

-- Add a new plant care info
INSERT INTO PlantCareInfo (PlantTypeName, WateringFrequency, LightRequirements, SoilPreferences, DifficultyLevel, GrowthHabits, CommonIssues)
VALUES ('Herb', 'Every 2-3 days', 'Full sun', 'Nutrient-rich, well-draining soil', 1, 'Bushy growth, frequent harvesting encouraged', 'Bolting in hot temperatures, pests');

-- Create a new trade request
INSERT INTO Trades (RequestorID, ProviderID, PlantID, RequestDate, Status, TradeNotes)
VALUES (
    (SELECT UserID FROM Users WHERE Username = 'PlantLover1'),
    (SELECT UserID FROM Users WHERE Username = 'HerbGardener'),
    (SELECT PlantID FROM Plants WHERE PlantName = 'Basil Plant' AND UserID = (SELECT UserID FROM Users WHERE Username = 'HerbGardener')),
    DATETIME('now'),
    'Pending',
    'Interested in trading for herbs'
);

-- READ OPERATIONS

-- Get all available plants with user information
SELECT p.PlantID, p.PlantName, p.PlantType, p.Description, p.AgeOrStage, 
       u.Username, u.Location
FROM Plants p
JOIN Users u ON p.UserID = u.UserID
WHERE p.Status = 'Available'
ORDER BY p.DateListed DESC;

-- Get plant care information for a specific plant type
SELECT p.PlantName, p.PlantType, p.AgeOrStage,
       pci.WateringFrequency, pci.LightRequirements, pci.SoilPreferences, pci.DifficultyLevel
FROM Plants p
JOIN PlantCareInfo pci ON p.PlantType = pci.PlantTypeName
WHERE p.PlantID = 1;

-- Get all pending trade requests for a specific user
SELECT t.TradeID, t.RequestDate, t.Status,
       requester.Username AS Requester, 
       provider.Username AS Provider,
       p.PlantName, p.PlantType
FROM Trades t
JOIN Users requester ON t.RequestorID = requester.UserID
JOIN Users provider ON t.ProviderID = provider.UserID
JOIN Plants p ON t.PlantID = p.PlantID
WHERE (t.RequestorID = (SELECT UserID FROM Users WHERE Username = 'PlantLover1')
    OR t.ProviderID = (SELECT UserID FROM Users WHERE Username = 'PlantLover1'))
AND t.Status = 'Pending';

-- Find plants by location (subquery)
SELECT p.PlantID, p.PlantName, p.PlantType, p.Status, u.Username, u.Location
FROM Plants p
JOIN Users u ON p.UserID = u.UserID
WHERE u.Location IN (
    SELECT Location
    FROM Users
    WHERE Location LIKE '%WA%' OR Location LIKE '%OR%'
)
AND p.Status = 'Available';

-- Find users with the most plants available for trade
SELECT u.UserID, u.Username, u.Location, COUNT(p.PlantID) AS AvailablePlants
FROM Users u
JOIN Plants p ON u.UserID = p.UserID
WHERE p.Status = 'Available'
GROUP BY u.UserID, u.Username, u.Location
ORDER BY AvailablePlants DESC;

-- Find plant types with care difficulty level and average trade completion time
SELECT 
    pci.PlantTypeName,
    pci.DifficultyLevel,
    COUNT(t.TradeID) AS CompletedTrades,
    AVG(JULIANDAY(t.CompletionDate) - JULIANDAY(t.RequestDate)) AS AvgDaysToComplete
FROM PlantCareInfo pci
LEFT JOIN Plants p ON pci.PlantTypeName = p.PlantType
LEFT JOIN Trades t ON p.PlantID = t.PlantID AND t.Status = 'Completed'
GROUP BY pci.PlantTypeName, pci.DifficultyLevel
HAVING CompletedTrades > 0
ORDER BY AvgDaysToComplete;

-- UPDATE OPERATIONS

-- Update user profile
UPDATE Users
SET ProfileDescription = 'Urban gardener specializing in herbs and vegetables for small spaces'
WHERE Username = 'HerbGardener';

-- Update plant status
UPDATE Plants
SET Status = 'Not Available'
WHERE PlantID = 2;

-- Update trade status
UPDATE Trades
SET Status = 'Completed',
    CompletionDate = DATETIME('now')
WHERE TradeID = 2;

-- Update plant care information
UPDATE PlantCareInfo
SET WateringFrequency = 'When top inch is dry',
    CommonIssues = 'Overwatering, low humidity, spider mites'
WHERE PlantTypeName = 'Fiddle Leaf Fig';

-- DELETE OPERATIONS

-- Delete a trade request
DELETE FROM Trades
WHERE TradeID = 4;

-- Delete a plant listing
DELETE FROM Plants
WHERE PlantID = 7;

-- Delete a user and all their data (cascade will handle associated plants and trades)
DELETE FROM Users
WHERE Username = 'BonsaiMaster';

-- Delete plant care info for an obsolete plant type
DELETE FROM PlantCareInfo
WHERE PlantTypeName = 'Herb' AND NOT EXISTS (
    SELECT 1 FROM Plants WHERE PlantType = 'Herb'
);