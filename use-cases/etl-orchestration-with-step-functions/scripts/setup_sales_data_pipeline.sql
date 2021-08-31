drop table if exists public.customer;
drop table if exists public.customer_address;
drop table if exists public.date_dim;
drop table if exists public.item;
drop table if exists public.store_sales;

create table if not exists public.customer
(c_customer_sk          int4     not null encode az64
,c_customer_id          char(16) not null encode zstd
,c_current_addr_sk      int4              encode az64
,c_first_name           char(20)          encode zstd
,c_last_name            char(30)          encode zstd
,primary key (c_customer_sk)
)
distkey(c_customer_sk);
--
create table if not exists public.customer_address
(ca_address_sk    int4     not null encode az64
,ca_address_id    char(16) not null encode zstd
,ca_state         char(2)           encode zstd
,ca_zip           char(10)          encode zstd
,ca_country       varchar(20)       encode zstd
,primary key (ca_address_sk)
)
distkey(ca_address_sk);
--
create table if not exists public.date_dim
(d_date_sk           integer  not null encode az64
,d_date_id           char(16) not null encode zstd
,d_date              date              encode az64
,d_day_name          char(9)           encode zstd
,primary key (d_date_sk)
)
diststyle all;
--
create table if not exists public.item
(i_item_sk        int4     not null encode az64
,i_item_id        char(16) not null encode zstd
,i_rec_start_date date              encode az64
,i_rec_end_date   date              encode az64
,i_current_price  numeric(7,2)      encode az64
,i_category       char(50)          encode zstd
,i_product_name   char(50)          encode zstd
,primary key (i_item_sk)
)
distkey(i_item_sk) sortkey(i_category);
--
create table if not exists public.store_sales
(ss_sold_date_sk       int4
,ss_item_sk            int4 not null encode az64
,ss_customer_sk        int4          encode az64
,ss_addr_sk            int4          encode az64
,ss_store_sk           int4          encode az64
,ss_ticket_number      int8 not null encode az64
,ss_quantity           int4          encode az64
,ss_net_paid           numeric(7,2)  encode az64
,ss_net_profit         numeric(7,2)  encode az64
,primary key (ss_item_sk, ss_ticket_number)
)
distkey(ss_item_sk) sortkey(ss_sold_date_sk);


begin transaction;
truncate table public.customer;
insert into public.customer (c_customer_sk,c_customer_id,c_current_addr_sk,c_first_name,c_last_name)
values
(7550,'AAAAAAAAOHNBAAAA',9264662,'Michelle','Deaton'),
(37079,'AAAAAAAAHNAJAAAA',13971208,'Michael','Simms'),
(40626,'AAAAAAAACLOJAAAA',1959255,'Susan','Ryder'),
(2142876,'AAAAAAAAMJCLACAA',7644556,'Justin','Brown');
analyze public.customer;
--
truncate table public.customer_address;
insert into public.customer_address (ca_address_sk,ca_address_id,ca_state,ca_zip,ca_country)
values
(13971208,'AAAAAAAAIAPCFNAA','NE','63451','United States'),
(7644556,'AAAAAAAAMIFKEHAA','SD','58883','United States'),
(9264662,'AAAAAAAAGBOFNIAA','CA','99310','United States');
analyze public.customer_address;
--
truncate table public.item;
insert into public.item (i_item_sk,i_item_id,i_rec_start_date,i_rec_end_date,i_current_price,i_category,i_product_name)
values
(3417,'AAAAAAAAIFNAAAAA','2021-04-27',NULL,14.29,'Electronics','ationoughtesepri'),
(9615,'AAAAAAAAOIFCAAAA','2021-04-27',NULL,9.68,'Home','antioughtcallyn st'),
(3693,'AAAAAAAAMGOAAAAA','2021-06-26',NULL,2.10,'Men','prin stcallypri'),
(3630,'AAAAAAAAMCOAAAAA','2021-03-14',NULL,2.95,'Electronics','barpricallypri'),
(16506,'AAAAAAAAIHAEAAAA','2021-03-14',NULL,3.85,'Home','callybaranticallyought'),
(7866,'AAAAAAAAILOBAAAA','2021-03-14',NULL,12.60,'Jewelry','callycallyeingation');
--
analyze public.item;
truncate table public.date_dim;
insert into public.date_dim (d_date_sk,d_date_id,d_date,d_day_name)
values
(2450521,'AAAAAAAAJFEGFCAA','2020-03-12','Thursday'),
(2450749,'AAAAAAAANDFGFCAA','2020-04-27','Monday'),
(2451251,'AAAAAAAADDHGFCAA','2020-03-13','Saturday'),
(2451252,'AAAAAAAAEDHGFCAA','2021-03-14','Sunday'),
(2451981,'AAAAAAAANAKGFCAA','2021-03-12','Monday'),
(2451982,'AAAAAAAAOAKGFCAA','2021-03-13','Tuesday'),
(2452210,'AAAAAAAACPKGFCAA','2021-04-27','Saturday'),
(2452641,'AAAAAAAABKMGFCAA','2021-06-25','Wednesday'),
(2452642,'AAAAAAAACKMGFCAA','2021-06-26','Thursday');
--
analyze public.date_dim;
--  commit and End transaction
commit;
end transaction;