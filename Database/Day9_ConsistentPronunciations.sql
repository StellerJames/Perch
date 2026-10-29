-- Day 9 (part 2): make repeated words use the same phonetic spelling everywhere,
-- and rename Screech Owl to Western Screech Owl (there are several screech owls).
-- Run after Day9_AddPronunciations.sql. Each bird is matched by latin_name, which is unique.
START TRANSACTION;

-- Common name pronunciations
-- California -> kal-ih-FOR-nyuh, Gull -> GUHL
UPDATE birds SET common_pronunciation = 'kal-ih-FOR-nyuh GUHL' WHERE latin_name = 'Larus californicus';            -- California Gull
UPDATE birds SET common_pronunciation = 'FRANK-linz GUHL' WHERE latin_name = 'Leucophaeus pipixcan';               -- Franklin's Gull
-- Goose -> GOOS
UPDATE birds SET common_pronunciation = 'KA-nuh-duh GOOS' WHERE latin_name = 'Branta canadensis';                 -- Canada Goose
-- tailed -> TAYLD, billed -> BILD (matches Broad-tailed, Green-tailed, Ring-billed)
UPDATE birds SET common_pronunciation = 'RED-TAYLD HAWK' WHERE latin_name = 'Buteo jamaicensis';                  -- Red-tailed Hawk
UPDATE birds SET common_pronunciation = 'BLAK-BILD MAG-pie' WHERE latin_name = 'Pica hudsonia';                   -- Black-billed Magpie
-- Wood -> WUD (matches Woodpecker, Wood-Pewee), Jay -> JAY
UPDATE birds SET common_pronunciation = 'WUD-howz SKRUB-JAY' WHERE latin_name = 'Aphelocoma woodhouseii';         -- Woodhouse's Scrub-Jay
-- Northern -> NOR-thern (it was missing)
UPDATE birds SET common_pronunciation = 'NOR-thern HOWS REN' WHERE latin_name = 'Troglodytes aedon';               -- Northern House Wren
-- Western -> WES-tern, plus the new name
UPDATE birds SET common_name = 'Western Screech Owl', common_pronunciation = 'WES-tern SKREECH OUL'
WHERE latin_name = 'Megascops kennicottii';                                                                        -- Western Screech Owl

-- Latin pronunciations
-- jamaicensis -> jam-ay-SEN-sis
UPDATE birds SET latin_pronunciation = 'byoo-TEE-oh jam-ay-SEN-sis' WHERE latin_name = 'Buteo jamaicensis';       -- Red-tailed Hawk
-- -rhynchos -> RING-kos (matches brachyrhynchos)
UPDATE birds SET latin_pronunciation = 'ah-nahs plah-tee-RING-kos' WHERE latin_name = 'Anas platyrhynchos';       -- Mallard
UPDATE birds SET latin_pronunciation = 'peli-kanuhs eh-rith-roh-RING-kos' WHERE latin_name = 'Pelecanus erythrorhynchos'; -- American White Pelican
-- cyano- -> sy-an-oh (matches cyanocephalus)
UPDATE birds SET latin_pronunciation = 'sy-an-oh-SIT-uh STEL-er-eye' WHERE latin_name = 'Cyanocitta stelleri';     -- Steller's Jay
-- -thlypis -> THLIP-is; Leio- -> ly-oh (fixes the "y-oh" typo)
UPDATE birds SET latin_pronunciation = 'ly-oh-THLIP-is seh-LAH-tuh' WHERE latin_name = 'Leiothlypis celata';      -- Orange-crowned Warbler

COMMIT;

-- Part 3: spellings chosen by Aza.
-- REPLACE swaps every copy of the old text for the new text, so all Northern/Western birds change together.
START TRANSACTION;
UPDATE birds SET common_pronunciation = REPLACE(common_pronunciation, 'NOR-thern', 'NOR-thurn') WHERE common_name LIKE 'Northern %';
UPDATE birds SET common_pronunciation = REPLACE(common_pronunciation, 'WES-tern', 'WEST-urn') WHERE common_name LIKE 'Western %';
UPDATE birds SET latin_pronunciation = 'lay-oh-THLIP-iss seh-LAH-tuh' WHERE latin_name = 'Leiothlypis celata';  -- Orange Crowned Warbler
COMMIT;

-- Part 4: House Sparrow was blank in the doc. HOWS and SPAR-oh match the other House/Sparrow birds.
UPDATE birds SET common_pronunciation = 'HOWS SPAR-oh', latin_pronunciation = 'PAS-er doh-MES-tih-kus' WHERE latin_name = 'Passer domesticus';  -- House Sparrow

-- Part 5: the -thlypis birds, as chosen by Aza.
START TRANSACTION;
UPDATE birds SET latin_pronunciation = 'LAY-oh-THLIP-is seh-LAH-tuh' WHERE latin_name = 'Leiothlypis celata';   -- Orange Crowned Warbler
UPDATE birds SET latin_pronunciation = 'JEE-oh-THLIP-is TOL-mee-eye' WHERE latin_name = 'Geothlypis tolmiei';   -- MacGillivray's Warbler
UPDATE birds SET latin_pronunciation = 'JEE-oh-THLIP-is TRY-kas' WHERE latin_name = 'Geothlypis trichas';       -- Common Yellowthroat
COMMIT;

-- Part 6: style clean-up. Two-part words stress both halves, every bird has a stressed syllable,
-- and the Orange-crowned Warbler gets its hyphen like the other "-crowned" birds.
START TRANSACTION;
UPDATE birds SET common_pronunciation = 'BLAK-KAPT CHIK-uh-dee' WHERE latin_name = 'Poecile atricapillus';                -- Black-capped Chickadee
UPDATE birds SET common_pronunciation = 'BLAK-CHIND HUM-ing-burd' WHERE latin_name = 'Archilochus alexandri';            -- Black-chinned Hummingbird
UPDATE birds SET common_pronunciation = 'DARK-EYED JUNG-koh' WHERE latin_name = 'Junco hyemalis';                        -- Dark-eyed Junco
UPDATE birds SET common_pronunciation = 'RED-WINGD BLAK-burd' WHERE latin_name = 'Agelaius phoeniceus';                  -- Red-winged Blackbird
UPDATE birds SET common_pronunciation = 'NOR-thurn RUF-WINGD SWOL-oh' WHERE latin_name = 'Stelgidopteryx serripennis';   -- Northern Rough-winged Swallow
UPDATE birds SET common_pronunciation = 'KIL-deer' WHERE latin_name = 'Charadrius vociferus';                            -- Killdeer
UPDATE birds SET common_pronunciation = 'WUD-hows-iz SKRUB-JAY' WHERE latin_name = 'Aphelocoma woodhouseii';             -- Woodhouse's Scrub-Jay
UPDATE birds SET common_pronunciation = 'uh-MER-ih-kin WYT PEL-ih-kuhn', latin_pronunciation = 'pel-ih-KAY-nus eh-rith-roh-RING-kos'
WHERE latin_name = 'Pelecanus erythrorhynchos';                                                                           -- American White Pelican
UPDATE birds SET latin_pronunciation = 'AH-nahs plah-tee-RING-kos' WHERE latin_name = 'Anas platyrhynchos';              -- Mallard
UPDATE birds SET common_name = 'Orange-crowned Warbler' WHERE latin_name = 'Leiothlypis celata';                         -- Orange-crowned Warbler
COMMIT;
