select 1/count(1) from public.store_sales where ss_sold_date_sk in (select d_date_sk from public.date_dim where d_date=trunc(sysdate));

select 1/case when count(1) > 0 then 0 else 1 end from public.store_sales where ss_quantity <=0;