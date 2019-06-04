install.packages("RSQLite")
library(RSQLite)

filename <- "flightsv2.db"
sqlite <- dbDriver("SQLite")
db <- dbConnect (sqlite,dbname= filename)
dbListTables(db)

dbGetQuery(db, "SELECT * from airports limit 50 ")

dbGetQuery(db, "SELECT * from ontime limit 50 ")
dbGetQuery(db, "SELECT * from  weekdays limit 10 ")
dbGetQuery(db, "SELECT * from  airlines limit 10 ")

#Pregunta 1
dbGetQuery(db, "SELECT avg(ArrDelay) Average_Delay, w.weekday_name
           from ontime o
           INNER JOIN weekdays w ON w.DayofWeek = o.DayOfWeek
           group by o.DayOfWeek")
#Respuesta 1: El peor dia para viajar es el viernes


dbGetQuery(db, "SELECT avg(ArrDelay) Average_Delay, a.AirlineName
           from ontime o
           INNER JOIN airlines a ON o.UniqueCarrier = a.AirlineCode
           where o.Origin = 'SFO'
           Group by UniqueCarrier
           Order by avg(ArrDelay) DESC")

dbGetQuery(db, "SELECT * 
           from airports
           where iata ='SFO'")

dbGetQuery(db, "SELECT * 
           from ontime
           where UniqueCarrier ='SFO'")


dbGetQuery(db, "PRAGMA table_info(ontime)")

dbGetQuery(db, "SELECT avg(ArrDelay) Average_Delay, a.AirlineName
           from ontime o
           INNER JOIN airlines a ON o.UniqueCarrier = a.AirlineCode
           Group by UniqueCarrier
           HAVING avg(ArrDelay) > 10
           Order by avg(ArrDelay) DESC")

dbGetQuery(db, "SELECT  8/Cast(Count(*) as float)*100
           from airlines")

dbGetQuery(db, "SELECT a.AirlineName, o.Origin, o.Dest
           from ontime o
           INNER JOIN airlines a ON o.UniqueCarrier = a.AirlineCode
           where o.Origin = 'SFO'
           and o.Dest = 'PDX'
           or o.Origin = 'SFO' and  o.Dest = 'EUG'
           Group by UniqueCarrier")

dbGetQuery(db, "SELECT  8/Cast(Count(*) as float)*100
           from airlines")




