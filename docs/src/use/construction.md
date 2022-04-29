## Constructing NanoDates

All of the ways available to construct DateTimes work with NanoDates.  And there are a few additional constructors that make work microseconds and nanoseconds easier.  NanoDate constructors are best understood by example. We will set some variables for later clarity.

```
using Dates, NanoDates

# lets get the parts from Dates

years, months, days = (2022, 4, 28);
hours, mins, secs, millis, micros, nanos = 
  (14, 32, 10, 123, 456, 789);

dayt = Date(years, months, days)
# 2022-04-28

tyme = Time(hours, mins, secs, millis, micros, nanos)
# 14:32:10.123456789

# to get a DateTime from a Date and a Time safely
# > tyme_ms = trunc(tyme, Millisecond)
# > daytime = DateTime(dayt, tyme_ms)
# NanoDates exports `date_time` that does this

daytime = date_time(dayt, tyme)
# 2022-04-28T14:32:10.123
```
Here are familiar constructor methods.
```
nd = NanoDate(dayt)
# 2022-04-28T00:00:00

nd = NanoDate(daytime)
# 2022-04-28T14:32:10.123

nd = NanoDate(dayt, tyme)
# 2022-04-28T14:32:10.123456789
```
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

