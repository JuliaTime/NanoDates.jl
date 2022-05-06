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

# note these are given smallest period .. largest

const TimeStampPeriods = 
    (Nanosecond, Microsecond, Millsecond, Second, Minute, Hour)
const DateStampPeriods = (:Day, ::Month, :Year)

const TimeStampPeriods = 
    (Nanosecond, Microsecond, Millsecond, Second, Minute, Hour)
const DateLikePeriods  = (:Day, :Week, :Month, :Quarter, :Year)
