USE smartphones;

DROP TABLE IF EXISTS brands;
CREATE TABLE brands(
	id int auto_increment,
    brand varchar(100),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS os;
CREATE TABLE os(
	id int auto_increment,
    os varchar(100),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS processor_brands;
CREATE TABLE processor_brands(
	id int auto_increment,
    brand varchar(100),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS processors;
CREATE TABLE processors(
	id int auto_increment,
    brand_id int,
    num_cores int,
    speed float,
    PRIMARY KEY (id),
    FOREIGN KEY (brand_id) REFERENCES processor_brands(id)
);

DROP TABLE IF EXISTS battery;
CREATE TABLE battery(
    id int auto_increment,
    battery_capacity int,
    fast_charging_available boolean,
    fast_charging int,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS cameras;
CREATE TABLE cameras(
    id int auto_increment,
    num_rear_cameras int,
    num_front_cameras int,
    primary_camera_rear int,
    primary_camera_front int,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS memory;
CREATE TABLE memory(
    id int auto_increment,
    ram_capacity int,
    internal_memory int,
    extended_memory_available boolean,
    extended_upto int,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS screen;
CREATE TABLE screen(
    id int auto_increment,
    screen_size float,
    resolution_width int,
    resolution_height int,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS models;
CREATE TABLE models(
	id int auto_increment,
    model varchar(100),
    brand_id int,
    price int,
    rating int,
    processor_id int,
    battery_id int,
    memory_id int,
    screen_id int,
    refresh_rate int,
    os_id int,
    camera_id int,
    
    PRIMARY KEY (id),
    FOREIGN KEY (brand_id) REFERENCES brands(id),
    FOREIGN KEY (processor_id) REFERENCES processors(id),
    FOREIGN KEY (battery_id) REFERENCES battery(id),
    FOREIGN KEY (memory_id) REFERENCES memory(id),
    FOREIGN KEY (screen_id) REFERENCES screen(id),
    FOREIGN KEY (os_id) REFERENCES os(id),
    FOREIGN KEY (camera_id) REFERENCES cameras(id)
);