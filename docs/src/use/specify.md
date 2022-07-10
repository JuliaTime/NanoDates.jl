## Construction by Specification

Here are some of the methods that take values
```
nd = NanoDate(years)
# 2022-01-01T00:00:00

nd = NanoDate(years, months)
# 2022-06-01T00:00:00

nd = NanoDate(years, months, days)
# 2022-06-18T00:00:00

nd = NanoDate(years, months, days, hours, mins)
# 2022-06-18T12:15:00

nd = NanoDate(years, months, days, hours, mins, secs)
# 2022-06-18T12:15:30

nd = NanoDate(years, months, days, 
              hours, mins, secs, millis, micros)
# 2022-04-28T14:32:10.123456

nd = NanoDate(years, months, days, 
              hours, mins, secs, millis, micros, nanos)
# 2022-04-28T14:32:10.123456789
```
The same constructors work given Periods
```
nd = NanoDate(Year(years))
# 2022-01-01T00:00:00

nd = NanoDate(Year(years), Month(months))
# 2022-06-01T00:00:00

nd = NanoDate(
    Year(years), Month(months), Day(days), 
    Hour(hours), Minute(mins), Second(secs))
# 2022-06-18T12:15:30

nd = NanoDate(
    Year(years), Month(months), Day(days), 
    Hour(hours), Minute(mins), Second(secs),
    Millisecond(millis), Microsecond(micros),
    Nanosecond(nanos))
# 2022-06-18T12:15:30.123456789
```

