drop database if exists paladins;
create database paladins;
use paladins;

drop table if exists users;
create table users(
	id serial primary key,
	nickname varchar(20),
	email varchar(255) unique,
	password_hash char(20),
	is_banned boolean default false,
    index (nickname),
	index (email)
);



drop table if exists modes;
create table modes(
    id int unsigned not null primary key,
    name varchar(20)
);

drop table if exists maps;
create table maps(
    id int unsigned not null primary key,
    name varchar(25)
);

drop table if exists game_types;
create table game_types(
    id int unsigned not null primary key,
    name varchar(20)
);

drop table if exists champions;
create table champions(
    id int unsigned not null primary key,
    name varchar(20),
    class enum('Front Line','Damage','Support','Flank')
);

drop table if exists matches;
create table matches(
    id serial primary key,
    blue_win boolean,
    duration time,
    map_id int references maps(id),
    mode_id int references modes(id),
    game_type_id int references game_types(id),
    chat text
);

drop table if exists users_matches;
create table users_matches(
  primary key (match_id,user_id),
  match_id bigint references matches(id),
  user_id bigint references users(id),
  champion_id int references champions(id),
  team enum('Red','Blue'),
  kills tinyint,
  deaths tinyint,
  assists tinyint,
  credits int,
  objective_time int,
  damage int,
  shielding int,
  healing int,
  maximum_kill_streak int,
  party_id int,
  party_size int
);


drop table if exists reports;
create table reports(
    id serial primary key,
    type enum('Cheating','Griefing','Intentional Feeding','Other','Good skill','Nice teammate','Leadership'),
    initiator_id bigint references users(id),
    target_id bigint references users(id),
    match_id bigint references matches(id),
    body text,
    index(initiator_id),
    index(target_id)
);



drop table if exists `profiles`;
create table `profiles`(
    user_id serial primary key,
    photo_id bigint unsigned null,
    created_at datetime default now(),
    foreign key (user_id) references users(id)
                       on update cascade
                       on delete restrict
);


drop table if exists friend_requests;
create table friend_requests (
    primary key (initiator_user_id, target_user_id),
	initiator_user_id bigint unsigned not null references users(id),
    target_user_id bigint unsigned not null references users(id),
    `status` enum('requested', 'approved', 'unfriended', 'declined'),
	requested_at datetime default now(),
	confirmed_at datetime,
	index (initiator_user_id),
    index (target_user_id)
);