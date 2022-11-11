Base.convert(::Type{NanoDate}, x::DateTime) = NanoDate(x, Nanosecond0)
Base.convert(::Type{NanoDate}, x::Date) = NanoDate(x, Nanosecond0)
Base.convert(::Type{NanoDate}, x::Time) = NanoDate(today(), Nanosecond0) + x.instant

Base.convert(::Type{DateTime}, x::NanoDate) = x.datetime
Base.convert(::Type{Date}, x::NanoDate) = Date(x.datetime)

function Base.convert(::Type{Time}, x::NanoDate)
    nanos = value(Time(x.datetime)) + value(x.nanosecs)
    Time(Nanosecond(nanos))
end

NanoDate(x::DateTime) = convert(NanoDate, x)
NanoDate(x::Date) = convert(NanoDate, x)
NanoDate(x::Time) = convert(NanoDate, x)

Dates.DateTime(x::NanoDate) = convert(DateTime, x)
Dates.Time(x::NanoDate) = convert(Time, x)
Dates.Date(x::NanoDate) = convert(Date, x)

#### External Conversions

nanodate2rata(nd::NanoDate) = datetime2rata(nd.datetime)

rata2nanodate(rata::Integer) = NanoDate(rata2datetime(rata))

function nanodate2unixnanos(nd::NanoDate)
    millis = (value(nd.datetime) - Dates.UNIXEPOCH)
    nanos  = (millis * Int128(NanosecondsPerMillisecond)) + value(nd.nanosecs)
    nanos
end

function nanodate2unixmicros(nd::NanoDate)
    nanos = nanodate2unixnanos(nd)
    div(nanos, 1_000)
end

function nanodate2unixmillis(nd::NanoDate)
    micros  = nanodate2unixnanos(nd)
    div(micros, 1_000_000)
end

function nanodate2unixseconds(nd::NanoDate)
    millis = nanodate2unixmillis(nd)
    div(millis, 1_000)
end

function unixnanos2nanodate(nanosecs)
    millis, micronanos = fldmod(nanosecs, 1_000_000)
    ndays, millis = fldmod(millis, 86400_000)
    dtm = DateTime(1970) + Day(ndays) + Millisecond(millis)
    NanoDate(dtm, Nanosecond(micronanos))
end

function unixmicros2nanodate(microsecs)
    unixnanos2nanodate(Int128(microsecs) * 1_000)
end

function unixmillis2nanodate(millisecs)
    unixnanos2nanodate(Int128(millisecs) * 1_000_000)
end

function unixseconds2nanodate(seconds)
    unixnanos2nanodate(Int128(seconds) * 1_000_000_000)
end

julian2nanodate(x) = NanoDate(julian2datetime(x))

nanodate2julian(nd::NanoDate) = datetime2julian(DateTime(nd))
