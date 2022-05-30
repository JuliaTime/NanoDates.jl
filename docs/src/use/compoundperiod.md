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
using Dates: CompoundPeriod
```
##### note these are given smallest period .. largest
```
const TimeStampPeriods = 
    (Nanosecond, Microsecond, Millsecond, Second, Minute, Hour)
const DateStampPeriods = (Day, Month, Year)

const TimeStampPeriods = 
    (Nanosecond, Microsecond, Millsecond, Second, Minute, Hour)
const DateLikePeriods  = (Day, Week, Month, Quarter, Year)

const NanoStampPeriods =
    (Nanosecond, Microsecond, Millsecond, Second, Minute, Hour,
     Day, Week, Month, Quarter, Year)
```
### nothing to see, nothing to here
```
date = Date(2022, 6, 3)   # 2022-06-03  
CompoundPeriod(date)      # 2022 years, 6 months, 3 days
Date(ans)                 # 2022-06-03

compound_date = CompoundPeriod(Date("2022-06-03"))
Date(compound_date) == Date("2022-06-03")
```
