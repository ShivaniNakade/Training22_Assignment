CREATE USER c##ot1
identified by root
;

GRANT create session TO c##ot1;
GRANT create table TO  c##ot1;
GRANT create view TO c##ot1;
GRANT create any trigger TO c##ot1;
GRANT create any procedure TO c##ot1;
GRANT create sequence TO c##ot1;
GRANT create synonym TO c##ot1;
GRANT ALL PRIVILEGES TO c##ot1;

GRANT CONNECT TO c##ot1;
GRANT RESOURCE TO c##ot1;
GRANT DBA TO c##ot1;

 connect c##ot1/root