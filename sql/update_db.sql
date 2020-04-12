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
create table vacance (
    vacance_id serial primary key,
    vacance_infoPlanning_id integer not null,
    vacance_start_date date not null,
    vacance_end_date date not null,
    constraint vacance_infoPlanning_id_fkey foreign key (vacance_infoPlanning_id)
    	       references infoPlanning (infoPlanning_id) match simple
	       on update no action on delete cascade
      ) ;

