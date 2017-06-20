START TRANSACTION ;

-- Тут проверить, чтобы текущая версия была равна 1

create domain air_code as char(3)
    check ( VALUE !~ '\s' ) ;

create domain norm_text as text
    check ( VALUE != '' and VALUE !~ '^\s' and VALUE !~ '\s$' and VALUE !~ '\s\s' ) ;
    
create table airports (
    airport_code air_code  not null primary key ,
    airport_name text      not null check( airport_name != '' ),
    city         norm_text ,
    timezone     text      ,
    location     geometry(POINT,4326)
) ;

alter table flights 
    add column arrival_airport air_code not null ;

alter table flights
    add constraint flights_arrival_fk
        foreign key ( arrival_airport )
        references airports( airport_code ) ;
    
alter table flights
    add column departure_airport air_code not null ;

alter table flights
    add constraint flights_departure_fk
        foreign key ( departure_airport )
        references airports( airport_code ) ;

update technical.version set
        cur_version = 2,
        applied     = CURRENT_TIMESTAMP ;
        
        
-- ROLLBACK TRANSACTION ;
COMMIT TRANSACTION ;
