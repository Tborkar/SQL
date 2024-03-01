select * from ev_data_norm;

UPDATE ev_data_norm
SET TopSpeed = CAST(REPLACE(TopSpeed, ' km/h', '') AS SIGNED);

UPDATE ev_data_norm
SET Accel = CAST(CAST(REPLACE(Accel, ' sec', '') AS DECIMAL(10,1)) AS SIGNED);

UPDATE ev_data_norm
SET Efficiency = cast(replace(Efficiency, ' Wh/km','') as unsigned);

UPDATE ev_data_norm
SET FastCharge = CAST(NULLIF(REPLACE(REPLACE(FastCharge, ' km/h', ''), '-', ''), '') AS SIGNED);

update ev_data_norm
SET RapidCharge =
	case when RapidCharge = "Rapid charging possible" then "Yes"
    else "No"
    end;
    
select distinct(PowerTrain) from ev_data_norm;
update ev_data_norm
set PowerTrain =
	case when PowerTrain = "All Wheel Drive" then "AWD"
		 when PowerTrain = "Rear Wheel Drive" then "RWD"
    else "FWD"
    end;

update ev_data_norm
set PriceEuro = PriceEuro * 90 ;

alter table ev_data_norm rename column PriceEuro to PriceRupees;


