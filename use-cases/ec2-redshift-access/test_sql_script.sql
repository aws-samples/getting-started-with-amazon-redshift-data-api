CREATE TABLE if not exists redshift_table ( id int identity, insert_timestamp timestamp default sysdate, data varchar(max));

insert into redshift_table(data) values('i love data api');

select * from redshift_table;
