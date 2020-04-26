#login as Admin

mongo --port 27017 -u "admin" -p "admin" --authenticationDatabase "admin"



#Create listDatabases Role

use admin

db.createRole({ role: "listDatabases", privileges:[{resource:{cluster:true}, actions:["listDatabases"]}], roles:[]})



#Create User

use inventory

db.createUser({

        user: 'debezium',

        pwd: 'dbz',

        roles: [

            { role: "readWrite", db: "inventory" },

            { role: "read", db: "local" },

            { role: "read", db: "config" },

            { role: "listDatabases", db: "admin" },

            { role: "read", db: "admin" }

        ]

    });

exit;  



#login as User

mongo -u debezium -p dbz inventory



#Insert Data

use inventory	

db.customers.insert([

        { _id : NumberLong("1001"), first_name : 'Sally', last_name : 'Thomas', email : 'sally.thomas@acme.com' },

        { _id : NumberLong("1002"), first_name : 'George', last_name : 'Bailey', email : 'gbailey@foobar.com' },

        { _id : NumberLong("1003"), first_name : 'Edward', last_name : 'Walker', email : 'ed@walker.com' },

        { _id : NumberLong("1004"), first_name : 'Anne', last_name : 'Kretchmar', email : 'annek@noanswer.org' }

    ]);

© 2020 GitHub, Inc.
