SELECT *
FROM hotel_bookings
LIMIT 10

-- COUNT COLUMNS AND ROWS(FOUND THIS ONLINE BTW)
SELECT 'Columns' AS category, COUNT(*) AS count
FROM information_schema.columns
WHERE TABLE_NAME = 'hotel_bookings'
UNION ALL
SELECT 'Rows' AS category,COUNT(*) AS count
FROM hotel_bookings;



-- CONCAT AND CREATE A PROPER DATE
SELECT CAST(arrival_date_year || '-' || arrival_date_month || '-' || arrival_date_day_of_month AS DATE) as arrival_date
FROM hotel_bookings

ALTER TABLE hotel_bookings
ADD arrival_date DATE

UPDATE hotel_bookings
SET arrival_date = CAST(arrival_date_year || '-' || arrival_date_month || '-' || arrival_date_day_of_month AS DATE)


-- deleting columns we dont need after concat
ALTER TABLE hotel_bookings
DROP arrival_date_year

ALTER TABLE hotel_bookings
DROP arrival_date_month

ALTER TABLE hotel_bookings
DROP arrival_date_day_of_month

ALTER TABLE hotel_bookings
DROP arrival_date_week_number




-- FIX DATA TYPES	  
ALTER TABLE hotel_bookings
ADD companynew integer

UPDATE hotel_bookings
SET companynew = CASE
  WHEN company ='NULL' THEN NULL  -- Handle NULL values
  ELSE CAST(company AS integer)  -- Convert non-NULL values to integers
END;

ALTER TABLE hotel_bookings
DROP company


UPDATE hotel_bookings
SET children = CASE
  WHEN children ='NULL' OR children ='NA' THEN NULL 
  ELSE CAST(children AS integer) 
END;

ALTER TABLE hotel_bookings
ADD agentnew integer

UPDATE hotel_bookings
SET agentnew = CASE
  WHEN agent ='NULL' THEN NULL 
  ELSE CAST(agent AS integer) 
END;

ALTER TABLE hotel_bookings
DROP agent



-- IF COLUMNS DATA NULLS ARE MORE THAN 70% THEN WE DELETE IT

SELECT 
  CASE WHEN SUM(CASE WHEN hotel IS NULL OR hotel ='NULL' THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as hotel,
  CASE WHEN SUM(CASE WHEN is_canceled IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as is_canceled,
  CASE WHEN SUM(CASE WHEN lead_time IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as lead_time,
  CASE WHEN SUM(CASE WHEN stays_in_weekend_nights IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as stays_in_weekend_nights,
  CASE WHEN SUM(CASE WHEN stays_in_week_nights IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as stays_in_week_nights,
  CASE WHEN SUM(CASE WHEN adults IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as adults,
  CASE WHEN SUM(CASE WHEN children IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as children,
  CASE WHEN SUM(CASE WHEN babies IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as babies,
  CASE WHEN SUM(CASE WHEN meal IS NULL OR meal ='NULL' THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as meal,
  CASE WHEN SUM(CASE WHEN country IS NULL OR country ='NULL' THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as country,
  CASE WHEN SUM(CASE WHEN market_segment IS NULL OR market_segment ='NULL' THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as market_segment,
  CASE WHEN SUM(CASE WHEN distribution_channel IS NULL OR distribution_channel ='NULL' THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as distribution_channel,
  CASE WHEN SUM(CASE WHEN is_repeated_guest IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as is_repeated_guest,
  CASE WHEN SUM(CASE WHEN previous_cancellations IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as hotel,
  CASE WHEN SUM(CASE WHEN previous_bookings_not_canceled IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as previous_bookings_not_canceled,
  CASE WHEN SUM(CASE WHEN reserved_room_type IS NULL OR reserved_room_type ='NULL' THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as reserved_room_type,
  CASE WHEN SUM(CASE WHEN assigned_room_type IS NULL OR assigned_room_type ='NULL' THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as assigned_room_type,
  CASE WHEN SUM(CASE WHEN booking_changes IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as booking_changes,
  CASE WHEN SUM(CASE WHEN deposit_type IS NULL OR deposit_type ='NULL' THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as deposit_type,
  CASE WHEN SUM(CASE WHEN days_in_waiting_list IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as days_in_waiting_list,
  CASE WHEN SUM(CASE WHEN customer_type IS NULL OR customer_type ='NULL' THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as customer_type,
  CASE WHEN SUM(CASE WHEN adr IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as adr,
  CASE WHEN SUM(CASE WHEN required_car_parking_spaces IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as required_car_parking_spaces,
  CASE WHEN SUM(CASE WHEN total_of_special_requests IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as total_of_special_requests,
  CASE WHEN SUM(CASE WHEN reservation_status IS NULL OR reservation_status ='NULL' THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as reservation_status,
  CASE WHEN SUM(CASE WHEN reservation_status_date IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as reservation_status_date,
  CASE WHEN SUM(CASE WHEN arrival_date IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as arrival_date,
  CASE WHEN SUM(CASE WHEN companynew IS NULL THEN 1 ELSE 0 END) > COUNT(*) * 0.7 THEN 'kickit' ELSE 'keep it' END as companynew
FROM hotel_bookings;

-- del companynew

ALTER TABLE hotel_bookings
DROP companynew


 