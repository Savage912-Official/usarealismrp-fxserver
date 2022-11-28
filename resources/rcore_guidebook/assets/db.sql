create table rcore_guidebook_categories
(
    id             int auto_increment,
    label          VARCHAR(255) not null,
    `key`          VARCHAR(255) not null,
    order_number   int default 1 null,
    is_enabled     tinyint(1) default 1 null,
    default_expand tinyint(1) default 1 null,
    constraint rcore_guidebook_categories_pk
        primary key (id)
);

create unique index rcore_guidebook_categories_key_uindex
    on rcore_guidebook_categories (`key`);

create table rcore_guidebook_pages
(
    id           int auto_increment,
    label        varchar(255) not null,
    `key`        varchar(255) not null,
    category_key varchar(255) not null,
    order_number int default 1 null,
    is_enabled   tinyint(1) default 1 null,
    content      LONGTEXT null,
    constraint rcore_guidebook_pages_pk
        primary key (id)
);

create unique index rcore_guidebook_pages_key_uindex
    on rcore_guidebook_pages (`key`);

INSERT INTO rcore_guidebook_categories (label, `key`, order_number, is_enabled, default_expand)
VALUES ('Home', 'home', 1, 1, 1);

INSERT INTO rcore_guidebook_pages (label, `key`, category_key, order_number, is_enabled, content)
VALUES ('Welcome', 'welcome', 'home', 1, 1, '<h2>Welcome to this server :)</h2>
<p>This is the demo page of rcore_guidebook resource.</p>
<p>You can change all this with the administration command if you have the rights to do.<br /><br /></p>
<p>If you need any help contact us on our discord <a href="https://discord.gg/F28PfsY">https://discord.gg/F28PfsY</a></p>');

create table rcore_guidebook_points
(
    id                int auto_increment,
    `key`             varchar(50)                           not null,
    label             varchar(255) null,
    is_enabled        tinyint(1) default 1 not null,
    can_navigate      tinyint(1) default 1 not null,
    blip_sprite       varchar(255) null,
    blip_color        int null,
    blip_display_type int          default 4                null,
    blip_size              float        default 1.0              null,
    blip_enabled      tinyint(1) default 1 not null,
    marker_enabled      tinyint(1) default 1 not null,
    marker_size varchar(255) null,
    marker_draw_distance int null,
    marker_type varchar(255) null,
    marker_color varchar(255) null,
    show_date         timestamp null,
    hide_date         timestamp null,
    content           TEXT null,
    help_key          varchar(255) null,
    draw_distance     int null,
    position          varchar(255) default "vector3(0,0,0)" not null,
    size float default 1.0 null,
    color varchar(255) null,
    constraint rcore_guidebook_points_pk
        primary key (id)
);

create unique index rcore_guidebook_points_key_uindex
    on rcore_guidebook_points (`key`);

ALTER TABLE rcore_guidebook_categories CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE rcore_guidebook_pages CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE rcore_guidebook_points CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
