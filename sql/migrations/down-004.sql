START TRANSACTION ;


alter table tickets drop constraint booking_no_fk ;
alter table tickets drop column booking_no ;
drop table booking ;
drop table boarding_pass ;

update technical.version set
        cur_version = 3,
        applied     = CURRENT_TIMESTAMP ;		

ROLLBACK TRANSACTION ;
--COMMIT TRANSACTION ;
