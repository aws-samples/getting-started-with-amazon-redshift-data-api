begin transaction;
/* Create a staging table to hold the input data. Staging table is created with BACKUP NO option for faster inserts and also data temporary */
drop table if exists public.stg_customer_address;
create table if not exists public.stg_customer_address
(ca_address_id    varchar(16)  encode zstd
,ca_state         varchar(2)   encode zstd
,ca_zip           varchar(10)  encode zstd
,ca_country       varchar(20)  encode zstd
)
backup no
diststyle even;
/* Ingest data from source */
insert into public.stg_customer_address (ca_address_id,ca_state,ca_zip,ca_country)
values
('AAAAAAAACFBBAAAA','NE','','United States'),
('AAAAAAAAGAEFAAAA','NE','61749','United States'),
('AAAAAAAAPJKKAAAA','OK','','United States'),
('AAAAAAAAMIHGAAAA','AL','','United States');
/* Perform UPDATE for existing data with refreshed attribute values */
update public.customer_address
   set ca_state = stg_customer_address.ca_state,
       ca_zip = stg_customer_address.ca_zip,
       ca_country = stg_customer_address.ca_country
  from public.stg_customer_address
 where customer_address.ca_address_id = stg_customer_address.ca_address_id;
/* Perform insert for new rows  */
insert into public.customer_address
(ca_address_sk
,ca_address_id
,ca_state
,ca_zip
,ca_country
)
with max_customer_address_sk as
(select max(ca_address_sk) max_ca_address_sk
from public.customer_address)
select row_number() over (order by stg_customer_address.ca_address_id) + max_customer_address_sk.max_ca_address_sk as ca_address_sk
,stg_customer_address.ca_address_id
,stg_customer_address.ca_state
,stg_customer_address.ca_zip
,stg_customer_address.ca_country
from public.stg_customer_address,
max_customer_address_sk
where stg_customer_address.ca_address_id not in (select customer_address.ca_address_id from public.customer_address);
/* Commit and End transaction */
commit;
end transaction;

begin transaction;
/* Create a staging table to hold the input data. Staging table is created with BACKUP NO option for faster inserts and also data temporary */
drop table if exists public.stg_item;
create table if not exists public.stg_item
(i_item_id        varchar(16) encode zstd
,i_rec_start_date date encode zstd
,i_rec_end_date   date encode zstd
,i_current_price  numeric(7,2) encode zstd
,i_category       varchar(50) encode zstd
,i_product_name   varchar(50) encode zstd
)
backup no
diststyle even;
/* Ingest data from source */
insert into public.stg_item
(i_item_id,i_rec_start_date,i_rec_end_date,i_current_price,i_category,i_product_name)
values
('AAAAAAAAIFNAAAAA','2021-04-27',NULL,15.10,'Electronics','ationoughtesepri'),
('AAAAAAAAOIFCAAAA','2021-04-27',NULL,9.96,'Home','antioughtcallyn st'),
('AAAAAAAAMGOAAAAA','2021-06-26',NULL,2.25,'Men','prin stcallypri'),
('AAAAAAAAIHAEAAAA','2021-03-14',NULL,3.85,'Home','callybaranticallyought'),
('AAAAAAAAMCOAAAAA','2021-03-14',NULL,2.95,'Electronics','barprically'),
('AAAAAAAAILOBAAAA','2021-03-14',NULL,12.60,'Jewelry','callycallyeingation');
/************************************************************************************************************************
** Type 2 is maintained for i_current_price column.
** Update all attributes for the item when the price is not changed
** Sunset existing active item record with current i_rec_end_date and insert a new record when the price does not match
*************************************************************************************************************************/
update public.item
   set i_category = stg_item.i_category,
       i_product_name = stg_item.i_product_name
  from public.stg_item
 where item.i_item_id = stg_item.i_item_id
   and item.i_rec_end_date is null
   and item.i_current_price = stg_item.i_current_price;
insert into public.item
(i_item_sk
,i_item_id
,i_rec_start_date
,i_rec_end_date
,i_current_price
,i_category
,i_product_name
)
with max_item_sk as
(select max(i_item_sk) max_item_sk
   from public.item)
select row_number() over (order by stg_item.i_item_id) + max_item_sk as i_item_sk
      ,stg_item.i_item_id
      ,trunc(sysdate) as i_rec_start_date
      ,null as i_rec_end_date
      ,stg_item.i_current_price
      ,stg_item.i_category
      ,stg_item.i_product_name
  from public.stg_item, public.item, max_item_sk
 where item.i_item_id = stg_item.i_item_id
   and item.i_rec_end_date is null
   and item.i_current_price <> stg_item.i_current_price;
/* Sunset penultimate records that were inserted as type 2 */
update public.item
   set i_rec_end_date = trunc(sysdate)
  from public.stg_item
 where item.i_item_id = stg_item.i_item_id
   and item.i_rec_end_date is null
   and item.i_current_price <> stg_item.i_current_price;
/* Commit and End transaction */
commit;
end transaction;

begin transaction;
/* Create a stg_store_sales staging table */
drop table if exists public.stg_store_sales;
create table public.stg_store_sales
(sold_date             date encode zstd
,i_item_id             varchar(16) encode zstd
,c_customer_id         varchar(16) encode zstd
,ca_address_id         varchar(16) encode zstd
,ss_ticket_number      integer encode zstd
,ss_quantity           integer encode zstd
,ss_net_paid           numeric(7,2) encode zstd
,ss_net_profit         numeric(7,2) encode zstd
)
backup no
diststyle even;
/* Ingest data from source */
insert into public.stg_store_sales
(sold_date,i_item_id,c_customer_id,ca_address_id,ss_ticket_number,ss_quantity,ss_net_paid,ss_net_profit)
values
('2021-06-26','AAAAAAAAIFNAAAAA','AAAAAAAAOHNBAAAA','AAAAAAAAGBOFNIAA',1403191,13,5046.37,150.97),
('2021-06-26','AAAAAAAAIFNAAAAA','AAAAAAAAOHNBAAAA','AAAAAAAAGBOFNIAA',1403191,13,2103.72,-124.08),
('2021-06-26','AAAAAAAAILOBAAAA','AAAAAAAAOHNBAAAA','AAAAAAAAGBOFNIAA',1403191,13,959.10,-1304.70),
('2021-06-26','AAAAAAAAILOBAAAA','AAAAAAAAHNAJAAAA','AAAAAAAAIAPCFNAA',1403191,13,962.65,-475.80),
('2021-06-26','AAAAAAAAMCOAAAAA','AAAAAAAAHNAJAAAA','AAAAAAAAIAPCFNAA',1201746,17,111.60,-241.65),
('2021-06-26','AAAAAAAAMCOAAAAA','AAAAAAAAHNAJAAAA','AAAAAAAAIAPCFNAA',1201746,17,4013.02,-1111.48),
('2021-06-26','AAAAAAAAMCOAAAAA','AAAAAAAAMJCLACAA','AAAAAAAAMIFKEHAA',1201746,17,2689.12,-5572.28),
('2021-06-26','AAAAAAAAMGOAAAAA','AAAAAAAAMJCLACAA','AAAAAAAAMIFKEHAA',193971,18,1876.89,-556.35);
/* Delete any rows from target store_sales for the input date for idempotency */
delete from public.store_sales where ss_sold_date_sk in (select d_date_sk from public.date_dim where d_date='{job_run_date}');
/* Insert data from staging table to the target table */
insert into public.store_sales
(ss_sold_date_sk
,ss_item_sk
,ss_customer_sk
,ss_addr_sk
,ss_ticket_number
,ss_quantity
,ss_net_paid
,ss_net_profit
)
select date_dim.d_date_sk ss_sold_date_sk
      ,item.i_item_sk ss_item_sk
      ,customer.c_customer_sk ss_customer_sk
      ,customer_address.ca_address_sk ss_addr_sk
      ,ss_ticket_number
      ,ss_quantity
      ,ss_net_paid
      ,ss_net_profit
  from public.stg_store_sales as store_sales
  inner join public.date_dim on store_sales.sold_date = date_dim.d_date
  left join public.item on store_sales.i_item_id = item.i_item_id and item.i_rec_end_date is null
  left join public.customer on store_sales.c_customer_id = customer.c_customer_id
  left join public.customer_address on store_sales.ca_address_id = customer_address.ca_address_id;
/* Drop staging table */
drop table if exists public.stg_store_sales;
/* Commit and End transaction */
commit;
end transaction;

select 1/count(1) from public.store_sales where ss_sold_date_sk in (select d_date_sk from public.date_dim where d_date='{job_run_date}');