Base.promote_rule(::Type{NanoDate}, ::Type{DateTime}) = NanoDate
Base.promote_rule(::Type{NanoDate}, ::Type{Date}) = NanoDate
Base.promote_rule(::Type{NanoDate}, ::Type{Time}) = NanoDate

# important for NanoDates ease of use with DateTime values
date_time(d::Date, t::Time) = DateTime(d, trunc(t, Millisecond))

# similar to `Dates.now()`, with subsecond support

nnow() = NanoDate(now())
nnow(ns::Nanosecond) = NanoDate(now(), nanosecs(ns))
nnow(ms::Microsecond) = NanoDate(now(), nanosecs(ms))
nnow(ms::Microsecond, ns::Nanosecond) = NanoDate(now(), nanosecs(ms, ns))
nnow(cs::Integer, ns::Integer=0) = NanoDate(now(), nanosecs(cs, ns))

nnow(::Type{UTC}) = NanoDate(now(UTC))
nnow(::Type{UTC}, ns::Nanosecond) = NanoDate(now(UTC), nanosecs(ns))
nnow(::Type{UTC}, ms::Microsecond) = NanoDate(now(UTC), nanosecs(ms))
nnow(::Type{UTC}, ms::Microsecond, ns::Nanosecond) = NanoDate(now(UTC), nanosecs(ms, ns))
nnow(::Type{UTC}, subsecs) = NanoDate(now(UTC), nanosecs(subsecs))
nnow(::Type{UTC}, cs::Integer, ns::Integer=0) = NanoDate(now(), nanosecs(cs, ns))

ntoday() = NanoDate(today())
ntoday(::Type{UTC}) = NanoDate(Date(now(UTC)))

function datetime2datetime(dtm::DateTime)
    millis = Dates.value(dtm)
    datemillis, timemillis = fldmod(millis, MillisecondsPerDay)
    Date(UTD(datemillis)), Time(Nanosecond(timemillis * 1_000_000))
end

datetime2datetime(date::Date, time::Time) =
    DateTime(date, trunc(time, Millisecond))
