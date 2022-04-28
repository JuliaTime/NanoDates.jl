## Constructing NanoDates

All of the ways available to construct DateTimes work with NanoDates.  And there are a few additional constructors that make work microseconds and nanoseconds easier.  NanoDate constructors are best understood by example. We will set some variables for later clarity.

```
using Dates, NanoDates

# lets get the parts from Dates


years, months, days = (2022, 4, 28);
hours, mins, secs, millis, micros, nanos = 
  (14, 32, 10, 123, 456, 789);

adate = Date(years, months, days)
# 2022-04-28

atime = Time(hours, mins, secs, millis, micros, nanos)
# 14:32:10.123456789

# to get a DateTime from a Date and a Time safely
# > atime_ms = trunc(atime, Millisecond)
# > adatetime = DateTime(adate, atime_ms)
# NanoDates exports `date_time` that does this

adatetime = date_time(adate, atime)
# 2022-04-28T14:32:10.123
```
Here are familiar constructor methods.
```
ananodate = NanoDate(adate)
# 2022-04-28T00:00:00

ananodate = NanoDate(adatetime)
# 2022-04-28T14:32:10.123

ananodate = NanoDate(adate, atime)
# 2022-04-28T14:32:10.123456789
```
Here are some of the methods that values
```
ananodate = NanoDate(years)
# 2022-01-01T00:00:00

ananodate = NanoDate(years, months)
# 2022-04-01T00:00:00

ananodate = NanoDate(years, months, days, 
                     hours, mins, secs)
# 2022-04-28T14:32:10

ananodate = NanoDate(years, months, days, 
                     hours, mins, secs,
                     millis, micros, nanos)
# 2022-04-28T14:32:10.123456789
```
And some of the methods that take periods
```
ananodate = NanoDate(Year(years))
# 2022-01-01T00:00:00

ananodate = NanoDate(Year(years), Month(months))
# 2022-04-01T00:00:00

ananodate = NanoDate(
    Year(years), Month(months), Day(days), 
    Hour(hours), Minute(mins), Second(secs))
# 2022-04-28T14:32:10

ananodate = NanoDate(
    Year(years), Month(months), Day(days), 
    Hour(hours), Minute(mins), Second(secs),
    Millisecond(millis), Microsecond(micros),
    Nanosecond(nanos))
# 2022-04-28T14:32:10.123456789
```

