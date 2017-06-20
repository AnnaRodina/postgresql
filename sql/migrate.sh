#!/bin/bash

HOST=localhost
DBNAME=flights
USER=dbadmin

psql $DBNAME -h $HOST -U $USER -f migrations/$1-$2.sql
