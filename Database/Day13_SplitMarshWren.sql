-- Day 13: the Marsh Wren was split into Eastern and Western species. Utah's birds are the Western one.
-- Run after Day13_AddBirdDescriptions.sql. That script still finds this bird by its old latin_name,
-- so running this one first would leave the Marsh Wren without its new description.
START TRANSACTION;

-- Step 1: the new names and how to say them.
UPDATE birds
SET common_name = 'Western Marsh Wren',
    common_pronunciation = 'WES-tern MARSH REN',
    latin_name = 'Cistothorus paludicola',
    latin_pronunciation = 'sis-toh-THOR-us pal-yoo-DIK-uh-luh'
WHERE latin_name = 'Cistothorus palustris';

-- Step 2: the description, now mentioning the split. This bird now has its new latin_name.
UPDATE birds SET description = 'A tiny rusty-brown bird with a white eyebrow, a black-and-white streaked back, and a tail often held straight up. Sexes look alike. Find it in cattail marshes, more often heard than seen. Males sing harsh, rattling songs, with up to 150 different versions, sometimes through the night, and build several decoy nests around their territory. In 2026, scientists split the Marsh Wren into Western and Eastern species, largely because their songs and genes differ.' WHERE latin_name = 'Cistothorus paludicola';  -- Western Marsh Wren

COMMIT;

-- Step 3: check the result. Expect one row with the new names, and no rows for the old name.
SELECT common_name, common_pronunciation, latin_name, latin_pronunciation
FROM birds
WHERE latin_name IN ('Cistothorus paludicola', 'Cistothorus palustris');
