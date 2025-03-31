-- Insert sample data for GreenSwap: A Community Plant Exchange Database
-- CS665 Project 1, Part 2

-- Insert Users
INSERT INTO Users (Username, Email, PasswordHash, JoinDate, Location, ProfileDescription)
VALUES 
    ('PlantLover1', 'plant.lover1@email.com', 'hashed_password_1', '2024-01-15 10:30:00', 'Seattle, WA', 'Passionate about tropical houseplants'),
    ('GreenThumb', 'green.thumb@email.com', 'hashed_password_2', '2024-01-20 14:45:00', 'Portland, OR', 'Urban gardener with a focus on edible plants'),
    ('SucculentQueen', 'succulent.queen@email.com', 'hashed_password_3', '2024-02-01 09:15:00', 'San Diego, CA', 'Collector of rare succulents and cacti'),
    ('FernFanatic', 'fern.fanatic@email.com', 'hashed_password_4', '2024-02-10 16:20:00', 'Boston, MA', 'Creating a fern-filled home jungle'),
    ('OrchidExpert', 'orchid.expert@email.com', 'hashed_password_5', '2024-02-15 11:00:00', 'Miami, FL', 'Specializing in orchid care and propagation'),
    ('BonsaiMaster', 'bonsai.master@email.com', 'hashed_password_6', '2024-03-01 13:30:00', 'Chicago, IL', 'Bonsai enthusiast with 10+ years experience'),
    ('AirPlantAddict', 'air.plant@email.com', 'hashed_password_7', '2024-03-10 10:45:00', 'Austin, TX', 'Living with air plants in every corner');

-- Insert PlantCareInfo
INSERT INTO PlantCareInfo (PlantTypeName, WateringFrequency, LightRequirements, SoilPreferences, DifficultyLevel, GrowthHabits, CommonIssues)
VALUES 
    ('Monstera Deliciosa', 'Weekly', 'Bright indirect light', 'Well-draining, rich potting mix', 2, 'Fast growing vine with fenestrated leaves', 'Overwatering, brown leaf tips'),
    ('Snake Plant', 'Every 2-3 weeks', 'Low to bright indirect light', 'Well-draining, sandy soil', 1, 'Slow upright growth', 'Root rot from overwatering'),
    ('Fiddle Leaf Fig', 'When top 2 inches dry', 'Bright indirect light', 'Well-draining, nutrient-rich soil', 4, 'Upright tree-like growth', 'Leaf drop, brown spots from inconsistent care'),
    ('Pothos', 'When top soil dry', 'Low to bright indirect light', 'Standard potting mix', 1, 'Fast growing trailing vine', 'Yellow leaves from overwatering'),
    ('ZZ Plant', 'Every 2-4 weeks', 'Low to bright indirect light', 'Well-draining soil', 1, 'Slow upright growth from rhizomes', 'Rarely has issues, can rot if overwatered'),
    ('Orchid Phalaenopsis', 'Weekly drenching', 'Bright indirect light', 'Specialized orchid mix', 3, 'Slow growing with seasonal blooms', 'Bloom drop, root rot, dehydration'),
    ('Aloe Vera', 'Every 3 weeks', 'Bright direct light', 'Cactus or succulent mix', 1, 'Forms rosettes and produces pups', 'Soft mushy leaves from overwatering'),
    ('Boston Fern', 'Keep consistently moist', 'Medium indirect light', 'Rich, moisture-retentive soil', 3, 'Arching fronds', 'Brown fronds from low humidity'),
    ('Peace Lily', 'When leaves begin to droop', 'Low to medium light', 'Rich, moisture-retentive soil', 2, 'Clumping growth with white spathes', 'Brown leaf tips, wilting');

-- Insert Plants
INSERT INTO Plants (UserID, PlantName, PlantType, Description, AgeOrStage, DateListed, Status)
VALUES 
    (1, 'Swiss Cheese Plant', 'Monstera Deliciosa', 'Healthy 2-year plant with splits', 'Mature', '2025-02-20 09:00:00', 'Available'),
    (1, 'Snake Plant Cutting', 'Snake Plant', 'Rooted cutting ready to pot', 'Young', '2025-02-25 14:30:00', 'Available'),
    (2, 'Pothos Golden Cuttings', 'Pothos', 'Three rooted cuttings with 2-3 leaves each', 'Propagated Cutting', '2025-02-15 11:20:00', 'Available'),
    (3, 'Aloe Vera Pup', 'Aloe Vera', 'Healthy offshoot from mother plant', 'Young', '2025-03-01 10:10:00', 'Available'),
    (3, 'Echeveria Elegans', 'Succulent', 'Beautiful powder blue rosette', 'Mature', '2025-03-05 15:45:00', 'Available'),
    (4, 'Boston Fern Division', 'Boston Fern', 'Division from large specimen plant', 'Young', '2025-02-10 13:15:00', 'Available'),
    (4, 'Maidenhair Fern', 'Fern', 'Delicate fern in 4" pot', 'Mature', '2025-02-12 09:30:00', 'Available'),
    (5, 'Phalaenopsis Orchid', 'Orchid Phalaenopsis', 'White flowering orchid with two spikes', 'Blooming', '2025-03-10 16:45:00', 'Available'),
    (6, 'Juniper Cutting', 'Bonsai', 'Rooted cutting ready for training', 'Young', '2025-02-28 14:00:00', 'Available'),
    (7, 'Tillandsia Ionantha', 'Air Plant', 'Cluster of 3 small air plants', 'Mature', '2025-03-01 11:30:00', 'Available');

-- Insert Trades
INSERT INTO Trades (RequestorID, ProviderID, PlantID, RequestDate, Status, CompletionDate, TradeNotes)
VALUES 
    (2, 1, 1, '2025-03-01 10:00:00', 'Completed', '2025-03-05 15:30:00', 'Traded for pothos cuttings'),
    (3, 2, 3, '2025-03-02 14:00:00', 'Pending', NULL, 'Interested in trading for a succulent'),
    (4, 3, 5, '2025-03-05 09:15:00', 'Accepted', NULL, 'Meeting on Saturday at the community garden'),
    (1, 4, 6, '2025-03-06 16:30:00', 'Declined', NULL, 'Too far for travel'),
    (5, 6, 9, '2025-03-10 13:45:00', 'Pending', NULL, 'Would trade for an orchid seedling'),
    (7, 5, 8, '2025-03-12 11:00:00', 'Accepted', NULL, 'Pickup scheduled for next week');