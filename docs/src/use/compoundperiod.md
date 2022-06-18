## CompoundPeriods and Period Compounding

The primary Time, Date, and Date-with-Time types are
individually seperable into and reintegrable from
appropriately constituted CompoundPeriods.

`CompoundPeriod` is a type internal to `Dates` that
is the construct obtained when two (or more)
distinct DatePeriods aor TimePeriods are
additively combinded.

```
using Dates, NanoDates
```
##### note these are given smallest period .. largest
```
const TimeStampPeriods = 
    (Nanosecond, Microsecond, Millisecond, Second, Minute, Hour);

const DateStampPeriods = (Day, Month, Year);

const DateLikePeriods  = (Day, Week, Month, Quarter, Year);

const NanoStampPeriods = (TimeStampPeriods..., DateLikePeriods...)
    (Nanosecond, Microsecond, Millisecond, Second, Minute, Hour,
     Day, Week, Month, Quarter, Year)
```
### nothing to see, nothing to here
```
adate = Date(2022, 6, 3)   # 2022-06-03  
CompoundPeriod(adate)      # 2022 years, 6 months, 3 days
Date(ans)                  # 2022-06-03

compound_date = CompoundPeriod(Date("2022-06-03"));
Date(compound_date) == adate  # true

atime = Time("12:15:30.123456789");
btime = Time(12, 15, 30, 123, 456, 789)
atime == btime # true
compound_time = CompoundPeriod(atime)
# 12 hours, 15 minutes, 30 seconds, 123 milliseconds, 456 microseconds, 789 nanoseconds

nd = NanoDate(adate, atime)
2022-06-03T12:15:30.123456789

compound_nd = CompoundPeriod(nd)
2022 years, 6 months, 3 days, 12 hours, 15 minutes, 30 seconds, 123 milliseconds, 456 microseconds, 789 nanoseconds

NanoDate(compound_nd) == nd
# true
```
