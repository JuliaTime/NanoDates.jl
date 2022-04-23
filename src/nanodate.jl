const Construct = Val{:NanoDate}
const Constructor = Construct()

struct NanoDate
    datetime::DateTime      # DateTime(UTM(microsec))
    nanosecs::Nanosecond    # Nanosecond(microsecond * 1_000 + nanosecond)

    NanoDate(::Construct, datetime::DateTime, nanosecs::Nanosecond) =
        new(datetime, nanosecs)
end

function NanoDate(datetime::DateTime, nanosecs::Nanosecond)
    nanos = value(nanosecs)
    0 <= nanos < 1_000_000 && return NanoDate(Constructor, datetime, nanosecs)

    millisecs = value(datetime)
    millis, nanos = divrem(nanos, NanosecondsPerMillisecond)
    datetime = DateTime(Dates.UTM(millisecs + millis))
    NanoDate(Constructor, datetime, Nanosecond(nanosecs))
end

NanoDate(x::NanoDate) = x

datetime(x::NanoDate) = x.datetime
nanosecs(x::NanoDate) = x.nanosecs

NanoDate(dt::DateTime, us::Microsecond) = NanoDate(dt, Nanosecond(value(us) * 1_000))
NanoDate(dt::DateTime, us::Microsecond, ns::Nanosecond) =
    NanoDate(dt, Nanosecond(value(us) * 1_000 + value(ns)))

NanoDate(d::Date, us::Microsecond) = NanoDate(DateTime(dt), us)
NanoDate(d::Date, ns::Nanosecond) = NanoDate(DateTime(d), ns)

NanoDate(dt::DateTime, ns::Int) = NanoDate(dt, Nanosecond(ns))
