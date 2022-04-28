## Getting Parts of a NanoDate

This works just the way it does with Date, Time, and DateTime.

```
using Dates, NanoDates

adate = Date("2022-04-28")
atime = Time(14, 32, 10, 123, 456, 789)
nanodate = NanoDate(adate, atime)

