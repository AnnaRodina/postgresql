START TRANSACTION ;

create schema if not exists technical ;

create table technical.version (
    cur_version integer   not null primary key,
    applied     timestamp not null default CURRENT_TIMESTAMP
) ;

create domain short_code as varchar(20)
    check ( VALUE != '' and VALUE !~ '^\s' and VALUE !~ '\s$') ;

create domain ticket_number as char(13) ;
    
create table flight_status (
    code short_code not null primary key ,
    description text not null
) ;

insert into flight_status ( code, description )
    values ( 'Planned'  , 'Запланирован'              ),
           ( 'Scheduled', 'Доступен для бронирования' ),
           ( 'On Time'  , 'Доступен для регистрации'  ),
           ( 'Delayed'  , 'Задержан'                  ),
           ( 'Departed' , 'Вылетел'                   ),
           ( 'Arrived'  , 'Прибыл'                    ),
           ( 'Cancelled', 'Отменен'                   ) ;

create sequence flight_id_seq ;

create table flights (
    flight_id integer not null default nextval('flight_id_seq'),
    flight_no           char(6)     not null,
    scheduled_departure timestamptz not null,
    scheduled_arrival   timestamptz not null,
    status              short_code  not null default 'Planned',
    constraint flights_pk primary key ( flight_id ),
    constraint flights_no_dep_un unique ( flight_no, scheduled_departure ),
    constraint flights_good_schedule check( scheduled_arrival > scheduled_departure ),
    constraint flights_status_fk foreign key ( status ) references flight_status(code)
) ;

alter sequence flight_id_seq owned by flights.flight_id ;

create table tickets (
    ticket_no      ticket_number not null primary key ,
    passenger_name text          not null ,
    contact_data   jsonb
) ;

create table fares (
    code short_code not null primary key,
    description text not null
) ;

insert into fares ( code, description )
    values ( 'Economy' , 'Эконом'  ),
           ( 'Comfort' , 'Комфорт' ),
           ( 'Business', 'Бизнес'  ) ;

create table ticket_flights (
    flight_id       integer       not null references flights(flight_id),
    ticket_no       ticket_number not null references tickets(ticket_no),
    fare_conditions short_code    not null references fares(code),
    constraint ticket_flights_pk primary key( flight_id, ticket_no )
) ;

insert into technical.version( cur_version, applied )
    values ( 1, CURRENT_TIMESTAMP ) ;
    

-- ROLLBACK TRANSACTION ;
COMMIT TRANSACTION ;
