struct Nano_Day <: Dates.AbstractTime
    days::Day
    nanosecs::Nanosecond
end

function NanoDay(days::Day, nanosecs::Nanosecond)
    dy, ns = Dates.value(days), Dates.value(nanosecs)
    if 0<= ns < NanosecondsPerDay
        Nano_Day(days, nanosecs)
    else
       ddy, ns = fldmod(ns, NanosecondsPerDay)
       dy += ddy
       Nano_Day(Day(dy), Nanosecond(ns))
    end
end

NanoDay(datetime::DateTime) =
    Nano_Day(Date(datetime).instant.periods, Time(datetime).instant)

NanoDay(date::Date) =
    Nano_Day(Date(datetime).instant.periods, Nanosecond0)

NanoDay(time::Time) =
    Nano_Day(Day0, time.instant)

NanoDay(nd::NanoDate) =
    Nano_Day(Date(nd).instant.periods, Time(nd).instant)

Base.:(+)(nd::Nano_Day, wk::Week) =
    Nano_Day(Day(Dates.value(nd.days) + Dates.value(wk) * DaysPerWeek), nd.nanosecs)

Base.:(+)(nd::Nano_Day, dy::Day) =
    Nano_Day(nd.days + dy, nd.nanosecs)

Base.:(+)(nd::Nano_Day, hr::Hour) =
    NanoDay(nd.days, Nanosecond(Dates.value(nd.nanosecs) + Dates.value(hr) * NanosecondsPerHour))

Base.:(+)(nd::Nano_Day, mi::Minute) =
    NanoDay(nd.days, Nanosecond(Dates.value(nd.nanosecs) + Dates.value(mi) * NanosecondsPerMinute))

Base.:(+)(nd::Nano_Day, sc::Second) =
    NanoDay(nd.days, Nanosecond(Dates.value(nd.nanosecs) + Dates.value(sc) * NanosecondsPerSecond))

Base.:(+)(nd::Nano_Day, ms::Millisecond) =
    NanoDay(nd.days, Nanosecond(Dates.value(nd.nanosecs) + Dates.value(ms) * NanosecondsPerMillisecond))

Base.:(+)(nd::Nano_Day, cs::Microsecond) =
    NanoDay(nd.days, Nanosecond(Dates.value(nd.nanosecs) + Dates.value(ms) * NanosecondsPerMicrosecond))

Base.:(+)(nd::Nano_Day, ns::Nanosecond) =
    NanoDay(nd.days, Nanosecond(Dates.value(nd.nanosecs) + Dates.value(ns)))


Base.:(-)(nd::Nano_Day, wk::Week) =
    Nano_Day(Day(Dates.value(nd.days) - Dates.value(wk) * DaysPerWeek), nd.nanosecs)

Base.:(-)(nd::Nano_Day, dy::Day) =
    Nano_Day(nd.days - dy, nd.nanosecs)

Base.:(-)(nd::Nano_Day, hr::Hour) =
    NanoDay(nd.days, Nanosecond(Dates.value(nd.nanosecs) - Dates.value(hr) * NanosecondsPerHour))

Base.:(-)(nd::Nano_Day, mi::Minute) =
    NanoDay(nd.days, Nanosecond(Dates.value(nd.nanosecs) - Dates.value(mi) * NanosecondsPerMinute))

Base.:(-)(nd::Nano_Day, sc::Second) =
    NanoDay(nd.days, Nanosecond(Dates.value(nd.nanosecs) - Dates.value(sc) * NanosecondsPerSecond))

Base.:(-)(nd::Nano_Day, ms::Millisecond) =
    NanoDay(nd.days, Nanosecond(Dates.value(nd.nanosecs) - Dates.value(ms) * NanosecondsPerMillisecond))

Base.:(-)(nd::Nano_Day, cs::Microsecond) =
    NanoDay(nd.days, Nanosecond(Dates.value(nd.nanosecs) - Dates.value(ms) * NanosecondsPerMicrosecond))

Base.:(-)(nd::Nano_Day, ns::Nanosecond) =
    NanoDay(nd.days, Nanosecond(Dates.value(nd.nanosecs) - Dates.value(ns)))


