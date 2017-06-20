START TRANSACTION ;

drop table seats ;
drop table aircrafts ;

update technical.version set
        cur_version = 2,
        applied     = CURRENT_TIMESTAMP ;

ROLLBACK TRANSACTION ;
--COMMIT TRANSACTION ;
