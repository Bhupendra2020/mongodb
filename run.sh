#!/bin/bash


if [ ! -f /.mongodb_password_set ]; then
	/set_mongodb_password.sh
fi

if [ "$AUTH" == "yes" ]; then
    export mongodb='/usr/bin/mongod --nojournal --auth --httpinterface --rest'
else
    export mongodb='/usr/bin/mongod --nojournal --httpinterface --rest'
fi

if [ ! -f /data/db/mongod.lock ]; then
    echo "Finding mongod.lock file !!"
    eval $mongodb
else
    export mongodb=$mongodb' --dbpath /data/db' 
    rm /data/db/mongod.lock
    echo "remove mongod.lock file !!"
    mongod --dbpath /data/db --repair && eval $mongodb
fi


