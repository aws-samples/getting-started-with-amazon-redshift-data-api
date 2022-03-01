create or replace procedure public.sp_setup_sales_data_pipeline()
as $$
begin
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
  diststyle all;
  --
  create table if not exists public.customer_address
  (ca_address_sk    int4     not null encode az64
  ,ca_address_id    char(16) not null encode zstd
  ,ca_state         char(2)           encode zstd
  ,ca_zip           char(10)          encode zstd
  ,ca_country       varchar(20)       encode zstd
  ,primary key (ca_address_id) 
  )
  distkey(ca_address_id);
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
  ,primary key (i_item_id)
  )
  distkey(i_item_id) sortkey(i_category);
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

  insert into public.customer (c_customer_sk,c_customer_id,c_current_addr_sk,c_first_name,c_last_name)
  values
  (7550,'AAAAAAAAOHNBAAAA',9264662,'Michelle','Deaton'),
  (37079,'AAAAAAAAHNAJAAAA',13971208,'Michael','Simms'),
  (40626,'AAAAAAAACLOJAAAA',1959255,'Susan','Ryder'),
  (2142876,'AAAAAAAAMJCLACAA',7644556,'Justin','Brown');
  analyze public.customer;
  --
  insert into public.customer_address (ca_address_sk,ca_address_id,ca_state,ca_zip,ca_country)
  values
  (13971208,'AAAAAAAAIAPCFNAA','NE','63451','United States'),
  (7644556,'AAAAAAAAMIFKEHAA','SD','58883','United States'),
  (9264662,'AAAAAAAAGBOFNIAA','CA','99310','United States');
  analyze public.customer_address;
  --
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
  (2452642,'AAAAAAAACKMGFCAA','2021-06-26','Thursday'),
  (2452893,'AAAAAAAAEKMGFCAA',trunc(sysdate),trim(to_char(trunc(sysdate),'Day')));
  --
  analyze public.date_dim;
  raise info 'Setup of sales data pipeline ran successfully';
exception 
  when others then 
    raise exception '[Error while setting up sales data pipeline] Exception: %', sqlerrm;   
end;
$$ language plpgsql;


CREATE OR REPLACE PROCEDURE public.sp_load_dim_customer_address()
AS $$
begin
  /* Create a staging table to hold the input data. Staging table is created with BACKUP NO option for faster inserts and also data temporary */
  drop table if exists public.stg_customer_address;
  create table if not exists public.stg_customer_address
  (ca_address_id    varchar(16)  encode zstd
  ,ca_state         varchar(2)   encode zstd
  ,ca_zip           varchar(10)  encode zstd
  ,ca_country       varchar(20)  encode zstd
  )
  backup no
  distkey(ca_address_id);
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
--  commit; 
  --
  raise info 'sp_load_dim_customer_address ran successfully';  
exception 
  when others then 
    raise exception '[Error while running sp_load_dim_customer_address] Exception: %', sqlerrm; 
end;
$$ language plpgsql;


CREATE OR REPLACE PROCEDURE public.sp_load_dim_item()
AS $$
begin
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
  distkey(i_item_id);
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
  --
  raise info 'sp_load_dim_customer_address ran successfully';   
exception 
  when others then 
    raise exception '[Error while running sp_load_dim_item] Exception: %', sqlerrm; 
end;
$$ language plpgsql;


create or replace procedure public.sp_load_fact_sales (p_run_date date)
as $$
declare
  v_total_sales bigint;
begin
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
  (p_run_date,'AAAAAAAAIFNAAAAA','AAAAAAAAOHNBAAAA','AAAAAAAAGBOFNIAA',1403191,13,5046.37,150.97),
  (p_run_date,'AAAAAAAAIFNAAAAA','AAAAAAAAOHNBAAAA','AAAAAAAAGBOFNIAA',1403191,13,2103.72,-124.08),
  (p_run_date,'AAAAAAAAILOBAAAA','AAAAAAAAOHNBAAAA','AAAAAAAAGBOFNIAA',1403191,13,959.10,-1304.70),
  (p_run_date,'AAAAAAAAILOBAAAA','AAAAAAAAHNAJAAAA','AAAAAAAAIAPCFNAA',1403191,13,962.65,-475.80),
  (p_run_date,'AAAAAAAAMCOAAAAA','AAAAAAAAHNAJAAAA','AAAAAAAAIAPCFNAA',1201746,17,111.60,-241.65),
  (p_run_date,'AAAAAAAAMCOAAAAA','AAAAAAAAHNAJAAAA','AAAAAAAAIAPCFNAA',1201746,17,4013.02,-1111.48),
  (p_run_date,'AAAAAAAAMCOAAAAA','AAAAAAAAMJCLACAA','AAAAAAAAMIFKEHAA',1201746,17,2689.12,-5572.28),
  (p_run_date,'AAAAAAAAMGOAAAAA','AAAAAAAAMJCLACAA','AAAAAAAAMIFKEHAA',193971,18,1876.89,-556.35);
  /* Delete any rows from target store_sales for the input date for idempotency */
  delete from public.store_sales where ss_sold_date_sk in (select d_date_sk from public.date_dim where d_date=p_run_date);
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
exception 
  when others then 
    raise exception '[Error while running sp_load_fact_sales] Exception: %', sqlerrm; 
end;
$$ language plpgsql;