--- insert 3 utilisateurs ---
insert into utilisateur (utilisateur_role, utilisateur_auth, utilisateur_password, utilisateur_prenom, utilisateur_nom) values ('user', 'user1','password','joe','dalton');
insert into utilisateur (utilisateur_role, utilisateur_auth, utilisateur_password, utilisateur_prenom, utilisateur_nom) values ('user', 'user2','password','lucky','luck');
insert into utilisateur (utilisateur_role, utilisateur_auth, utilisateur_password, utilisateur_prenom, utilisateur_nom) values ('user', 'user3','password','rantan','plan');

--- insert 2 planning régulateur ---
insert into planning  (planning_type, planning_start_date, planning_end_date)
       values ('regulateur','2020-03-02','2020-03-08');
insert into planning  (planning_type, planning_start_date, planning_end_date)
       values ('regulateur','2020-03-09','2020-03-15');

--- insert creneau planning 1 ---
    --- jour 1 ---
insert into creneau  (creneau_planning_id, creneau_type, creneau_start_datetime, creneau_end_datetime, creneau_nbPersonnes)
       values (1,'jour','2020-03-02 08:00:00','2020-03-02 18:00:00',2);
insert into creneau  (creneau_planning_id, creneau_type, creneau_start_datetime, creneau_end_datetime, creneau_nbPersonnes)
       values (1,'nuit','2020-03-02 20:00:00','2020-03-03 06:00:00',2);
    --- jour 2 ---
insert into creneau  (creneau_planning_id, creneau_type, creneau_start_datetime, creneau_end_datetime, creneau_nbPersonnes)
       values (1,'jour','2020-03-03 08:00:00','2020-03-03 18:00:00',2);
insert into creneau  (creneau_planning_id, creneau_type, creneau_start_datetime, creneau_end_datetime, creneau_nbPersonnes)
       values (1,'nuit','2020-03-03 18:00:00','2020-03-03 23:00:00',1);

--- insert creneau planning 2 ---
insert into creneau  (creneau_planning_id, creneau_type, creneau_start_datetime, creneau_end_datetime, creneau_nbPersonnes)
       values ('2','jour','2020-03-10 08:00:00','2020-03-10 18:00:00','2');
insert into creneau  (creneau_planning_id, creneau_type, creneau_start_datetime, creneau_end_datetime, creneau_nbPersonnes)
       values ('2','jour','2020-03-10 18:00:00','2020-03-11 00:00:00','1');
    --- jour 2 ---
insert into creneau  (creneau_planning_id, creneau_type, creneau_start_datetime, creneau_end_datetime, creneau_nbPersonnes)
       values ('2','jour','2020-03-11 08:00:00','2020-03-11 16:00:00','2');
insert into creneau  (creneau_planning_id, creneau_type, creneau_start_datetime, creneau_end_datetime, creneau_nbPersonnes)
       values ('2','jour','2020-03-11 20:00:00','2020-03-12 08:00:00','2');

--- insert infoPlanning for 3 utilisateurs ---
    --- for planning 1 ---
insert into infoPlanning (infoPlanning_utilisateur_id, infoPlanning_planning_id, infoPlanning_souhait_jour, infoPlanning_souhait_nuit, infoPlanning_souhait_soiree, infoPlanning_souhait_nuitCourte)
       values ('1', '1', '3', '3', '0', '0');
insert into infoPlanning (infoPlanning_utilisateur_id, infoPlanning_planning_id, infoPlanning_souhait_jour, infoPlanning_souhait_nuit, infoPlanning_souhait_soiree, infoPlanning_souhait_nuitCourte)
       values ('2', '1', '2', '0', '0', '0');
insert into infoPlanning (infoPlanning_utilisateur_id, infoPlanning_planning_id, infoPlanning_souhait_jour, infoPlanning_souhait_nuit, infoPlanning_souhait_soiree, infoPlanning_souhait_nuitCourte)
       values ('3', '1', '1', '2', '0', '0');

   --- for planning 2 ---
insert into infoPlanning (infoPlanning_utilisateur_id, infoPlanning_planning_id, infoPlanning_souhait_jour, infoPlanning_souhait_nuit, infoPlanning_souhait_soiree, infoPlanning_souhait_nuitCourte)
       values ('1', '2', '2', '1', '0', '0');
insert into infoPlanning (infoPlanning_utilisateur_id, infoPlanning_planning_id, infoPlanning_souhait_jour, infoPlanning_souhait_nuit, infoPlanning_souhait_soiree, infoPlanning_souhait_nuitCourte)
       values ('2', '2', '3', '0', '0', '0');
insert into infoPlanning (infoPlanning_utilisateur_id, infoPlanning_planning_id, infoPlanning_souhait_jour, infoPlanning_souhait_nuit, infoPlanning_souhait_soiree, infoPlanning_souhait_nuitCourte, infoPlanning_start_vacances, infoplanning_end_vacances)
       values ('3', '2', '0', '3', '0', '0', '2020-03-10 00:00:00', '2020-03-10 23:59:59');

--- relational table participePlanning ---
    --- for planning 1 ---
insert into participePlanning (participePlanning_utilisateur_id, participePlanning_planning_id)
       values ('1','1');
insert into participePlanning (participePlanning_utilisateur_id, participePlanning_planning_id)
       values ('2','1');
insert into participePlanning (participePlanning_utilisateur_id, participePlanning_planning_id)
       values ('3','1');


    --- for planning 2
insert into participePlanning (participePlanning_utilisateur_id, participePlanning_planning_id)
       values ('1','2');
insert into participePlanning (participePlanning_utilisateur_id, participePlanning_planning_id)
       values ('2','2');
insert into participePlanning (participePlanning_utilisateur_id, participePlanning_planning_id)
       values ('3','2');


---------------------------------------
--- a remplir par le programme ---
---------------------------------------


--- relational tablre rempliCreneau ---
    --- for planning 1 ---
insert into rempliCreneau (rempliCreneau_creneau_id, rempliCreneau_utilisateur_id)
	   values (1,1);
insert into rempliCreneau (rempliCreneau_creneau_id, rempliCreneau_utilisateur_id)
	   values (2,2);
insert into rempliCreneau (rempliCreneau_creneau_id, rempliCreneau_utilisateur_id)
	   values (3,3);
insert into rempliCreneau (rempliCreneau_creneau_id, rempliCreneau_utilisateur_id)
	   values (4,1);

insert into rempliCreneau (rempliCreneau_creneau_id, rempliCreneau_utilisateur_id)
	   values (1,2);
insert into rempliCreneau (rempliCreneau_creneau_id, rempliCreneau_utilisateur_id)
	   values (2,3);
insert into rempliCreneau (rempliCreneau_creneau_id, rempliCreneau_utilisateur_id)
	   values (3,1);
insert into rempliCreneau (rempliCreneau_creneau_id, rempliCreneau_utilisateur_id)
	   values (4,2);

    --- for planning 2 ---

insert into rempliCreneau (rempliCreneau_creneau_id, rempliCreneau_utilisateur_id)
	   values (5,3);
insert into rempliCreneau (rempliCreneau_creneau_id, rempliCreneau_utilisateur_id)
	   values (6,1);
insert into rempliCreneau (rempliCreneau_creneau_id, rempliCreneau_utilisateur_id)
	   values (7,2);
insert into rempliCreneau (rempliCreneau_creneau_id, rempliCreneau_utilisateur_id)
	   values (8,3);

insert into rempliCreneau (rempliCreneau_creneau_id, rempliCreneau_utilisateur_id)
	   values (5,1);
insert into rempliCreneau (rempliCreneau_creneau_id, rempliCreneau_utilisateur_id)
	   values (6,2);
insert into rempliCreneau (rempliCreneau_creneau_id, rempliCreneau_utilisateur_id)
	   values (7,3);
insert into rempliCreneau (rempliCreneau_creneau_id, rempliCreneau_utilisateur_id)
	   values (8,1);
