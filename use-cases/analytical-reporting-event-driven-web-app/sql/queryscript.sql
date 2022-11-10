  SELECT pickup_date as trip_date, 
         round(sum(datediff(minutes, pickup_datetime, dropoff_datetime))/60,2) total_hours, 
         round(sum(trip_distance)) total_distance, round(sum(fare_amount)) total_fare 
    FROM nyc_yellow_taxi 
   WHERE pickup_date 
 BETWEEN to_date('{}','MonthYYYY') 
     AND last_day(to_date('{}','MonthYYYY')) 
GROUP BY 1 
ORDER BY 1;