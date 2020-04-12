drop table if exists utilisateur cascade ;
drop table if exists groups cascade;
drop table if exists appartient cascade;
drop table if exists planning cascade;
drop table if exists creneau cascade;
drop table if exists infoPlanning cascade;
drop table if exists vacance cascade;
drop table if exists participePlanning cascade;
drop table if exists rempliCreneau cascade;

drop type if exists user_role cascade;
drop type if exists planning_type cascade;



create type user_role as enum ('admin', 'user');

create table utilisateur (
    utilisateur_id serial primary key,
    utilisateur_role user_role not null,
    utilisateur_auth text not null,
    utilisateur_password text not null,
    utilisateur_nom varchar(60) not null,
    utilisateur_prenom varchar(60) not null,
    utilisateur_mail varchar(60),
    utilisateur_phone varchar(60)
      ) ;

create table groups (
    groups_id serial primary key,
    groups_name varchar(128),
    groups_description varchar(1024)
      ) ;

create table appartient (
    appartient_utilisateur_id integer not null,
    appartient_groups_id integer not null,
    primary key (appartient_utilisateur_id, appartient_groups_id),
    constraint appartient_utilisateur_id_fkey foreign key (appartient_utilisateur_id)
    	       references utilisateur (utilisateur_id) match simple
	       on update no action on delete cascade,
    constraint appartient_groups_id_fkey foreign key (appartient_groups_id)
    	       references groups (groups_id) match simple
	       on update no action on delete cascade
      ) ;


create type planning_type as enum ('regulateur', 'mobile', 'mmg');

create table planning (
    planning_id serial primary key,
    planning_type planning_type not null,
    planning_start_date date not null,
    planning_end_date date not null
      ) ;

create table creneau (
    creneau_id serial primary key,
    creneau_planning_id integer not null,
    creneau_type varchar(256) not null,
    creneau_start_datetime timestamp not null,
    creneau_end_datetime timestamp not null,
    creneau_nbpersonnes integer not null,
    constraint creneau_planning_id_fkey foreign key (creneau_planning_id)
    	       references planning (planning_id) match simple
	       on update no action on delete cascade
      ) ;

create table infoPlanning (
    infoPlanning_id serial primary key,
    infoPlanning_utilisateur_id integer not null,
    infoPlanning_planning_id integer not null,
    infoPlanning_souhait_jour integer,
    infoPlanning_souhait_nuit integer,
    infoPlanning_souhait_soiree integer,
    infoPlanning_souhait_nuitCourte integer,
    infoPlanning_start_vacances date,
    infoPlanning_end_vacances date,
    constraint infoPlanning_utilisateur_id_fkey foreign key (infoPlanning_utilisateur_id)
    	       references utilisateur (utilisateur_id) match simple
	       on update no action on delete cascade,
    constraint infoPlanning_planning_id_fkey foreign key (infoPlanning_planning_id)
    	       references planning (planning_id) match simple
	       on update no action on delete cascade
      ) ;

create table vacance (
    vacance_id serial primary key,
    vacance_infoPlanning_id integer not null,
    vacance_start_date date not null,
    vacance_end_date date not null,
    constraint vacance_infoPlanning_id_fkey foreign key (vacance_infoPlanning_id)
    	       references infoPlanning (infoPlanning_id) match simple
	       on update no action on delete cascade
      ) ;

create table participePlanning (
    participePlanning_utilisateur_id integer not null,
    participePlanning_planning_id integer not null,
    primary key (participePlanning_utilisateur_id, participePlanning_planning_id),
    constraint participePlanning_utilisateur_id_fkey foreign key (participePlanning_utilisateur_id)
    	       references utilisateur (utilisateur_id) match simple
	       on update no action on delete cascade,
    constraint participePlanning_planning_id_fkey foreign key (participePlanning_planning_id)
    	       references planning (planning_id) match simple
	       on update no action on delete cascade
      ) ;

create table rempliCreneau (
    rempliCreneau_utilisateur_id integer not null,
    rempliCreneau_creneau_id integer not null,
    primary key (rempliCreneau_utilisateur_id, rempliCreneau_creneau_id),
    constraint rempliCreneau_utilisateur_id_fkey foreign key (rempliCreneau_utilisateur_id)
    	       references utilisateur (utilisateur_id) match simple
	       on update no action on delete cascade,
    constraint rempliCreneau_creneau_id_fkey foreign key (rempliCreneau_creneau_id)
    	       references creneau (creneau_id) match simple
	       on update no action on delete cascade
      ) ;



