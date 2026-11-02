-- Rename the Aquatic tile so it's clearer how it differs from Wetlands
UPDATE tiles
SET name = 'Open Water',
    description = 'Lakes, reservoirs, and rivers'
WHERE tile_id = 5;