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

NanoDate(dt::DateTime, ns::Int) = NanoDate(dt, Nanosecond(ns))
