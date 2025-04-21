USE smartphones;

DELETE FROM brands;
DELETE FROM os;
DELETE FROM processor_brands;
DELETE FROM processors;
DELETE FROM battery;
DELETE FROM memory;
DELETE FROM screen;
DELETE FROM cameras;
DELETE FROM models;

INSERT INTO brands (brand)
    SELECT DISTINCT brand_name
    FROM denormalised;

INSERT INTO os (os)
    SELECT DISTINCT os
    FROM denormalised;

INSERT INTO processor_brands (brand)
    SELECT DISTINCT processor_brand
    FROM denormalised;

INSERT INTO processors (brand_id, num_cores, speed)
    SELECT processor_brands.id, NULLIF(num_cores, ''), NULLIF(processor_speed, '')
    FROM denormalised
    INNER JOIN processor_brands
    ON denormalised.processor_brand = processor_brands.brand;

INSERT INTO battery (battery_capacity, fast_charging_available, fast_charging)
    SELECT NULLIF(battery_capacity, ''), fast_charging_available, NULLIF(fast_charging, '')
    FROM denormalised;

INSERT INTO memory (ram_capacity, internal_memory, extended_memory_available, extended_upto)
    SELECT ram_capacity, internal_memory, extended_memory_available, NULLIF(extended_upto, '')
    FROM denormalised;

INSERT INTO screen (screen_size, resolution_width, resolution_height)
    SELECT screen_size, resolution_width, resolution_height
    FROM denormalised;

INSERT INTO cameras (num_rear_cameras, num_front_cameras, primary_camera_rear, primary_camera_front)
    SELECT num_rear_cameras, NULLIF(num_front_cameras, ''), primary_camera_rear, NULLIF(primary_camera_front, '')
    FROM denormalised;

INSERT INTO models (model, brand_id, price, rating, processor_id, battery_id, memory_id, screen_id, refresh_rate, os_id, camera_id)
    SELECT d.model, b.id, d.price, NULLIF(d.rating, ''), p.id, ba.id, m.id, s.id, d.refresh_rate, o.id, c.id
    FROM denormalised d
    INNER JOIN brands b
    ON d.brand_name = b.brand
    INNER JOIN processors p
    ON d.id = p.id
    INNER JOIN battery ba
    ON d.id = ba.id
    INNER JOIN memory m
    ON d.id = m.id
    INNER JOIN screen s
    ON d.id = s.id
    INNER JOIN cameras c
    ON d.id = c.id
    INNER JOIN os o
    ON d.os = o.os;