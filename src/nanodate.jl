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

Base.convert(::Type{NanoDate}, x::DateTime) = NanoDate(DateTime(x), Time0)
Base.convert(::Type{NanoDate}, x::Date) = NanoDate(x, Time0)
Base.convert(::Type{NanoDate}, x::Time) = NanoDate(today(), Time0)

Base.convert(::Type{DateTime}, x::NanoDate) = x.datetime
Base.convert(::Type{Date}, x::NanoDate) = Date(x.datetime)
function Base.convert(::Type{Time}, x::NanoDate)
    nanos = value(Time(x.datetime)) + x.nanosecs
    Time(Nanosecond(nanos))
end

NanoDate(x::DateTime) = convert(::Type{NanoDate}, x)
Dates.Time(x::NanoDate) = convert(Time, x)
Dates.Date(x::NanoDate) = convert(Date, x)



