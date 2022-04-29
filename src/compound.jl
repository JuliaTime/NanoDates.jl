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
    Year(dt) + Month(dt) + Day(dt)
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
    periods = canonicalize(cperiod).periods
    types = ntuple(i->typeof(periods[i]), length(periods))
    dt = Date0
    if Month in types
        dt -= Month(1)
    end
    if Day in types
        dt -= Day(1)
    end
    for (p, typ) in zip(periods, types)
        typ in (Hour, Minute, Second, Millisecond, Microsecond, Nanosecond) && continue
        dt += p
    end
    dt
end

function retype(::Type{DateTime}, cperiod::CompoundPeriod)
    periods = canonicalize(cperiod).periods
    types = ntuple(i->typeof(periods[i]), length(periods))
    dtm = DateTime0
    if Month in types
        dtm -= Month(1)
    end
    if Day in types
        dtm -= Day(1)
    end
    for (p, typ) in zip(periods, types)
        typ in (Microsecond, Nanosecond) && continue
        dtm += p
    end
    dtm
end

function retype(::Type{NanoDate}, cperiod::CompoundPeriod)
    periods = canonicalize(cperiod).periods
    types = ntuple(i->typeof(periods[i]), length(periods))
    nd = NanoDate0
    if Month in types
        nd -= Month(1)
    end
    if Day in types
        nd -= Day(1)
    end
    for (p, typ) in zip(periods, types)
        nd += p
    end
    nd
end

