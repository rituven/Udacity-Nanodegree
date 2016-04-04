create database FlightsDB;

drop table FlightsDB.Flights_2008;

Create table FlightsDB.Flights_2008
(Year INT NOT NULL,
Month INT NOT NULL,
DayofMonth INT NOT NULL,
DayOfWeek INT NOT NULL,
DepTime FLOAT, 
CRSDepTime FLOAT,
ArrTime FLOAT,
CRSArrTime FLOAT,
UniqueCarrier varchar(3),
FlightNum varchar(10),
TailNum varchar(20),
ActualElapsedTime FLOAT,
CRSElapsedTime FLOAT,
AirTime FLOAT, 
ArrDelay FLOAT,
DepDelay FLOAT, 
Origin varchar(3),
Dest varchar(3),
Distance FLOAT, 
TaxiIn FLOAT, 
TaxiOut FLOAT, 
Cancelled FLOAT, 
CancellationCode varchar(3),
Diverted varchar(3), 
CarrierDelay FLOAT, 
WeatherDelay FLOAT, 
NASDelay FLOAT,
SecurityDelay FLOAT,
LateAircraftDelay FLOAT);

LOAD DATA LOCAL INFILE 
'/Users/ritu/Documents/Udacity/Data\ Visualization/Project/Data\ Files/2008.csv'
into table FlightsDB.flights_2008
FIELDS TERMINATED BY ',';

delete from FlightsDB.Flights_2008
where Year = 0;

drop table FlightsDB.FlightsSummary;

create table FlightsDB.FlightsSummary
(Year INT NOT NULL,
UniqueCarrier varchar(3) NOT NULL,
Dest varchar(3) NOT NULL, 
Total_Flights FLOAT,
Delayed_Flights FLOAT,
Delayed_Perc FLOAT,
NASDelay_count FLOAT,
NASDelay_Perc FLOAT,
SecurityDelay_count FLOAT,
SecurityDelay_Perc FLOAT,
CarrierDelay_count FLOAT,
CarrierDelay_Perc FLOAT,
WeatherDelay_count FLOAT,
WeatherDelay_Perc FLOAT,
LateAircraftDelay_count FLOAT,
LateAircraftDelay_Perc FLOAT);

insert into FlightsDB.FlightsSummary
(Year, UniqueCarrier, Dest, Total_Flights)
(select Year, UniqueCarrier, Dest, count(*) as Total_Flights
from FlightsDB.flights_2008
group by Year, UniqueCarrier, Dest);

Update FlightsDB.FlightsSummary a
left join (Select Year, UniqueCarrier, Dest, count(*) as Delayed_Flights
		from FlightsDB.flights_2008
		where ArrDelay > 15
		group by Year, UniqueCarrier, Dest) b
ON a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest
SET a.Delayed_Flights = b.Delayed_Flights,
    a.Delayed_Perc = (b.Delayed_Flights/a.Total_Flights)*100;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as Delayed_Flights
	from FlightsDB.flights_2008
	where ArrDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.Delayed_Flights = b.Delayed_Flights,
    a.Delayed_Perc = (b.Delayed_Flights/a.Total_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as NASDelay_count
	from FlightsDB.flights_2008
	where NASDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.NASDelay_count = b.NASDelay_count,
    a.NASDelay_Perc = (b.NASDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;
          
Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as SecurityDelay_count
	from FlightsDB.flights_2008
	where SecurityDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.SecurityDelay_count = b.SecurityDelay_count,
    a.SecurityDelay_Perc = (b.SecurityDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as CarrierDelay_count
	from FlightsDB.flights_2008
	where CarrierDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.CarrierDelay_count = b.CarrierDelay_count,
    a.CarrierDelay_Perc = (b.CarrierDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as WeatherDelay_count
	from FlightsDB.flights_2008
	where WeatherDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.WeatherDelay_count = b.WeatherDelay_count,
    a.WeatherDelay_Perc = (b.WeatherDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as LateAircraftDelay_count
	from FlightsDB.flights_2008
	where LateAircraftDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.LateAircraftDelay_count = b.LateAircraftDelay_count,
    a.LateAircraftDelay_Perc = (b.LateAircraftDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

delete from FlightsDB.FlightsSummary
where Year = 0;



select Year, Dest, sum(Total_Flights), sum(Delayed_Flights), sum(NASDelay_count),
sum(SecurityDelay_count), sum(WeatherDelay_count), sum(LateAircraftDelay_count)
 from FlightsDB.FlightsSummary
group by Year, Dest
order by sum(Total_Flights) desc, sum(Delayed_Flights) asc;


select * from FlightsDB.FlightsSummary
order by Total_Flights desc, Delayed_Flights asc;

select * from FlightsDB.FlightsSummary
where total_flights > 10000
order by Total_Flights desc, Delayed_perc desc;


select Year, UniqueCarrier, Dest, Total_FlightsDelay_perc, NASDelay_perc


----------------
drop table FlightsDB.Flights_2007;

Create table FlightsDB.Flights_2007
(Year INT NOT NULL,
Month INT NOT NULL,
DayofMonth INT NOT NULL,
DayOfWeek INT NOT NULL,
DepTime FLOAT, 
CRSDepTime FLOAT,
ArrTime FLOAT,
CRSArrTime FLOAT,
UniqueCarrier varchar(3),
FlightNum varchar(10),
TailNum varchar(20),
ActualElapsedTime FLOAT,
CRSElapsedTime FLOAT,
AirTime FLOAT, 
ArrDelay FLOAT,
DepDelay FLOAT, 
Origin varchar(3),
Dest varchar(3),
Distance FLOAT, 
TaxiIn FLOAT, 
TaxiOut FLOAT, 
Cancelled FLOAT, 
CancellationCode varchar(3),
Diverted varchar(3), 
CarrierDelay FLOAT, 
WeatherDelay FLOAT, 
NASDelay FLOAT,
SecurityDelay FLOAT,
LateAircraftDelay FLOAT);

LOAD DATA LOCAL INFILE 
'/Users/ritu/Documents/Udacity/Data\ Visualization/Project/Data\ Files/2007.csv'
into table FlightsDB.flights_2007
FIELDS TERMINATED BY ',';

delete from FlightsDB.Flights_2007
where Year = 0;

insert into FlightsDB.FlightsSummary
(Year, UniqueCarrier, Dest, Total_Flights)
(select Year, UniqueCarrier, Dest, count(*) as Total_Flights
from FlightsDB.flights_2007
group by Year, UniqueCarrier, Dest);


Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as Delayed_Flights
	from FlightsDB.flights_2007
	where ArrDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.Delayed_Flights = b.Delayed_Flights,
    a.Delayed_Perc = (b.Delayed_Flights/a.Total_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as NASDelay_count
	from FlightsDB.flights_2007
	where NASDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.NASDelay_count = b.NASDelay_count,
    a.NASDelay_Perc = (b.NASDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;
          
Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as SecurityDelay_count
	from FlightsDB.flights_2007
	where SecurityDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.SecurityDelay_count = b.SecurityDelay_count,
    a.SecurityDelay_Perc = (b.SecurityDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as CarrierDelay_count
	from FlightsDB.flights_2007
	where CarrierDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.CarrierDelay_count = b.CarrierDelay_count,
    a.CarrierDelay_Perc = (b.CarrierDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as WeatherDelay_count
	from FlightsDB.flights_2007
	where WeatherDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.WeatherDelay_count = b.WeatherDelay_count,
    a.WeatherDelay_Perc = (b.WeatherDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as LateAircraftDelay_count
	from FlightsDB.flights_2007
	where LateAircraftDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.LateAircraftDelay_count = b.LateAircraftDelay_count,
    a.LateAircraftDelay_Perc = (b.LateAircraftDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

--------------

----------------
drop table FlightsDB.Flights_2006;

Create table FlightsDB.Flights_2006
(Year INT NOT NULL,
Month INT NOT NULL,
DayofMonth INT NOT NULL,
DayOfWeek INT NOT NULL,
DepTime FLOAT, 
CRSDepTime FLOAT,
ArrTime FLOAT,
CRSArrTime FLOAT,
UniqueCarrier varchar(3),
FlightNum varchar(10),
TailNum varchar(20),
ActualElapsedTime FLOAT,
CRSElapsedTime FLOAT,
AirTime FLOAT, 
ArrDelay FLOAT,
DepDelay FLOAT, 
Origin varchar(3),
Dest varchar(3),
Distance FLOAT, 
TaxiIn FLOAT, 
TaxiOut FLOAT, 
Cancelled FLOAT, 
CancellationCode varchar(3),
Diverted varchar(3), 
CarrierDelay FLOAT, 
WeatherDelay FLOAT, 
NASDelay FLOAT,
SecurityDelay FLOAT,
LateAircraftDelay FLOAT);

LOAD DATA LOCAL INFILE 
'/Users/ritu/Documents/Udacity/Data\ Visualization/Project/Data\ Files/2006.csv'
into table FlightsDB.flights_2006
FIELDS TERMINATED BY ',';

delete from FlightsDB.Flights_2006
where Year = 0;

insert into FlightsDB.FlightsSummary
(Year, UniqueCarrier, Dest, Total_Flights)
(select Year, UniqueCarrier, Dest, count(*) as Total_Flights
from FlightsDB.flights_2006
group by Year, UniqueCarrier, Dest);


Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as Delayed_Flights
	from FlightsDB.flights_2006
	where ArrDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.Delayed_Flights = b.Delayed_Flights,
    a.Delayed_Perc = (b.Delayed_Flights/a.Total_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as NASDelay_count
	from FlightsDB.flights_2006
	where NASDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.NASDelay_count = b.NASDelay_count,
    a.NASDelay_Perc = (b.NASDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;
          
Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as SecurityDelay_count
	from FlightsDB.flights_2006
	where SecurityDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.SecurityDelay_count = b.SecurityDelay_count,
    a.SecurityDelay_Perc = (b.SecurityDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as CarrierDelay_count
	from FlightsDB.flights_2006
	where CarrierDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.CarrierDelay_count = b.CarrierDelay_count,
    a.CarrierDelay_Perc = (b.CarrierDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as WeatherDelay_count
	from FlightsDB.flights_2006
	where WeatherDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.WeatherDelay_count = b.WeatherDelay_count,
    a.WeatherDelay_Perc = (b.WeatherDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as LateAircraftDelay_count
	from FlightsDB.flights_2006
	where LateAircraftDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.LateAircraftDelay_count = b.LateAircraftDelay_count,
    a.LateAircraftDelay_Perc = (b.LateAircraftDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;


----------------
drop table FlightsDB.Flights_2005;

Create table FlightsDB.Flights_2005
(Year INT NOT NULL,
Month INT NOT NULL,
DayofMonth INT NOT NULL,
DayOfWeek INT NOT NULL,
DepTime FLOAT, 
CRSDepTime FLOAT,
ArrTime FLOAT,
CRSArrTime FLOAT,
UniqueCarrier varchar(3),
FlightNum varchar(10),
TailNum varchar(20),
ActualElapsedTime FLOAT,
CRSElapsedTime FLOAT,
AirTime FLOAT, 
ArrDelay FLOAT,
DepDelay FLOAT, 
Origin varchar(3),
Dest varchar(3),
Distance FLOAT, 
TaxiIn FLOAT, 
TaxiOut FLOAT, 
Cancelled FLOAT, 
CancellationCode varchar(3),
Diverted varchar(3), 
CarrierDelay FLOAT, 
WeatherDelay FLOAT, 
NASDelay FLOAT,
SecurityDelay FLOAT,
LateAircraftDelay FLOAT);

LOAD DATA LOCAL INFILE 
'/Users/ritu/Documents/Udacity/Data\ Visualization/Project/Data\ Files/2005.csv'
into table FlightsDB.flights_2005
FIELDS TERMINATED BY ',';

delete from FlightsDB.Flights_2005
where Year = 0;

insert into FlightsDB.FlightsSummary
(Year, UniqueCarrier, Dest, Total_Flights)
(select Year, UniqueCarrier, Dest, count(*) as Total_Flights
from FlightsDB.flights_2005
group by Year, UniqueCarrier, Dest);


Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as Delayed_Flights
	from FlightsDB.flights_2005
	where ArrDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.Delayed_Flights = b.Delayed_Flights,
    a.Delayed_Perc = (b.Delayed_Flights/a.Total_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as NASDelay_count
	from FlightsDB.flights_2005
	where NASDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.NASDelay_count = b.NASDelay_count,
    a.NASDelay_Perc = (b.NASDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;
          
Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as SecurityDelay_count
	from FlightsDB.flights_2005
	where SecurityDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.SecurityDelay_count = b.SecurityDelay_count,
    a.SecurityDelay_Perc = (b.SecurityDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as CarrierDelay_count
	from FlightsDB.flights_2005
	where CarrierDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.CarrierDelay_count = b.CarrierDelay_count,
    a.CarrierDelay_Perc = (b.CarrierDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as WeatherDelay_count
	from FlightsDB.flights_2005
	where WeatherDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.WeatherDelay_count = b.WeatherDelay_count,
    a.WeatherDelay_Perc = (b.WeatherDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as LateAircraftDelay_count
	from FlightsDB.flights_2005
	where LateAircraftDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.LateAircraftDelay_count = b.LateAircraftDelay_count,
    a.LateAircraftDelay_Perc = (b.LateAircraftDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

----------------
drop table FlightsDB.Flights_2004;

Create table FlightsDB.Flights_2004
(Year INT NOT NULL,
Month INT NOT NULL,
DayofMonth INT NOT NULL,
DayOfWeek INT NOT NULL,
DepTime FLOAT, 
CRSDepTime FLOAT,
ArrTime FLOAT,
CRSArrTime FLOAT,
UniqueCarrier varchar(3),
FlightNum varchar(10),
TailNum varchar(20),
ActualElapsedTime FLOAT,
CRSElapsedTime FLOAT,
AirTime FLOAT, 
ArrDelay FLOAT,
DepDelay FLOAT, 
Origin varchar(3),
Dest varchar(3),
Distance FLOAT, 
TaxiIn FLOAT, 
TaxiOut FLOAT, 
Cancelled FLOAT, 
CancellationCode varchar(3),
Diverted varchar(3), 
CarrierDelay FLOAT, 
WeatherDelay FLOAT, 
NASDelay FLOAT,
SecurityDelay FLOAT,
LateAircraftDelay FLOAT);

LOAD DATA LOCAL INFILE 
'/Users/ritu/Documents/Udacity/Data\ Visualization/Project/Data\ Files/2004.csv'
into table FlightsDB.flights_2004
FIELDS TERMINATED BY ',';

delete from FlightsDB.Flights_2004
where Year = 0;

insert into FlightsDB.FlightsSummary
(Year, UniqueCarrier, Dest, Total_Flights)
(select Year, UniqueCarrier, Dest, count(*) as Total_Flights
from FlightsDB.flights_2004
group by Year, UniqueCarrier, Dest);


Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as Delayed_Flights
	from FlightsDB.flights_2004
	where ArrDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.Delayed_Flights = b.Delayed_Flights,
    a.Delayed_Perc = (b.Delayed_Flights/a.Total_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as NASDelay_count
	from FlightsDB.flights_2004
	where NASDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.NASDelay_count = b.NASDelay_count,
    a.NASDelay_Perc = (b.NASDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;
          
Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as SecurityDelay_count
	from FlightsDB.flights_2004
	where SecurityDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.SecurityDelay_count = b.SecurityDelay_count,
    a.SecurityDelay_Perc = (b.SecurityDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as CarrierDelay_count
	from FlightsDB.flights_2004
	where CarrierDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.CarrierDelay_count = b.CarrierDelay_count,
    a.CarrierDelay_Perc = (b.CarrierDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as WeatherDelay_count
	from FlightsDB.flights_2004
	where WeatherDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.WeatherDelay_count = b.WeatherDelay_count,
    a.WeatherDelay_Perc = (b.WeatherDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as LateAircraftDelay_count
	from FlightsDB.flights_2004
	where LateAircraftDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.LateAircraftDelay_count = b.LateAircraftDelay_count,
    a.LateAircraftDelay_Perc = (b.LateAircraftDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

----------------
drop table FlightsDB.Flights_2003;

Create table FlightsDB.Flights_2003
(Year INT NOT NULL,
Month INT NOT NULL,
DayofMonth INT NOT NULL,
DayOfWeek INT NOT NULL,
DepTime FLOAT, 
CRSDepTime FLOAT,
ArrTime FLOAT,
CRSArrTime FLOAT,
UniqueCarrier varchar(3),
FlightNum varchar(10),
TailNum varchar(20),
ActualElapsedTime FLOAT,
CRSElapsedTime FLOAT,
AirTime FLOAT, 
ArrDelay FLOAT,
DepDelay FLOAT, 
Origin varchar(3),
Dest varchar(3),
Distance FLOAT, 
TaxiIn FLOAT, 
TaxiOut FLOAT, 
Cancelled FLOAT, 
CancellationCode varchar(3),
Diverted varchar(3), 
CarrierDelay FLOAT, 
WeatherDelay FLOAT, 
NASDelay FLOAT,
SecurityDelay FLOAT,
LateAircraftDelay FLOAT);

LOAD DATA LOCAL INFILE 
'/Users/ritu/Documents/Udacity/Data\ Visualization/Project/Data\ Files/2003.csv'
into table FlightsDB.flights_2003
FIELDS TERMINATED BY ',';

delete from FlightsDB.Flights_2003
where Year = 0;

insert into FlightsDB.FlightsSummary
(Year, UniqueCarrier, Dest, Total_Flights)
(select Year, UniqueCarrier, Dest, count(*) as Total_Flights
from FlightsDB.flights_2003
group by Year, UniqueCarrier, Dest);


Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as Delayed_Flights
	from FlightsDB.flights_2003
	where ArrDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.Delayed_Flights = b.Delayed_Flights,
    a.Delayed_Perc = (b.Delayed_Flights/a.Total_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as NASDelay_count
	from FlightsDB.flights_2003
	where NASDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.NASDelay_count = b.NASDelay_count,
    a.NASDelay_Perc = (b.NASDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;
          
Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as SecurityDelay_count
	from FlightsDB.flights_2003
	where SecurityDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.SecurityDelay_count = b.SecurityDelay_count,
    a.SecurityDelay_Perc = (b.SecurityDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as CarrierDelay_count
	from FlightsDB.flights_2003
	where CarrierDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.CarrierDelay_count = b.CarrierDelay_count,
    a.CarrierDelay_Perc = (b.CarrierDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as WeatherDelay_count
	from FlightsDB.flights_2003
	where WeatherDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.WeatherDelay_count = b.WeatherDelay_count,
    a.WeatherDelay_Perc = (b.WeatherDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as LateAircraftDelay_count
	from FlightsDB.flights_2003
	where LateAircraftDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.LateAircraftDelay_count = b.LateAircraftDelay_count,
    a.LateAircraftDelay_Perc = (b.LateAircraftDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

----------------
drop table FlightsDB.Flights_2002;

Create table FlightsDB.Flights_2002
(Year INT NOT NULL,
Month INT NOT NULL,
DayofMonth INT NOT NULL,
DayOfWeek INT NOT NULL,
DepTime FLOAT, 
CRSDepTime FLOAT,
ArrTime FLOAT,
CRSArrTime FLOAT,
UniqueCarrier varchar(3),
FlightNum varchar(10),
TailNum varchar(20),
ActualElapsedTime FLOAT,
CRSElapsedTime FLOAT,
AirTime FLOAT, 
ArrDelay FLOAT,
DepDelay FLOAT, 
Origin varchar(3),
Dest varchar(3),
Distance FLOAT, 
TaxiIn FLOAT, 
TaxiOut FLOAT, 
Cancelled FLOAT, 
CancellationCode varchar(3),
Diverted varchar(3), 
CarrierDelay FLOAT, 
WeatherDelay FLOAT, 
NASDelay FLOAT,
SecurityDelay FLOAT,
LateAircraftDelay FLOAT);

LOAD DATA LOCAL INFILE 
'/Users/ritu/Documents/Udacity/Data\ Visualization/Project/Data\ Files/2002.csv'
into table FlightsDB.flights_2002
FIELDS TERMINATED BY ',';

delete from FlightsDB.Flights_2002
where Year = 0;

insert into FlightsDB.FlightsSummary
(Year, UniqueCarrier, Dest, Total_Flights)
(select Year, UniqueCarrier, Dest, count(*) as Total_Flights
from FlightsDB.flights_2002
group by Year, UniqueCarrier, Dest);


Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as Delayed_Flights
	from FlightsDB.flights_2002
	where ArrDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.Delayed_Flights = b.Delayed_Flights,
    a.Delayed_Perc = (b.Delayed_Flights/a.Total_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as NASDelay_count
	from FlightsDB.flights_2002
	where NASDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.NASDelay_count = b.NASDelay_count,
    a.NASDelay_Perc = (b.NASDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;
          
Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as SecurityDelay_count
	from FlightsDB.flights_2002
	where SecurityDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.SecurityDelay_count = b.SecurityDelay_count,
    a.SecurityDelay_Perc = (b.SecurityDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as CarrierDelay_count
	from FlightsDB.flights_2002
	where CarrierDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.CarrierDelay_count = b.CarrierDelay_count,
    a.CarrierDelay_Perc = (b.CarrierDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as WeatherDelay_count
	from FlightsDB.flights_2002
	where WeatherDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.WeatherDelay_count = b.WeatherDelay_count,
    a.WeatherDelay_Perc = (b.WeatherDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as LateAircraftDelay_count
	from FlightsDB.flights_2002
	where LateAircraftDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.LateAircraftDelay_count = b.LateAircraftDelay_count,
    a.LateAircraftDelay_Perc = (b.LateAircraftDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

----------------
drop table FlightsDB.Flights_2001;

Create table FlightsDB.Flights_2001
(Year INT NOT NULL,
Month INT NOT NULL,
DayofMonth INT NOT NULL,
DayOfWeek INT NOT NULL,
DepTime FLOAT, 
CRSDepTime FLOAT,
ArrTime FLOAT,
CRSArrTime FLOAT,
UniqueCarrier varchar(3),
FlightNum varchar(10),
TailNum varchar(20),
ActualElapsedTime FLOAT,
CRSElapsedTime FLOAT,
AirTime FLOAT, 
ArrDelay FLOAT,
DepDelay FLOAT, 
Origin varchar(3),
Dest varchar(3),
Distance FLOAT, 
TaxiIn FLOAT, 
TaxiOut FLOAT, 
Cancelled FLOAT, 
CancellationCode varchar(3),
Diverted varchar(3), 
CarrierDelay FLOAT, 
WeatherDelay FLOAT, 
NASDelay FLOAT,
SecurityDelay FLOAT,
LateAircraftDelay FLOAT);

LOAD DATA LOCAL INFILE 
'/Users/ritu/Documents/Udacity/Data\ Visualization/Project/Data\ Files/2001.csv'
into table FlightsDB.flights_2001
FIELDS TERMINATED BY ',';

delete from FlightsDB.Flights_2001
where Year = 0;

insert into FlightsDB.FlightsSummary
(Year, UniqueCarrier, Dest, Total_Flights)
(select Year, UniqueCarrier, Dest, count(*) as Total_Flights
from FlightsDB.flights_2001
group by Year, UniqueCarrier, Dest);


Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as Delayed_Flights
	from FlightsDB.flights_2001
	where ArrDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.Delayed_Flights = b.Delayed_Flights,
    a.Delayed_Perc = (b.Delayed_Flights/a.Total_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as NASDelay_count
	from FlightsDB.flights_2001
	where NASDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.NASDelay_count = b.NASDelay_count,
    a.NASDelay_Perc = (b.NASDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;
          
Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as SecurityDelay_count
	from FlightsDB.flights_2001
	where SecurityDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.SecurityDelay_count = b.SecurityDelay_count,
    a.SecurityDelay_Perc = (b.SecurityDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as CarrierDelay_count
	from FlightsDB.flights_2001
	where CarrierDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.CarrierDelay_count = b.CarrierDelay_count,
    a.CarrierDelay_Perc = (b.CarrierDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as WeatherDelay_count
	from FlightsDB.flights_2001
	where WeatherDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.WeatherDelay_count = b.WeatherDelay_count,
    a.WeatherDelay_Perc = (b.WeatherDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as LateAircraftDelay_count
	from FlightsDB.flights_2001
	where LateAircraftDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.LateAircraftDelay_count = b.LateAircraftDelay_count,
    a.LateAircraftDelay_Perc = (b.LateAircraftDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

----------------
drop table FlightsDB.Flights_2000;

Create table FlightsDB.Flights_2000
(Year INT NOT NULL,
Month INT NOT NULL,
DayofMonth INT NOT NULL,
DayOfWeek INT NOT NULL,
DepTime FLOAT, 
CRSDepTime FLOAT,
ArrTime FLOAT,
CRSArrTime FLOAT,
UniqueCarrier varchar(3),
FlightNum varchar(10),
TailNum varchar(20),
ActualElapsedTime FLOAT,
CRSElapsedTime FLOAT,
AirTime FLOAT, 
ArrDelay FLOAT,
DepDelay FLOAT, 
Origin varchar(3),
Dest varchar(3),
Distance FLOAT, 
TaxiIn FLOAT, 
TaxiOut FLOAT, 
Cancelled FLOAT, 
CancellationCode varchar(3),
Diverted varchar(3), 
CarrierDelay FLOAT, 
WeatherDelay FLOAT, 
NASDelay FLOAT,
SecurityDelay FLOAT,
LateAircraftDelay FLOAT);

LOAD DATA LOCAL INFILE 
'/Users/ritu/Documents/Udacity/Data\ Visualization/Project/Data\ Files/2000.csv'
into table FlightsDB.flights_2000
FIELDS TERMINATED BY ',';

delete from FlightsDB.Flights_2000
where Year = 0;

insert into FlightsDB.FlightsSummary
(Year, UniqueCarrier, Dest, Total_Flights)
(select Year, UniqueCarrier, Dest, count(*) as Total_Flights
from FlightsDB.flights_2000
group by Year, UniqueCarrier, Dest);


Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as Delayed_Flights
	from FlightsDB.flights_2000
	where ArrDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.Delayed_Flights = b.Delayed_Flights,
    a.Delayed_Perc = (b.Delayed_Flights/a.Total_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as NASDelay_count
	from FlightsDB.flights_2000
	where NASDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.NASDelay_count = b.NASDelay_count,
    a.NASDelay_Perc = (b.NASDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;
          
Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as SecurityDelay_count
	from FlightsDB.flights_2000
	where SecurityDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.SecurityDelay_count = b.SecurityDelay_count,
    a.SecurityDelay_Perc = (b.SecurityDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as CarrierDelay_count
	from FlightsDB.flights_2000
	where CarrierDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.CarrierDelay_count = b.CarrierDelay_count,
    a.CarrierDelay_Perc = (b.CarrierDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as WeatherDelay_count
	from FlightsDB.flights_2000
	where WeatherDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.WeatherDelay_count = b.WeatherDelay_count,
    a.WeatherDelay_Perc = (b.WeatherDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;

Update FlightsDB.FlightsSummary a,
	(Select Year, UniqueCarrier, Dest, count(*) as LateAircraftDelay_count
	from FlightsDB.flights_2000
	where LateAircraftDelay > 15
	group by Year, UniqueCarrier, Dest
	) b
SET a.LateAircraftDelay_count = b.LateAircraftDelay_count,
    a.LateAircraftDelay_Perc = (b.LateAircraftDelay_count/a.Delayed_Flights)*100
WHERE a.Year = b.Year
      and a.UniqueCarrier = b.UniqueCarrier
      and a.Dest = b.Dest;


grant all privileges 
  on FlightsDB.* 
  to 'ritu'@'localhost' 
  identified by 'j*92Jst1';

flush privileges; 

GRANT FILE ON *.* TO 'ritu'@'localhost';

SELECT *
    FROM FlightsDB.FlightsSummary
    INTO OUTFILE 'Flights_Summary2.csv'
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n';


SELECT *
    FROM FlightsDB.FlightsSummary
    INTO OUTFILE '/Users/ritu/Documents/Udacity/Data\ Visualization/Project/Data\ Files/Flights_Summary2.csv'
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n';


select Year, sum(Total_Flights), Dest
from FlightsDb.FlightsSummary
where Dest in ('ATL', 'ORD', 'DFW', 'DEN', 'LAX', 'PHX', 'IAH',
             'LAS', 'DTW', 'SFO', 'SLC', 'EWR', 'MCO',
             'MSP', 'CLT', 'LGA', 'JFK', 'BOS', 'SEA', 'BWI',
             'PHL', 'SAN', 'CVG', 'MDW', 'DCA')
group by Year, Dest
order by Dest, Year;

select Year, Total_Flights, Dest
from FlightsDb.FlightsSummary
where Dest in ('ATL', 'ORD', 'DFW', 'DEN', 'LAX', 'PHX', 'IAH',
             'LAS', 'DTW', 'SFO', 'SLC', 'EWR', 'MCO',
             'MSP', 'CLT', 'LGA', 'JFK', 'BOS', 'SEA', 'BWI',
             'PHL', 'SAN', 'CVG', 'MDW', 'DCA')
order by Dest, Year desc

