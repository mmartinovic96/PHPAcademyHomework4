drop schema videoteka;

create database videoteka character set UTF8Mb4 COLLATE utf8mb4_unicode_ci;

use videoteka;

/* kreiranje tablica, many to one filmovi>zanrovi,
   many to many korisnici->korisnici_gradovi->gradovi.*/

create table zanrovi(
                        id int not null primary key auto_increment,
                        zanr_name varchar(255)
);

create table filmovi(
                        id int not null primary key auto_increment,
                        movie_name varchar(255),
                        zanr int,
                        foreign key filmovi(zanr) references zanrovi(id)
);

create table korisnici(
                          id  int not null primary key auto_increment,
                          first_name varchar(255),
                          last_name varchar(255),
                          trenutni_film int,
                          vrijeme_podizanja datetime,
                          foreign key korisnici(trenutni_film) references filmovi(id)

);

create table gradovi(
                        id int not null primary key auto_increment,
                        city_name varchar(255),
                        street_name varchar(255)
);

create table korisnici_gradovi(
                                  id int not null primary key auto_increment,
                                  korisnik int,
                                  grad_ulica int,
                                  sveukupno_filmovi tinyint(255), /*do sada posudjeni, sveukupno*/
                                  foreign key korisnici_gradovi(korisnik) references korisnici(id),
                                  foreign key (grad_ulica) references gradovi(id)
);

insert into zanrovi (zanr_name)
VALUES ('Akcija'),
       ('Drama'),
       ('Komedija'),
       ('Romantika'),
       ('Horror'),
       ('Avantura'),
       ('Triler');

insert into filmovi (movie_name, zanr)
VALUES ('Terminator', 1),
       ('Conjuring', 5),
       ('Titanik', 4),
       ('Indiana Jones', 6),
       ('Taken', 1),
       ('Parada', 3),
       ('Friday 13th', 5),
       ('Fight club', 2);

insert into korisnici (first_name, last_name, trenutni_film, vrijeme_podizanja)
VALUES ('Ivan','Marinov', 6,'2020-03-02 11:10:09'),
       ('Marko','Horvat', 2,'2020-04-11 15:15:09'),
       ('Ivan','Kovačević', 1,'2020-06-02 10:35:45'),
       ('Ivana','Babić', 3,'2020-05-12 09:55:19'),
       ('Ana','Marić', 7,'2020-03-21 14:22:22'),
       ('Filip','Jurić', 7,'2020-01-25 08:10:39'),
       ('Mateo','Novak', 3,'2020-03-02 13:06:51'),
       ('Franjo','Knežević', 5,'2019-12-17 13:11:25'),
       ('Javorka','Kovačić', 4,'2020-04-30 16:15:40'),
       ('Slađana','Vuković', 7,'2020-03-02 12:15:50');

insert into gradovi(city_name, street_name)
VALUES ('Osijek','Divaltova 23'),
       ('Osijek','Vukovarska 46'),
       ('Zagreb','Slavonska 127'),
       ('Osijek','Školska 12'),
       ('Osijek','Drinska 18'),
       ('Osijek','Županijska 220');

insert into korisnici_gradovi(korisnik, grad_ulica, sveukupno_filmovi)
VALUES (1,1,2),
       (2,1,5),
       (3,3,3),
       (4,2,3),
       (5,4,7),
       (6,3,4),
       (7,5,1),
       (8,5,1),
       (9,3,4),
       (10,4,6),
       (3,1,10),
       (4,4,6),
       (7,1,5),
       (8,1,9),
       (3,3,2),
       (6,3,2),
       (8,2,1),
       (8,1,2),
       (1,2,6),
       (9,3,4),
       (9,3,8),
       (10,1,6),
       (2,5,7),
       (8,5,0);

create trigger ubaci_nesto after insert on filmovi for each row
    begin  if new.zanr is NULL then
    insert into zanrovi (zanr_name) VALUES ('Unesite novi zanr filma');
    end if;
    end;

insert into filmovi (movie_name, zanr) value ('Frozen',null) ;


delete from zanrovi where id=7 ;

select * from zanrovi;

update filmovi set movie_name='Limitless' where movie_name='Fight club';

select * from filmovi;

select movie_name,zanr_name from filmovi inner join zanrovi where filmovi.zanr=zanrovi.id;

/* sljedeci select ce nam pokazati koliko imamo kojih vrsta zanrova*/

select zanr_name, COUNT(zanr) as broj_istih_zanrova from zanrovi z
                                                             left join filmovi f on z.id = f.zanr
GROUP BY zanr_name ORDER BY broj_istih_zanrova  desc;

update gradovi set street_name='Bosutska 7' where street_name='Županijska 220';

select CONCAT(city_name,', ',street_name) as city_street from gradovi;

/* sljedeci select ce nam pokazati koliko korisnici imaju posudjenih filmova i u kojoj poslovnici*/

select CONCAT(first_name,' ',last_name) as full_name,
       CONCAT(city_name,', ',street_name) as city_street ,sveukupno_filmovi
from korisnici inner join korisnici_gradovi inner join gradovi
where gradovi.id = grad_ulica and korisnik= korisnici.id ORDER BY full_name;

delete from korisnici_gradovi where sveukupno_filmovi > 9;

/* ponovno isti select da bi provjerili dali nam se izbrisao podatak o korisniku,
   koji je digao vise od 9 filmova, drugaciji raspored*/

select CONCAT(first_name,' ',last_name) as full_name,
       CONCAT(city_name,', ',street_name) as city_street ,sveukupno_filmovi
from korisnici inner join korisnici_gradovi inner join gradovi
where gradovi.id = grad_ulica and korisnik= korisnici.id ORDER BY sveukupno_filmovi desc;

/* prosjek podizanja filmova*/

select AVG(sveukupno_filmovi) from korisnici_gradovi;

/* sveukupno podignutih filmova svih korisnika*/

select SUM(sveukupno_filmovi) as dignuti_filmovi from korisnici_gradovi;

/* u kojem mjesecu su zadnji puta podignuli film */

select CONCAT(first_name,' ',last_name) as full_name, MONTHNAME(vrijeme_podizanja) from korisnici;

delete from korisnici_gradovi where sveukupno_filmovi=0;

update korisnici_gradovi set sveukupno_filmovi=1 where sveukupno_filmovi=5;

select CONCAT(first_name,' ',last_name) as full_name,movie_name,vrijeme_podizanja
from korisnici inner join filmovi f on korisnici.trenutni_film = f.id;

update korisnici set vrijeme_podizanja= '2020-04-04 22:30:45' where first_name='Mateo';

update filmovi set movie_name = 'Notebook' where zanr=4;

delete from filmovi where movie_name='Limitless';

select * from korisnici;

update korisnici set trenutni_film = 6 where last_name='Kovačević';

delete from filmovi where id=1;

/*lista nakon svih izmjena*/

select CONCAT(first_name,' ',last_name) as full_name,vrijeme_podizanja,movie_name,zanr_name
from korisnici inner join filmovi f on korisnici.trenutni_film = f.id
               inner join zanrovi z on f.zanr = z.id;

/*prikaz svih foreign keyeva*/

select * from information_schema.TABLE_CONSTRAINTS
where TABLE_SCHEMA = 'videoteka' and constraint_type = 'foreign key';














