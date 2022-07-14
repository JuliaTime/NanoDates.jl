Base.promote_rule(::Type{NanoDate}, ::Type{DateTime}) = NanoDate
Base.promote_rule(::Type{NanoDate}, ::Type{Date}) = NanoDate
Base.promote_rule(::Type{NanoDate}, ::Type{Time}) = NanoDate

# important for NanoDates ease of use with DateTime values
date_time(d::Date, t::Time) = DateTime(d, trunc(t, Millisecond))

# similar to `Dates.now()`, with subsecond support

# enhance `today()`
Dates.today(::Type{UTC}) = Date(now(UTC))
Dates.today(::Type{LOCAL}) = Date(now())

ndtoday(::Type{UTC}) = NanoDate(Dates.today(UTC))
ndtoday(::Type{LOCAL}) = NanoDate(Dates.today())

function datetime2datetime(dtm::DateTime)
    millis = Dates.value(dtm)
    datemillis, timemillis = fldmod(millis, MillisecondsPerDay)
    Date(UTD(datemillis)), Time(Nanosecond(timemillis * 1_000_000))
end

datetime2datetime(date::Date, time::Time) =
    DateTime(date, trunc(time, Millisecond))

Dates.value(nd::NanoDate) =
    Int128(Dates.value(nd.datetime)) * Int128(1_000_000) + Dates.value(nd.nanosecs)

function NanoDate(nanos::Integer)
    ns = Int128(nanos)
    millis, submillis = fldmod(nanos, 1_000_000)
    NanoDate(DateTime(Dates.UTM(millis)), Nanosecond(submillis))
end
