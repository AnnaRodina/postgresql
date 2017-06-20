START TRANSACTION ;

drop table ticket_flights ;
drop table fares ;
drop table tickets ;
drop table flights ;
drop table flight_status ;
drop domain ticket_number ;
drop domain short_code ;

drop table technical.version ;

drop schema if exists technical ;

-- ROLLBACK TRANSACTION ;
COMMIT TRANSACTION ;
