-- Active: 1748170022966@@127.0.0.1@5432@conservation_db
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    region TEXT NOT NULL DEFAULT 'Unassigned'
);

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name TEXT NOT NULL,
    scientific_name TEXT NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status TEXT NOT NULL CHECK (conservation_status IN ('Endangered', 'Vulnerable', 'Historic', 'Critically Endangered', 'Least Concern'))
);

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INTEGER NOT NULL REFERENCES rangers(ranger_id),
    species_id INTEGER NOT NULL REFERENCES species(species_id),
    sighting_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    location VARCHAR(255) NOT NULL,
    notes TEXT
);

INSERT INTO rangers (ranger_id, name, region) OVERRIDING SYSTEM VALUE VALUES
(1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White', 'River Delta'),
(3, 'Carol King', 'Mountain Range');

INSERT INTO species (species_id, common_name, scientific_name, discovery_date, conservation_status) OVERRIDING SYSTEM VALUE VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');
SELECT setval('species_species_id_seq', (SELECT MAX(species_id) FROM species));


INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes) OVERRIDING SYSTEM VALUE VALUES
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);
SELECT setval('sightings_sighting_id_seq', (SELECT MAX(sighting_id) FROM sightings));


SELECT * FROM rangers;

SELECT * FROM sightings

SELECT * FROM species

-- Problem 1: Register new ranger
INSERT INTO rangers (name, region) VALUES ('Derek Fox', 'Coastal Plains');

-- Problem 2: Count unique species ever sighted
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings

-- Problem 3: Find sightings where location includes "Pass"
SELECT * FROM sightings WHERE location LIKE '%Pass%';

-- Problem 4: List each ranger's name and total sightings
SELECT r.name, COUNT(s.sighting_id) AS total_sightings
FROM rangers r
LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.ranger_id, r.name;


-- Problem 5: List species never sighted
SELECT s.common_name
FROM species s
LEFT JOIN sightings si ON s.species_id = si.species_id
WHERE si.species_id IS NULL;

-- Problem 6: Show most recent 2 sightings
SELECT sp.common_name, s.sighting_time, r.name
FROM sightings s
JOIN species sp ON s.species_id = sp.species_id
JOIN rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;

-- Problem 7: Update species discovered before 1800 to 'Historic'
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

-- Problem 8: Label time of day for sightings
SELECT sighting_id,
    CASE
        WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sighting_time) < 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings;

-- Problem 9: Delete rangers with no sightings
DELETE FROM rangers
WHERE ranger_id NOT IN (SELECT DISTINCT ranger_id FROM sightings);
