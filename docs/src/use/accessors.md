## Getting Parts of a NanoDate

This works just the way it does with Date, Time, and DateTime.

You can use `year`, `month`, `day`, .., `nanosecond`
You can use `Year`, `Month`, `Day`, ... `Nanosecond`

```
using Dates, NanoDates

adate = Date(years, months, days)
# 2022-06-18

atime = Time(hours, mins, secs, millis, micros, nanos)
# 12:15:30.123456789

nanodate = NanoDate(adate, atime)
# 2022-06-18T12:15:30.123456789

year(nanodate) == 2022
day(nanodate)  == 18
hour(nanodate) == 12
nanosecond(nanodate) == 789

Year(nanodate) == Year(2022)
Day(nanodate)  == Day(18)
Hour(nanodate) == Hour(12)
Nanosecond(nanodate) == Nanosecond(789)
```

## Adding/Subtracting Periods

This works just the way it does with Date, Time, and DateTime.

```
julia> nanodate
2022-06-18T12:15:30.123456789

julia> nanodate + Month(4)
2022-10-28T14:32:10.123456789

julia> nanodate + Month(7)
2023-01-28T14:32:10.123456789

julia> nanodate - Month(6) - Day(18)
2021-11-30T12:15:30.123456789

julia> nanodate - Microsecond(456)
2021-12-28T14:32:10.123000789

julia> nanodate - Nanosecond(456789)
2021-12-28T00:32:10.123
```