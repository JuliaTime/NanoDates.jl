## Constructing NanoDates

All of the ways available to construct DateTimes work with NanoDates.  And there are a few additional constructors that make work microseconds and nanoseconds easier.  NanoDate constructors are best understood by example. We will set some variables for later clarity.

```
using Dates, NanoDates

# lets establish the values for each period

years, months, days   = (2022,  6,  18)
hours, mins, secs     = (12,   15,  30)
millis, micros, nanos = (123, 456, 789)

adate = Date(years, months, days)
# 2022-05-18

atime = Time(hours, mins, secs, millis, micros, nanos)
# 12:15:30.123456789
```

Here are familiar constructor methods.
```
nd = NanoDate(adate)
# 2022-05-18T00:00:00

nd = NanoDate(adatetime)
# 2022-05-18T12:15:20.123

nd = NanoDate(adate, atime)
# 2022-05-18T12:15:30.123456789
```


enhancement: `date_time` is safe from InexactErrors
```
adatetime = date_time(adate, atime)
# 2022-05-18T12:15:30.123
```
