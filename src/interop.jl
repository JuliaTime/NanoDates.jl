Base.promote_rule(::Type{NanoDate}, ::Type{DateTime}) = NanoDate
Base.promote_rule(::Type{NanoDate}, ::Type{Date}) = NanoDate
Base.promote_rule(::Type{NanoDate}, ::Type{Time}) = NanoDate

# important for NanoDates ease of use with DateTime values
date_time(d::Date, t::Time) = DateTime(d, trunc(t, Millisecond))

# similar to `Dates.now()`, with subsecond support

# enhance `today()`
Dates.today(::Type{UTC}) = Date(now(UTC))

ndnow() = NanoDate(now())
ndnow(ns::Nanosecond) = NanoDate(now(), nanosecs(ns))
ndnow(ms::Microsecond) = NanoDate(now(), nanosecs(ms))
ndnow(ms::Microsecond, ns::Nanosecond) = NanoDate(now(), nanosecs(ms, ns))
ndnow(cs::Integer, ns::Integer=0) = NanoDate(now(), nanosecs(cs, ns))

ndnow(::Type{UTC}) = NanoDate(now(UTC))
ndnow(::Type{UTC}, ns::Nanosecond) = NanoDate(now(UTC), nanosecs(ns))
ndnow(::Type{UTC}, ms::Microsecond) = NanoDate(now(UTC), nanosecs(ms))
ndnow(::Type{UTC}, ms::Microsecond, ns::Nanosecond) = NanoDate(now(UTC), nanosecs(ms, ns))
ndnow(::Type{UTC}, subsecs) = NanoDate(now(UTC), nanosecs(subsecs))
ndnow(::Type{UTC}, cs::Integer, ns::Integer=0) = NanoDate(now(), nanosecs(cs, ns))

ndtoday() = NanoDate(today())
ndtoday(::Type{UTC}) = NanoDate(Dates.today(UTC))

function datetime2datetime(dtm::DateTime)
    millis = Dates.value(dtm)
    datemillis, timemillis = fldmod(millis, MillisecondsPerDay)
    Date(UTD(datemillis)), Time(Nanosecond(timemillis * 1_000_000))
end

datetime2datetime(date::Date, time::Time) =
    DateTime(date, trunc(time, Millisecond))
