for T in (:Year, :Quarter, :Month, :Week, :Day, :Hour, :Minute, :Second, :Millisecond)
  @eval begin
    Base.:(+)(nd::NanoDate, x::$T) = NanoDate(nd.datetime + x, nd.nanosecs)
    Base.:(-)(nd::NanoDate, x::$T) = NanoDate(nd.datetime - x, nd.nanosecs)
  end
end

function Base.:(+)(nd::NanoDate, x::Nanosecond)
    nanos = value(nd.nanosecs) + value(x)
    millis, nanos = fldmod(nanos, NanosecondsPerMillisecond)
    NanoDate(nd.datetime + Millisecond(millis), Nanosecond(nanos))
end

function Base.:(+)(nd::NanoDate, x::Microsecond)
    nanos = value(nd.nanosecs) + (value(x) * NanosecondsPerMicrosecond)
    millis, nanos = fldmod(nanos, NanosecondsPerMillisecond)
    NanoDate(nd.datetime + Millisecond(millis), Nanosecond(nanos))
end

function Base.:(-)(nd::NanoDate, x::Nanosecond)
    nanos = value(nd.nanosecs) - value(x)
    millis, nanos = fldmod(nanos, NanosecondsPerMillisecond)
    NanoDate(nd.datetime + Millisecond(millis), Nanosecond(nanos))
end

function Base.:(-)(nd::NanoDate, x::Microsecond)
    nanos = value(nd.nanosecs) - (value(x) * NanosecondsPerMicrosecond)
    millis, nanos = fldmod(nanos, NanosecondsPerMillisecond)
    NanoDate(nd.datetime + Millisecond(millis), Nanosecond(nanos))
end

    