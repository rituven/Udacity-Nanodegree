drop table FlightsDB.AircraftSummary;
create table FlightsDB.AircraftSummary
(Year INT NOT NULL,
Month INT NOT NULL,
UniqueCarrier varchar(3) NOT NULL,
TailNum varchar(20) NOT NULL,
NumFlightsPerMonth FLOAT,
TotalDistance FLOAT,
AvgDistancePerDay FLOAT,
AvgFlightsPerDay FLOAT,
TotalAirTime FLOAT,
TotalTravelTime FLOAT,
TimeOnGround FLOAT
);

insert into FlightsDB.AircraftSummary
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth)
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth
from FlightsDB.Flights_2008
group by Year, Month,  UniqueCarrier, TailNum;

insert into FlightsDB.AircraftSummary
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth)
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth
from FlightsDB.Flights_2007
group by Year, Month,  UniqueCarrier, TailNum;

insert into FlightsDB.AircraftSummary
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth)
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth
from FlightsDB.Flights_2006
group by Year, Month,  UniqueCarrier, TailNum;

insert into FlightsDB.AircraftSummary
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth)
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth
from FlightsDB.Flights_2005
group by Year, Month,  UniqueCarrier, TailNum;

insert into FlightsDB.AircraftSummary
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth)
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth
from FlightsDB.Flights_2004
group by Year, Month,  UniqueCarrier, TailNum;

insert into FlightsDB.AircraftSummary
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth)
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth
from FlightsDB.Flights_2003
group by Year, Month,  UniqueCarrier, TailNum;

insert into FlightsDB.AircraftSummary
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth)
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth
from FlightsDB.Flights_2002
group by Year, Month,  UniqueCarrier, TailNum;

insert into FlightsDB.AircraftSummary
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth)
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth
from FlightsDB.Flights_2001
group by Year, Month,  UniqueCarrier, TailNum;

insert into FlightsDB.AircraftSummary
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth)
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth
from FlightsDB.Flights_2000
group by Year, Month,  UniqueCarrier, TailNum;

drop table FlightsDB.CraftDataPerDay;
create table FlightsDB.CraftDataPerDay
(Year INT NOT NULL,
Month INT NOT NULL,
DayofMonth INT NOT NULL,
UniqueCarrier varchar(3) NOT NULL,
TailNum varchar(20) NOT NULL,
TotalFlights FLOAT,
TotalDistance FLOAT,
TotalTimeinAir FLOAT,
MaxArrTime FLOAT,
MinDepTime FLOAT,
MaxArrHrs FLOAT,
MinDepHrs FLOAT,
TotalTravelTime FLOAT);

insert into FlightsDB.CraftDataPerDay
(Year, Month, DayofMonth, UniqueCarrier, TailNum, TotalFlights, TotalDistance,
TotalTimeinAir, MaxArrTime, MinDepTime, MaxArrHrs, MinDepHrs, TotalTravelTime )
select Year, Month, DayofMonth, UniqueCarrier, TailNum,
count(*) as TotalFlights,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalTimeinAir,
(max(ArrTime) DIV 100)*60 + mod(max(ArrTime), 100) as MaxArrTime,
((min(DepTime) DIV 100)*60)+mod(min(DepTime), 100) as MinDepTime,
max(ArrTime) as MaxArrHrs,
min(DepTime) as MinDepHrs,
(((max(ArrTime) DIV 100)*60)+mod(max(ArrTime), 100)) - ((min(DepTime) DIV 100)*60 + mod(min(DepTime), 100)) as TotalTravelTime
from FlightsDB.Flights_2008
group by Year, Month,  DayofMonth, UniqueCarrier, TailNum;

insert into FlightsDB.CraftDataPerDay
(Year, Month, DayofMonth, UniqueCarrier, TailNum, TotalFlights, TotalDistance,
TotalTimeinAir, MaxArrTime, MinDepTime, MaxArrHrs, MinDepHrs, TotalTravelTime )
select Year, Month, DayofMonth, UniqueCarrier, TailNum,
count(*) as TotalFlights,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalTimeinAir,
(max(ArrTime) DIV 100)*60 + mod(max(ArrTime), 100) as MaxArrTime,
((min(DepTime) DIV 100)*60)+mod(min(DepTime), 100) as MinDepTime,
max(ArrTime) as MaxArrHrs,
min(DepTime) as MinDepHrs,
(((max(ArrTime) DIV 100)*60)+mod(max(ArrTime), 100)) - ((min(DepTime) DIV 100)*60 + mod(min(DepTime), 100)) as TotalTravelTime
from FlightsDB.Flights_2007
group by Year, Month,  DayofMonth, UniqueCarrier, TailNum;

insert into FlightsDB.CraftDataPerDay
(Year, Month, DayofMonth, UniqueCarrier, TailNum, TotalFlights, TotalDistance,
TotalTimeinAir, MaxArrTime, MinDepTime, MaxArrHrs, MinDepHrs, TotalTravelTime )
select Year, Month, DayofMonth, UniqueCarrier, TailNum,
count(*) as TotalFlights,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalTimeinAir,
(max(ArrTime) DIV 100)*60 + mod(max(ArrTime), 100) as MaxArrTime,
((min(DepTime) DIV 100)*60)+mod(min(DepTime), 100) as MinDepTime,
max(ArrTime) as MaxArrHrs,
min(DepTime) as MinDepHrs,
(((max(ArrTime) DIV 100)*60)+mod(max(ArrTime), 100)) - ((min(DepTime) DIV 100)*60 + mod(min(DepTime), 100)) as TotalTravelTime
from FlightsDB.Flights_2006
group by Year, Month,  DayofMonth, UniqueCarrier, TailNum;

insert into FlightsDB.CraftDataPerDay
(Year, Month, DayofMonth, UniqueCarrier, TailNum, TotalFlights, TotalDistance,
TotalTimeinAir, MaxArrTime, MinDepTime, MaxArrHrs, MinDepHrs, TotalTravelTime )
select Year, Month, DayofMonth, UniqueCarrier, TailNum,
count(*) as TotalFlights,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalTimeinAir,
(max(ArrTime) DIV 100)*60 + mod(max(ArrTime), 100) as MaxArrTime,
((min(DepTime) DIV 100)*60)+mod(min(DepTime), 100) as MinDepTime,
max(ArrTime) as MaxArrHrs,
min(DepTime) as MinDepHrs,
(((max(ArrTime) DIV 100)*60)+mod(max(ArrTime), 100)) - ((min(DepTime) DIV 100)*60 + mod(min(DepTime), 100)) as TotalTravelTime
from FlightsDB.Flights_2005
group by Year, Month,  DayofMonth, UniqueCarrier, TailNum;

insert into FlightsDB.CraftDataPerDay
(Year, Month, DayofMonth, UniqueCarrier, TailNum, TotalFlights, TotalDistance,
TotalTimeinAir, MaxArrTime, MinDepTime, MaxArrHrs, MinDepHrs, TotalTravelTime )
select Year, Month, DayofMonth, UniqueCarrier, TailNum,
count(*) as TotalFlights,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalTimeinAir,
(max(ArrTime) DIV 100)*60 + mod(max(ArrTime), 100) as MaxArrTime,
((min(DepTime) DIV 100)*60)+mod(min(DepTime), 100) as MinDepTime,
max(ArrTime) as MaxArrHrs,
min(DepTime) as MinDepHrs,
(((max(ArrTime) DIV 100)*60)+mod(max(ArrTime), 100)) - ((min(DepTime) DIV 100)*60 + mod(min(DepTime), 100)) as TotalTravelTime
from FlightsDB.Flights_2004
group by Year, Month,  DayofMonth, UniqueCarrier, TailNum;

insert into FlightsDB.CraftDataPerDay
(Year, Month, DayofMonth, UniqueCarrier, TailNum, TotalFlights, TotalDistance,
TotalTimeinAir, MaxArrTime, MinDepTime, MaxArrHrs, MinDepHrs, TotalTravelTime )
select Year, Month, DayofMonth, UniqueCarrier, TailNum,
count(*) as TotalFlights,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalTimeinAir,
(max(ArrTime) DIV 100)*60 + mod(max(ArrTime), 100) as MaxArrTime,
((min(DepTime) DIV 100)*60)+mod(min(DepTime), 100) as MinDepTime,
max(ArrTime) as MaxArrHrs,
min(DepTime) as MinDepHrs,
(((max(ArrTime) DIV 100)*60)+mod(max(ArrTime), 100)) - ((min(DepTime) DIV 100)*60 + mod(min(DepTime), 100)) as TotalTravelTime
from FlightsDB.Flights_2003
group by Year, Month,  DayofMonth, UniqueCarrier, TailNum;

insert into FlightsDB.CraftDataPerDay
(Year, Month, DayofMonth, UniqueCarrier, TailNum, TotalFlights, TotalDistance,
TotalTimeinAir, MaxArrTime, MinDepTime, MaxArrHrs, MinDepHrs, TotalTravelTime )
select Year, Month, DayofMonth, UniqueCarrier, TailNum,
count(*) as TotalFlights,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalTimeinAir,
(max(ArrTime) DIV 100)*60 + mod(max(ArrTime), 100) as MaxArrTime,
((min(DepTime) DIV 100)*60)+mod(min(DepTime), 100) as MinDepTime,
max(ArrTime) as MaxArrHrs,
min(DepTime) as MinDepHrs,
(((max(ArrTime) DIV 100)*60)+mod(max(ArrTime), 100)) - ((min(DepTime) DIV 100)*60 + mod(min(DepTime), 100)) as TotalTravelTime
from FlightsDB.Flights_2002
group by Year, Month,  DayofMonth, UniqueCarrier, TailNum;

insert into FlightsDB.CraftDataPerDay
(Year, Month, DayofMonth, UniqueCarrier, TailNum, TotalFlights, TotalDistance,
TotalTimeinAir, MaxArrTime, MinDepTime, MaxArrHrs, MinDepHrs, TotalTravelTime )
select Year, Month, DayofMonth, UniqueCarrier, TailNum,
count(*) as TotalFlights,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalTimeinAir,
(max(ArrTime) DIV 100)*60 + mod(max(ArrTime), 100) as MaxArrTime,
((min(DepTime) DIV 100)*60)+mod(min(DepTime), 100) as MinDepTime,
max(ArrTime) as MaxArrHrs,
min(DepTime) as MinDepHrs,
(((max(ArrTime) DIV 100)*60)+mod(max(ArrTime), 100)) - ((min(DepTime) DIV 100)*60 + mod(min(DepTime), 100)) as TotalTravelTime
from FlightsDB.Flights_2001
group by Year, Month,  DayofMonth, UniqueCarrier, TailNum;

insert into FlightsDB.CraftDataPerDay
(Year, Month, DayofMonth, UniqueCarrier, TailNum, TotalFlights, TotalDistance,
TotalTimeinAir, MaxArrTime, MinDepTime, MaxArrHrs, MinDepHrs, TotalTravelTime )
select Year, Month, DayofMonth, UniqueCarrier, TailNum,
count(*) as TotalFlights,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalTimeinAir,
(max(ArrTime) DIV 100)*60 + mod(max(ArrTime), 100) as MaxArrTime,
((min(DepTime) DIV 100)*60)+mod(min(DepTime), 100) as MinDepTime,
max(ArrTime) as MaxArrHrs,
min(DepTime) as MinDepHrs,
(((max(ArrTime) DIV 100)*60)+mod(max(ArrTime), 100)) - ((min(DepTime) DIV 100)*60 + mod(min(DepTime), 100)) as TotalTravelTime
from FlightsDB.Flights_2000
group by Year, Month,  DayofMonth, UniqueCarrier, TailNum;

delete from FlightsDB.CraftDataPerDay
where TailNum="";

select * from FlightsDB.CraftDataPerDay
where Year = 2007;


select * from FlightsDB.AircraftSummary
where year = 2007;

delete from FlightsDB.AircraftSummary
where TailNum = "0"


Update FlightsDB.AircraftSummary a,
	(Select c.Year, c.Month,  c.UniqueCarrier, c.TailNum, 
		avg(c.TotalTimeinAirPerDay) as TotalAirTime, 
        avg(c.TotalTravelTImePerDay) as TotalTravelTime,
        avg(c.TimeOnGroundPerDay) as TimeOnGround,
        avg(c.NumFlightsPerDay) as AvgFlightsPerDay,
        sum(c.TotalDistancePerDay) as TotalDistance,
        avg(c.TotalDistancePerDay) as AvgDistancePerDay
	from 
		(select UniqueCarrier, TailNum, Year, Month, DayofMonth,
		TotalFlights as NumFlightsPerDay,
        TotalTimeinAir as TotalTimeinAirPerDay,
        (1440-TotalTimeInAir) as TimeOnGroundPerDay,
		TotalTravelTime as TotalTravelTimePerDay,
        TotalDistance as TotalDistancePerDay
		from FlightsDB.CraftDataPerDay) c
	 group by c.Year, c.Month, c.UniqueCarrier, c.TailNum) b
SET a.AvgFlightsPerDay = b.AvgFlightsPerDay,
	a.TotalDistance = b.TotalDistance,
    a.AvgDistancePerDay = b.AvgDistancePerDay,
    a.TotalAirTime = b.TotalAirTime,
    a.TotalTravelTime = b.TotalTravelTime,
    a.TimeOnGround = b.TimeOnGround
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.TailNum = b.TailNum
      and a.Month = b.Month;


select * from FlightsDB.Flights_2000
where TailNum in ('N157AW', 'N808AW')
and Month = 1
and DayofMonth in (28, 29)
order by TailNum, Month, DayofMonth, DepTime ;


select * from FlightsDB.Flights_2000
where Month = 1
and DayofMonth = 28
and DepTime > 1900
and ORIGIN = 'PHX'
and DEST = 'LAS'
and UniqueCarrier = 'HP';
 

select
select Year, Month, UniqueCarrier, count(distinct TailNum) as NumCrafts, sum(NumFlightsPerMonth) as NumFlightsPerMonth, 
avg(AvgFlightsPerDay) as AvgFlightsPerDay, avg(TotalAirTime) AS AvgAirTime,
avg(TotalTravelTime) AvgTravelTime, avg(TimeOnGround) as AvgTimeOnGround
from FlightsDB.AircraftSummary
group by Year, Month, UniqueCarrier
order by AvgTimeOnGround ;

grant all privileges 
  on FlightsDB.* 
  to 'ritu'@'localhost' 
  identified by 'j*92Jst1';

flush privileges; 

GRANT FILE ON *.* TO 'ritu'@'localhost';


SELECT *
    FROM FlightsDB.AircraftSummary
    INTO OUTFILE 'Aircraft_Summary.csv'
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n';

SELECT *
    FROM FlightsDB.CraftDataPerDay
    INTO OUTFILE 'AircraftData.csv'
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n';


select distinct Month from FlightsDB.AircraftSummary
where UniqueCarrier = 'AQ';

drop table CarrierRef;
create table CarrierRef
(UniqueCarrier varchar(3) NOT NULL,
CarrierName varchar(50) NOT NULL
);

LOAD DATA LOCAL INFILE 
'/Users/ritu/Documents/Udacity/Data\ Visualization/Project/Data\ Files/CarrierRef.csv'
into table CarrierRef
FIELDS TERMINATED BY ',';

select * from CarrierRef;

drop table MonthRef;
create table MonthRef
(Month INT NOT NULL,
MonthName_Short varchar(3) NOT NULL,
MonthName_Full varchar(50) NOT NULL
);

LOAD DATA LOCAL INFILE 
'/Users/ritu/Documents/Udacity/Data\ Visualization/Project/Data\ Files/MonthRef.csv'
into table MonthRef
FIELDS TERMINATED BY ',';

select a.Year, c.MonthName_Short as Month, a.UniqueCarrier, b.CarrierName, count(*) as TotalAircrafts,
sum(a.NumFlightsPerMonth) as TotalFlights, sum(a.TotalDistance) as TotalDistance,
round(avg(a.AvgDistancePerDay),2) as AvgDistancePerDay, round(avg(a.AvgFlightsPerDay), 2) as AvgFlightsPerDay, 
sum(TotalAirTime) as TotalAirTime, sum(TotalTravelTime) as TotalTravelTime, 
sum(TimeOnGround) as TimeOnGround, round(sum(TimeOnGround)/(sum(TotalAirTime) + sum(TimeOnGround))*100) as PctTimeOnGround
from FlightsDB.AircraftSummary a
join FlightsDB.CarrierRef b
join FlightsDB.MonthRef c
on a.UniqueCarrier = b.UniqueCarrier
and a.Month = c.Month
group by a.Year, a.Month, a.UniqueCarrier, b.CarrierName,c.Month, c.MonthName_Short
INTO OUTFILE 'AircraftSummary7.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';



'WN', 'AA', 'OO', 'MQ', 'US', 'DL', 'UA', 'B6', 'AS', 'FL'