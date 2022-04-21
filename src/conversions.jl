Base.convert(::Type{NanoDate}, x::DateTime) = NanoDate(x, Time0)
Base.convert(::Type{NanoDate}, x::Date) = NanoDate(x, Time0)
Base.convert(::Type{NanoDate}, x::Time) = NanoDate(today(), Time0)

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

