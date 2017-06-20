START TRANSACTION ;

create sequence pass_no_seq ;

create table boarding_pass ( 
	pass_no   integer       not null default nextval('pass_no_seq'),
	seat_no   varchar(4)    not null references seats(seat_no), 
	flight_id integer       not null references tickets_flights(flight_id), -- из какой таблицы тянуть
	ticket_no ticket_number not null references tickets_flights(ticket_no),
	gate_no   varchar(3)    not null	  	
) ;

alter sequence pass_no_seq owned by boarding_pass.pass_no ;

create table booking (
    booking_no varchar(20)   not null primary key,
    booking_date timestamptz not null
) ;

alter table tickets
	add column booking_no varchar(20) not null ;
	
alter table tickets
	add constraint booking_no_fk
		foreign key ( booking_no )
		references booking( booking_no ) ;
		
update technical.version set
        cur_version = 4,
        applied     = CURRENT_TIMESTAMP ;		

ROLLBACK TRANSACTION ;
--COMMIT TRANSACTION ;
