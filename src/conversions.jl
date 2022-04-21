Base.convert(::Type{NanoDate}, x::DateTime) = NanoDate(x, Nanosecond0)
Base.convert(::Type{NanoDate}, x::Date) = NanoDate(x, Nanosecond0)
Base.convert(::Type{NanoDate}, x::Time) = NanoDate(today(), Nanosecond0)

Base.convert(::Type{DateTime}, x::NanoDate) = x.datetime
Base.convert(::Type{Date}, x::NanoDate) = Date(x.datetime)

function Base.convert(::Type{Time}, x::NanoDate)
    nanos = value(Time(x.datetime)) + x.nanosecs
    Time(Nanosecond(nanos))
end

NanoDate(x::DateTime) = convert(NanoDate, x)
NanoDate(x::Date) = convert(NanoDate, x)
NanoDate(x::Time) = convert(NanoDate, x)

Dates.DateTime(x::NanoDate) = convert(Time, x)
Dates.Time(x::NanoDate) = convert(Time, x)
Dates.Date(x::NanoDate) = convert(Date, x)

#### Additional Constructors

function NanoDate(date::Date, time::Time)
    slowtime, fasttime = fldmod(value(time), NanosecondsPerMillisecond)
    datetime = DateTime(date) + Millisecond(slowtime)
    NanoDate(datetime, Nanosecond(fasttime))
end


#### External Conversions

nanodate2rata(nd::NanoDate) = datetime2rata(nd.datetime)

rata2nanodate(rata::Integer) = NanoDate(rata2datetime(rata))

function nanodate2unix(nd::NanoDate)
    millis = (value(nd) - Dates.UNIXEPOCH)
    nanos  = (millis * NanosecondsPerMillisecond) + nd.nanosecs
    nanos / NanosecondsPerMillisecond
end

function unix2nanodate(x)
    nanos = x * NanosecondsPerMillisecond
    millis, nanos = fldmod(nanos, NanosecondsPerMicrosecond)
    NanoDate(DateTime(Dates.UTM(millis)), nanos)
end


julian2nanodate(x) = NanoDate(julian2datetime(x))

nanodate2julian(nd::NanoDate) = datetime2julian(DateTime(nd))

