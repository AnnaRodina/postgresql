START TRANSACTION ;

create table aircrafts (
    aircraft_code char(3)   not null primary key ,
    model         norm_text not null ,
    range         integer   not null
) ;

create table seats (
    aircraft_code char(3) not null references aircrafts(aircraft_code),
    seat_no       varchar(4) not null ,
    fare_conditions short_code not null references fares(code),
    constraint seats_pk primary key ( aircraft_code, seat_no )
) ;

update technical.version set
        cur_version = 3,
        applied     = CURRENT_TIMESTAMP ;

/*
create table seats (
    seat_id serial not null primary key ,
    aircraft_code char(3) not null references aircrafts(aircraft_code),
    seat_no       varchar(4) not null ,
    fare_conditions short_code not null references fares(code),
    constraint seats_un unique ( aircraft_code, seat_no )
) ;
*/
-- ROLLBACK TRANSACTION ;
COMMIT TRANSACTION ;
