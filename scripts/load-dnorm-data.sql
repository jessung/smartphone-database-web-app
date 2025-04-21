USE smartphones;

DROP TABLE IF EXISTS denormalised;
CREATE TABLE denormalised(
    id int NOT NULL auto_increment,
	brand_name varchar(100),
    model varchar(100),
    price int,
    rating varchar(100),
    has_5g varchar(100),
    has_nfc varchar(100),
    has_ir_blaster varchar(100),
    processor_brand varchar(100),
    num_cores varchar(100),
    processor_speed varchar(100),
    battery_capacity varchar(100),
    fast_charging_available boolean,
    fast_charging varchar(100),
    ram_capacity int,
    internal_memory int,
    screen_size float,
    refresh_rate int,
    num_rear_cameras int,
    num_front_cameras varchar(100),
    os varchar(100),
    primary_camera_rear int,
    primary_camera_front varchar(100),
    extended_memory_available boolean,
    extended_upto varchar(100),
    resolution_width int,
    resolution_height int,
    PRIMARY KEY (id)
);

LOAD DATA INFILE '/home/coder/project/data/smartphones_cleaned_v6.csv'
INTO TABLE denormalised
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(brand_name,model,price,rating, has_5g, has_nfc ,has_ir_blaster,processor_brand,num_cores,processor_speed,battery_capacity,fast_charging_available,fast_charging,ram_capacity,internal_memory,screen_size,refresh_rate,num_rear_cameras,num_front_cameras,os,primary_camera_rear,primary_camera_front,extended_memory_available,extended_upto,resolution_width,resolution_height)
SET id = NULL;

UPDATE denormalised
SET os = 'other'
WHERE os = '';

UPDATE denormalised
SET processor_brand = 'other'
WHERE processor_brand = '';