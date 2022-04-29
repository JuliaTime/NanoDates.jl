## Getting Parts of a NanoDate

This works just the way it does with Date, Time, and DateTime.

You can use `year`, `month`, `day`, .., `nanosecond`
You can use `Year`, `Month`, `Day`, ... `Nanosecond`

```
using Dates, NanoDates

dayte = Date("2022-04-28")
tyme = Time(14, 32, 10, 123, 456, 789)
nanodate = NanoDate(dayte, tyme)

year(nanodate) == 2022
day(nanodate) == 10
hour(nanodate) == 14
nanosecond(nanodate) == 789

Year(nanodate) == Year(2022)
Day(nanodate) == Day(10)
Hour(nanodate) == Hour(14)
Nanosecond(nanodate) == Nanosecond(789)
```

## Adding/Subtracting Periods

This works just the way it does with Date, Time, and DateTime.

```
julia> nanodate
2022-04-28T14:32:10.123456789

julia> nanodate + Month(2)
2022-06-28T14:32:10.123456789

julia> nanodate + Month(2) + Second(35)
2022-06-28T14:32:45.123456789

julia> nanodate - Month(4)
2021-12-28T14:32:10.123456789

julia> nanodate - Month(4) - Hour(14)
2021-12-28T00:32:10.123456789

julia> nanodate - Month(4) - Hour(15)
2021-12-27T23:32:10.123456789
```