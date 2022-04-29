# reverse to process smaller period types before larger period types

Base.iterate(cperiod::CompoundPeriod) = iterate(reverse(cperiod.periods))
 
Base.iterate(cperiod::CompoundPeriod, state) = iterate(reverse(cperiod.periods), state)

function Base.:(+)(nd::NanoDate, cperiod::CompoundPeriod)
    for p in cperiod
        nd += p
    end
    nd
end
Base.:(+)(cperiod::CompoundPeriod, nd::NanoDate) = nd + cperiod

function Base.:(-)(nd::NanoDate, cperiod::CompoundPeriod)
    for p in cperiod
        nd -= p
    end
    nd
end

function retype(::Type{CompoundPeriod}, tm::Time)
    secs, subsecs = fldmod(value(tm), NanosecondsPerSecond)
    millis, nanos = fldmod(subsecs, NanosecondsPerMillisecond)
    micros, nanos = fldmod(nanos, NanosecondsPerMicrosecond)
    mins, secs = fldmod(secs, SecondsPerMinute)
    hours, mins = fldmod(mins, MinutesPerHour)
    Hour(hours) + Minute(mins) + Second(secs) + 
    Millisecond(millis) + Microsecond(micros) + Nanosecond(nanos)
end

function retype(::Type{CompoundPeriod}, dt::Date)
    yr,mn,dy = yearmonthday(dt)
    Year(yr) + Month(mn) + Day(dy)
end

retype(::Type{CompoundPeriod}, dtm::DateTime) =
    retype(CompoundPeriod, Date(dtm)) +
    retype(CompoundPeriod, Time(dtm))

retype(::Type{CompoundPeriod}, nd::NanoDate) =
    retype(CompoundPeriod, Date(nd)) +
    retype(CompoundPeriod, Time(nd))

function retype(::Type{Time}, cperiod::CompoundPeriod)
    cp = canonicalize(cperiod)
    tm = Time0
    for p in cp.periods
        typeof(p) in (Year, Quarter, Month, Week, Day) && continue
        tm += p
    end
    tm
end

function retype(::Type{Date}, cperiod::CompoundPeriod)
    cp = canonicalize(cperiod)
    dt = Date0
    for p in cp.periods
        typeof(p) in (Hour, Minute, Second, Millisecond, Microsecond, Nanosecond) && continue
        dt += p
    end
    dt
end

function retype(::Type{DateTime}, cperiod::CompoundPeriod)
    cp = canonicalize(cperiod)
    dtm = DateTime0
    for p in cp.periods
        typeof(p) in (Microsecond, Nanosecond) && continue
        dtm += p
    end
    dtm
end

function retype(::Type{NanoDate}, cperiod::CompoundPeriod)
    cp = canonicalize(cperiod)
    nd = NanoDate0
    for p in cp.periods
        nd += p
    end
    dtm
end

