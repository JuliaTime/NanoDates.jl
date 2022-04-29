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
    NanoDate(dt, nanosecs(us, ns))

NanoDate(dt::Date, us::Microsecond, ns::Nanosecond) = NanoDate(DateTime(dt), us, ns)
NanoDate(d::Date, us::Microsecond) = NanoDate(DateTime(dt), us)
NanoDate(d::Date, ns::Nanosecond) = NanoDate(DateTime(d), ns)

NanoDate(yr::Year, mn::Month=Month(1), dy::Day=Day(1)) = NanoDate(Date(yr, mn, dy))
NanoDate(yr::Year, mn::Month, dy::Day, hr::Hour, mi::Minute=Minute(0), sc::Second=Second(0),
    ms::Millisecond=Millisecond(0), us::Microsecond=Microsecond(0), ns::Nanosecond=Nanosecond(0)) =
    NanoDate(DateTime(yr, mn, dy, hr, mi, sc, ms), nanosecs(us, ns))

NanoDate(yr, mn=1, dy=1, hr=0, mi=0, sc=0, ms=0, us=0, ns=0) =
    NanoDate(DateTime(yr, mn, dy, hr, mi, sc, ms), nanosecs(us, ns))

NanoDate(cs::Microsecond, ns::Nanosecond) = NanoDate(DateTime0, nanosecs(cs,ns))
# for internal use

usns(ns) = ns
@inline usns(us, ns) = us * 1_000 + ns

nanosecs(ns) = Nanosecond(ns)
nanosecs(ns::Nanosecond) = ns
nanosecs(us::Microsecond) = Nanosecond(1_000 * value(us))
@inline nanosecs(us, ns) = Nanosecond(usns(us, ns))
@inline nanosecs(us::Microsecond, ns::Nanosecond) = nanosecs(value(us), value(ns))

NanoDate(dt::DateTime, x) = NanoDate(dt, nanosecs(x))
NanoDate(dt::DateTime, us, ns) = NanoDate(dt, nanosecs(us, ns))
NanoDate(d::Date, x) = NanoDate(d, nanosecs(x))
NanoDate(d::Date, us, ns) = NanoDate(d, nanosecs(us, ns))

NanoDate(dy::Day) = NanoDate(Date(UTD(dy)), Nanosecond0)
NanoDate(dy::Day, ns::Nanosecond) = NanoDate(Date(UTD(dy)), ns)
NanoDate(dy::Day, us::Microsecond) = NanoDate(Date(UTD(dy)), nanosecs(us))
NanoDate(dy::Day, us::Microsecond, ns::Nanosecond) = NanoDate(Date(UTD(dy)), nanosecs(us, ns))

NanoDate(ms::Millisecond) = NanoDate(DateTime(UTM(ms)), Nanosecond0)
NanoDate(ms::Millisecond, ns::Nanosecond) = NanoDate(DateTime(UTM(ms)), ns)
NanoDate(ms::Millisecond, us::Microsecond) = NanoDate(DateTime(UTM(ms)), nanosecs(us))
NanoDate(ms::Millisecond, us::Microsecond, ns::Nanosecond) = NanoDate(DateTime(UTM(ms)), nanosecs(us, ns))

NanoDate() = NanoDate(now())
NanoDate(::Type{UTC}) = NanoDate(now(UTC))

for T in (:Year, :Quarter, :Month, :Week, :Day,
            :Hour, :Minute, :Second, :Millisecond)
    @eval NanoDate(nd::NanoDate, x::$T) = NanoDate(nd.datetime - $T(nd) + x, nd.nanosecs)
end

for T in (:Microsecond, :Nanosecond)
    @eval NanoDates.NanoDate(nd::NanoDate, x::$T) = nd - $T(nd) + x
end

NanoDate(nd::NanoDate, cs::Microsecond, ns::Nanosecond) =
    nd - Microsecond(nd) - Nanosecond(nd) + ns + cs

NanoDate(nd::NanoDate, dtm::DateTime) =
    NanoDate(dtm, nd.nanosecs)
NanoDate(nd::NanoDate, tm::Time) =
    NanoDate(Date(nd.datetime),tm)
NanoDate(nd::NanoDate, dt::Date) =
    NanoDate(DateTime(dt, trunc(Time(nd.datetime), Millisecond)), nd.nanosecs)

const NanoDate0 = NanoDate(0,1,1,0,0,0,0,0,0)

