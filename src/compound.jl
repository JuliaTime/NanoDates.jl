Base.iterate(cperiod::CompoundPeriod) = iterate(cperiod.periods)
 
Base.iterate(cperiod::CompoundPeriod, state) = iterate(cperiod.periods, state)

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

Base.(+)(nd::NanoDate, tm::Time) =
    nd + convert(CompoundPeriod, tm)

Base.(-)(nd::NanoDate, tm::Time) =
    nd - convert(CompoundPeriod, tm)

