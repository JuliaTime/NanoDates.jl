## Construction by Specification

Here are some of the methods that take values
```
nd = NanoDate(years)
# 2022-01-01T00:00:00

nd = NanoDate(years, months)
# 2022-04-01T00:00:00

nd = NanoDate(years, months, days, 
              hours, mins, secs)
# 2022-04-28T14:32:10

nd = NanoDate(years, months, days, 
              hours, mins, secs,
              millis, micros, nanos)
# 2022-04-28T14:32:10.123456789
```
And some of the methods that take periods
```
nd = NanoDate(Year(years))
# 2022-01-01T00:00:00

nd = NanoDate(Year(years), Month(months))
# 2022-04-01T00:00:00

nd = NanoDate(
    Year(years), Month(months), Day(days), 
    Hour(hours), Minute(mins), Second(secs))
# 2022-04-28T14:32:10

nd = NanoDate(
    Year(years), Month(months), Day(days), 
    Hour(hours), Minute(mins), Second(secs),
    Millisecond(millis), Microsecond(micros),
    Nanosecond(nanos))
# 2022-04-28T14:32:10.123456789
```

