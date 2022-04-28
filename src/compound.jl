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

function Base.convert(::Type{CompoundPeriod}, tm::Time)
    secs, subsecs = fldmod(value(tm), NanosecondsPerSecond)
    millis, nanos = fldmod(subsecs, NanosecondsPerMillisecond)
    micros, nanos = fldmod(nanos, NanosecondsPerMicrosecond)
    mins, secs = fldmod(secs, SecondsPerMinute)
    hours, mins = fldmod(mins, MinutesPerHour)
    Hour(hours) + Minute(mins) + Second(secs) + 
    Millisecond(millis) + Microsecond(micros) + Nanosecond(nanos)
end

Base.convert(::Type{CompoundPeriod}, dt::Date)
    yr,mn,dy = yearmonthday(dt)
    Year(yr) + Month(mn) + Day(dy)
end

Base.convert(::Type{CompoundPeriod}, dtm::DateTime) =
    convert(CompoundPeriod, Date(dtm)) +
    convert(CompoundPeriod, Time(dtm))
end

Base.convert(::Type{CompoundPeriod}, nd::NanoDate) =
    convert(CompoundPeriod, Date(nd)) +
    convert(CompoundPeriod, Time(nd))
end

Base.convert(::Type{Time}, cperiod::CompoundPeriod)
    cp = canonicalize(cperiod)
    tm = Time0
    for p in cp.periods
        typeof(p) in (Year, Quarter, Month, Week, Day) && continue
        tm += p
    end
    tm
end

Base.convert(::Type{Date}, cperiod::CompoundPeriod)
    cp = canonicalize(cperiod)
    dt = Date0
    for p in cp.periods
        typeof(p) in (Hour, Minute, Second, Millisecond, Microsecond, Nanosecond) && continue
        dt += p
    end
    dt
end

Base.convert(::Type{DateTime}, cperiod::CompoundPeriod)
    cp = canonicalize(cperiod)
    dtm = DateTime0
    for p in cp.periods
        typeof(p) in (Microsecond, Nanosecond) && continue
        dtm += p
    end
    dtm
end

Base.convert(::Type{NanoDate}, cperiod::CompoundPeriod)
    cp = canonicalize(cperiod)
    nd = NanoDate0
    for p in cp.periods
        nd += p
    end
    dtm
end


Base.:(+)(nd::NanoDate, tm::Time) =
    nd + convert(CompoundPeriod, tm)

Base.:(-)(nd::NanoDate, tm::Time) =
    nd + (-convert(CompoundPeriod, tm))


