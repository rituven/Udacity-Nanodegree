drop table FlightsDB.AircraftSummary2;
create table FlightsDB.AircraftSummary2
(Year INT NOT NULL,
Month INT NOT NULL,
UniqueCarrier varchar(3) NOT NULL,
TailNum varchar(20) NOT NULL,
NumFlightsPerMonth FLOAT,
AvgFlightsPerDay FLOAT,
TotalDistance FLOAT,
TotalAirTimePerMonth FLOAT,
Cancelled FLOAT,
TotalAirTimePerDay FLOAT,
TotalDays FLOAT
);

insert into FlightsDB.AircraftSummary2
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth, AvgFlightsPerDay,
TotalDistance, TotalAirTimePerMonth, Cancelled, 
TotalAirTimePerDay, TotalDays)
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth,
round(count(*)/count(distinct DayofMonth), 2) as AvgFlightsPerDay,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalAirTimePerMonth,
Cancelled,
round((sum(AirTime) + sum(TaxiIn) + sum(TaxiOut))/count(distinct DayofMonth), 2) as TotalAirTimePerDay,
count(distinct DayofMonth) as TotalDays
from FlightsDB.Flights_2008
where TailNum != ""
group by Year, Month,  UniqueCarrier, TailNum, Cancelled;

insert into FlightsDB.AircraftSummary2
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth, AvgFlightsPerDay,
TotalDistance, TotalAirTimePerMonth, Cancelled, 
TotalAirTimePerDay, TotalDays)
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth,
round(count(*)/count(distinct DayofMonth), 2) as AvgFlightsPerDay,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalAirTimePerMonth,
Cancelled,
round((sum(AirTime) + sum(TaxiIn) + sum(TaxiOut))/count(distinct DayofMonth), 2) as TotalAirTimePerDay,
count(distinct DayofMonth) as TotalDays
from FlightsDB.Flights_2007
where TailNum != ""
group by Year, Month,  UniqueCarrier, TailNum, Cancelled;

insert into FlightsDB.AircraftSummary2
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth, AvgFlightsPerDay,
TotalDistance, TotalAirTimePerMonth, Cancelled, 
TotalAirTimePerDay, TotalDays)
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth,
round(count(*)/count(distinct DayofMonth), 2) as AvgFlightsPerDay,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalAirTimePerMonth,
Cancelled,
round((sum(AirTime) + sum(TaxiIn) + sum(TaxiOut))/count(distinct DayofMonth), 2) as TotalAirTimePerDay,
count(distinct DayofMonth) as TotalDays
from FlightsDB.Flights_2006
where TailNum != ""
group by Year, Month,  UniqueCarrier, TailNum, Cancelled;

insert into FlightsDB.AircraftSummary2
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth, AvgFlightsPerDay,
TotalDistance, TotalAirTimePerMonth, Cancelled, 
TotalAirTimePerDay, TotalDays) 
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth,
round(count(*)/count(distinct DayofMonth), 2) as AvgFlightsPerDay,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalAirTimePerMonth,
Cancelled,
round((sum(AirTime) + sum(TaxiIn) + sum(TaxiOut))/count(distinct DayofMonth), 2) as TotalAirTimePerDay,
count(distinct DayofMonth) as TotalDays
from FlightsDB.Flights_2005
where TailNum != ""
group by Year, Month,  UniqueCarrier, TailNum, Cancelled;

insert into FlightsDB.AircraftSummary2
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth,AvgFlightsPerDay,
 TotalDistance, TotalAirTimePerMonth, Cancelled, 
TotalAirTimePerDay, TotalDays)
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth,
round(count(*)/count(distinct DayofMonth), 2) as AvgFlightsPerDay,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalAirTimePerMonth,
Cancelled,
round((sum(AirTime) + sum(TaxiIn) + sum(TaxiOut))/count(distinct DayofMonth), 2) as TotalAirTimePerDay,
count(distinct DayofMonth) as TotalDays
from FlightsDB.Flights_2004
where TailNum != ""
group by Year, Month,  UniqueCarrier, TailNum, Cancelled;

insert into FlightsDB.AircraftSummary2
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth, AvgFlightsPerDay,
TotalDistance, TotalAirTimePerMonth, Cancelled, 
TotalAirTimePerDay, TotalDays)
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth,
round(count(*)/count(distinct DayofMonth), 2) as AvgFlightsPerDay,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalAirTimePerMonth,
Cancelled,
round((sum(AirTime) + sum(TaxiIn) + sum(TaxiOut))/count(distinct DayofMonth), 2) as TotalAirTimePerDay,
count(distinct DayofMonth) as TotalDays
from FlightsDB.Flights_2003
where TailNum != ""
group by Year, Month,  UniqueCarrier, TailNum, Cancelled;

insert into FlightsDB.AircraftSummary2
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth, AvgFlightsPerDay,
TotalDistance, TotalAirTimePerMonth, Cancelled, 
TotalAirTimePerDay, TotalDays)
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth,
round(count(*)/count(distinct DayofMonth), 2) as AvgFlightsPerDay,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalAirTimePerMonth,
Cancelled,
round((sum(AirTime) + sum(TaxiIn) + sum(TaxiOut))/count(distinct DayofMonth), 2) as TotalAirTimePerDay,
count(distinct DayofMonth) as TotalDays
from FlightsDB.Flights_2002
where TailNum != ""
group by Year, Month,  UniqueCarrier, TailNum, Cancelled;

insert into FlightsDB.AircraftSummary2
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth, AvgFlightsPerDay,
TotalDistance, TotalAirTimePerMonth, Cancelled, 
TotalAirTimePerDay, TotalDays)
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth,
round(count(*)/count(distinct DayofMonth), 2) as AvgFlightsPerDay,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalAirTimePerMonth,
Cancelled,
round((sum(AirTime) + sum(TaxiIn) + sum(TaxiOut))/count(distinct DayofMonth), 2) as TotalAirTimePerDay,
count(distinct DayofMonth) as TotalDays
from FlightsDB.Flights_2001
where TailNum != ""
group by Year, Month,  UniqueCarrier, TailNum, Cancelled;

insert into FlightsDB.AircraftSummary2
(Year, Month, UniqueCarrier, TailNum, NumFlightsPerMonth, AvgFlightsPerDay,
TotalDistance, TotalAirTimePerMonth, Cancelled, 
TotalAirTimePerDay, TotalDays)
select Year, Month, UniqueCarrier, TailNum, count(*) as NumFlightsPerMonth,
round(count(*)/count(distinct DayofMonth), 2) as AvgFlightsPerDay,
sum(Distance) as TotalDistance,
sum(AirTime) + sum(TaxiIn) + sum(TaxiOut) as TotalAirTimePerMonth,
Cancelled,
round((sum(AirTime) + sum(TaxiIn) + sum(TaxiOut))/count(distinct DayofMonth), 2) as TotalAirTimePerDay,
count(distinct DayofMonth) as TotalDays
from FlightsDB.Flights_2000
where TailNum != ""
group by Year, Month,  UniqueCarrier, TailNum, Cancelled;




select a.Year, a.UniqueCarrier, b.CarrierName, count(*) as TotalAircrafts,
round(sum(a.NumFlightsPerMonth) / count(distinct TailNum), 2) as TotalFlightsPerCraft, 
round(sum(a.NumFlightsPerMonth), 2) as TotalFlights, sum(a.TotalDistance) as TotalDistance,
round(sum(TotalAirTimePerMonth) / count(distinct TailNum),2 ) as TotalAirTimePerCraft, 
round(sum(TotalAirTimePerMonth), 2) as TotalAirTime, "Total" as Month
from FlightsDB.AircraftSummary2 a
join FlightsDB.CarrierRef b
on a.UniqueCarrier = b.UniqueCarrier
where TailNum != ""
group by a.Year,  a.UniqueCarrier, b.CarrierName
order by TotalAirTime desc
INTO OUTFILE 'AircraftSummaryByYear8.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';


select a.Year, a.UniqueCarrier, b.CarrierName, count(*) as TotalAircrafts,
round(sum(a.NumFlightsPerMonth) / count(distinct TailNum), 2) as TotalFlightsPerCraft, 
round(sum(a.NumFlightsPerMonth), 2) as TotalFlights, sum(a.TotalDistance) as TotalDistance,
round(sum(TotalAirTimePerMonth) / count(distinct TailNum),2 ) as TotalAirTimePerCraft, 
round(sum(TotalDays) / count(distinct TailNum), 2) as DaysFlownPerCraft,
round(avg(TotalAirTimePerDay), 2) as AvgAirTimePerDay,
round(sum(TotalAirTimePerMonth), 2) as TotalAirTime, cancelled, "Total" as Month
from FlightsDB.AircraftSummary2 a
join FlightsDB.CarrierRef b
on a.UniqueCarrier = b.UniqueCarrier
group by a.Year,  a.UniqueCarrier, b.CarrierName, a.cancelled
order by Year, UniqueCarrier desc;

select * from FlightsDB.AircraftSummary2
where TailNum = "";

select distinct tailNum
from Flights_2006
where UniqueCarrier = 'WN'
and cancelled = 1;


select a.Year, a.UniqueCarrier, b.CarrierName, count(*) as TotalAircrafts,
round(sum(a.NumFlightsPerMonth) / count(distinct TailNum), 2) as TotalFlightsPerCraft, 
round(sum(a.NumFlightsPerMonth), 2) as TotalFlights, sum(a.TotalDistance) as TotalDistance,
round(sum(TotalAirTimePerMonth) / count(distinct TailNum),2 ) as TotalAirTimePerCraft, 
round(sum(TotalDays) / count(distinct TailNum), 2) as DaysFlownPerCraft,
round(avg(TotalAirTimePerDay), 2) as AvgAirTimePerDay,
round(avg(AvgFlightsPerDay), 2) as AvgFlightsPerDay,
round(sum(TotalAirTimePerMonth), 2) as TotalAirTime, cancelled, "Total" as Month
from FlightsDB.AircraftSummary2 a
join FlightsDB.CarrierRef b
on a.UniqueCarrier = b.UniqueCarrier
group by a.Year,  a.UniqueCarrier, b.CarrierName, a.cancelled
order by Year, UniqueCarrier desc
INTO  OUTFILE 'AircraftSummaryData2.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';