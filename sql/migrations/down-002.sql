START TRANSACTION ;

alter table flights drop constraint flights_departure_fk ;
alter table flights drop column departure_airport ;
alter table flights drop constraint flights_arrival_fk ;
alter table flights drop column arrival_airport ;

drop table airports ;
drop domain norm_text ;
drop domain air_code ;

update technical.version set
        cur_version = 1,
        applied     = CURRENT_TIMESTAMP ;
        
        
-- ROLLBACK TRANSACTION ;
COMMIT TRANSACTION ;
