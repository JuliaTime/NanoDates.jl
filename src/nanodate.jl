struct NanoDate
    datetime::DateTime      # DateTime(UTM(microsec))
    nanosecs::Nanosecond    # Nanosecond(microsecond * 1_000 + nanosecond)

    function NanoDate(datetime::DateTime, nanosecs::Nanosecond)
        nanos = value(nanosecs)
        0 <= nanos < 1_000_000 && return new(datetime, nanosecs)

        millisecs = value(datetime)
        millis, nanos = divrem(nanos, NanosecondsPerMillisecond)
        datetime = DateTime(Dates.UTM(millisecs + millis))
        new(datetime, Nanosecond(nanosecs))
    end
end

NanoDate(x::NanoDate) = x

datetime(x::NanoDate) = x.datetime
nanosecs(x::NanoDate) = x.nanosecs

NanoDate(dt::DateTime, us::Microsecond) = NanoDate(dt, Nanosecond(value(us) * 1_000))
NanoDate(dt::DateTime, us::Microsecond, ns::Nanosecond) =
    NanoDate(dt, Nanosecond(value(us) * 1_000 + value(ns)))

NanoDate(dt::Date, us::Microsecond, ns::Nanosecond) = NanoDate(DateTime(dt), us, ns)
NanoDate(d::Date, us::Microsecond) = NanoDate(DateTime(dt), us)
NanoDate(d::Date, ns::Nanosecond) = NanoDate(DateTime(d), ns)

NanoDate(yr::Year, mn::Month=Month(1), dy::Day=Day(1)) = NanoDate(Date(yr, mn, dy))
NanoDate(yr::Year, mn::Month, dy::Day, hr::Hour, mi::Minute=Minute(0), sc::Second=Second(0),
    ms::Millisecond=Millisecond(0), us::Microsecond=Microsecond(0), ns::Nanosecond=Nanosecond(0)) =
    NanoDate(DateTime(yr, mn, dy, hr, mi, sc, ms), us, ns)

NanoDate(yr, mn=1, dy=1)) = NanoDate(Date(yr, mn, dy))
NanoDate(yr, mn, dy, hr, mi=0, sc=0, ms=0, us=0, ns=0)) = 
    NanoDate(DateTime(yr, mn, dy, hr, mi, sc, ms), Nanosecond(value(us) * 1_000 + value(ns)))

# for internal use

usns(ns) = ns
usns(us, ns) = us * 1_000 + ns

nanosecs(ns) = Nanosecond(ns)
nanosecs(ns::Nanosecond) = ns
nanosecs(us::Microsecond) = Nanosecond(1_000 * value(us))
nanosecs(us, ns) = Nanosecond(usns(us, ns))
nanosecs(us::Microsecond, ns::Nanosecond) = nanosecs(value(us), value(ns))

NanoDate(dt::DateTime, x) = NanoDate(dt, nanosecs(x))
NanoDate(dt::DateTime, us, ns) = NanoDate(dt, nanosecs(us, ns))
NanoDate(d::Date, x) = NanoDate(d, nanosecs(x))
NanoDate(d::Date, us, ns) = NanoDate(d, nanosecs(us, ns))

NanoDate(; millis=0, us=0, ns=0) = NanoDate(DateTime(UTM(millis)), nanosecs(us, ns))

const DateOrDateTime = value(DateTime(1,1,1))
datedatetime(x) = (abs(x) < DateOrDateTime) ? Date(UTD(x)) : DateTime(UTM(x))