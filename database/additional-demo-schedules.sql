-- Add 7 more train and 7 more flight demo schedules (10 total each with the 3 original samples).
-- Run this script in the Aiven SQL editor. Safe to run more than once.
SET search_path TO irct;

INSERT INTO trains (t_no,t_name,source_stn,dest_stn,dep_time,price) VALUES
('12003','Lucknow Shatabdi (Demo)','NEW DELHI','LUCKNOW','06:10',980),
('12627','Karnataka Express (Demo)','NEW DELHI','BENGALURU','20:20',1450),
('12424','Dibrugarh Rajdhani (Demo)','NEW DELHI','DIBRUGARH','16:20',2100),
('12952','Mumbai Rajdhani Return (Demo)','MUMBAI CENTRAL','NEW DELHI','17:00',1850),
('12009','Shatabdi Express (Demo)','MUMBAI CENTRAL','AHMEDABAD','06:25',850),
('12302','Howrah Rajdhani Return (Demo)','HOWRAH','NEW DELHI','16:55',1650),
('12724','Telangana Express (Demo)','NEW DELHI','HYDERABAD','16:00',1550)
ON CONFLICT (t_no) DO NOTHING;

INSERT INTO flights (f_name,source,destination,departure_time,price,seats_available)
SELECT v.f_name,v.source,v.destination,v.departure_time,v.price,v.seats_available
FROM (VALUES
 ('SkyPro Air 404 (Demo)','DELHI','HYDERABAD','07:20',4999,55),
 ('SkyPro Air 505 (Demo)','MUMBAI','DELHI','11:10',5799,42),
 ('SkyPro Air 606 (Demo)','BENGALURU','DELHI','13:35',6299,50),
 ('SkyPro Air 707 (Demo)','DELHI','KOLKATA','15:05',4599,46),
 ('SkyPro Air 808 (Demo)','CHENNAI','MUMBAI','17:40',5199,38),
 ('SkyPro Air 909 (Demo)','HYDERABAD','BENGALURU','19:15',3299,44),
 ('SkyPro Air 010 (Demo)','KOLKATA','DELHI','21:00',4899,41)
) AS v(f_name,source,destination,departure_time,price,seats_available)
WHERE NOT EXISTS (SELECT 1 FROM flights f WHERE f.f_name=v.f_name);

-- Verify seeded demo schedule counts.
SELECT COUNT(*) AS train_count FROM trains;
SELECT COUNT(*) AS flight_count FROM flights;
