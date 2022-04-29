#=
function Base.:(-)(x::NanoDate, y::NanoDate)
    canonicalize((x.datetime - y.datetime) + canonicalize(x.nanosecs - y.nanosecs))
end
Base.:(-)(x::NanoDate, y::DateTime) = (-)(promote(x,y)...)
Base.:(-)(x::NanoDate, y::Date) = (-)(promote(x,y)...)
Base.:(-)(x::DateTime, y::NanoDate) = (-)(promote(x,y)...)
Base.:(-)(x::Date, y::NanoDate) = (-)(promote(x,y)...)

function Base.:(-)(x::NanoDate, y::Time)
    ymillis, ynanos = fldmod(value(y), NanosecondsPerMillisecond)
    xynanos = Nanosecond(value(x.nanosecs) + ynanos)
    (x + Millisecond(ymillis)) + xynanos
end
=#

function Base.:(-)(nd1::NanoDate, nd2::NanoDate)
    nd2cs, nd2ns = fldmod(value(nd2.nanosecs), NanosecondsPerMicrosecond)
    nd2sc, nd2ms = fldmod(value(nd2.datetime), MillisecondsPerSecond)
    nd2mi, nd2sc = fldmod(nd2sc, SecondsPerMinute)
           nd2mi = mod(nd2mi, MinutesPerHour)
    nd2hr = hour(nd2)
    nd2dy = day(nd2)
    nd2mn = month(nd2)
    nd2yr = year(nd2)

    nd1cs, nd1ns = fldmod(value(nd1.nanosecs), NanosecondsPerMicrosecond)
    nd1sc, nd1ms = fldmod(value(nd1.datetime), MillisecondsPerSecond)
    nd1mi, nd1sc = fldmod(nd1sc, SecondsPerMinute)
           nd1mi = mod(nd1mi, MinutesPerHour)
    nd1hr = hour(nd1)
    nd1dy = day(nd1)
    nd1mn = month(nd1)
    nd1yr = year(nd1)

    ymd = canonicalize(Year(nd1yr - nd2yr) + Month(nd1mn - nd2mn) + Day(nd1dy - nd2dy))
    hms = canonicalize(Hour(nd1hr - nd2hr) + Minute(nd1mi - nd2mi) + Second(nd1sc - nd2sc))
    mcn = canonicalize(Millisecond(nd1ms - nd2ms) + Microsecond(nd1cs - nd2cs) + Nanosecond(nd1ns - nd2ns))
    hmsmcn = canonicalize(hms + mcn)
    canonicalize(ymd + hmsmcn)
end

Base.:(-)(nd::NanoDate, dtm::DateTime) = (-)(promote(nd, dtm)...)

Base.:(-)(dtm::DateTime, nd::NanoDate) = (-)(promote(nd, dtm)...)

Base.:(-)(nd::NanoDate, dt::Date) = (-)(promote(nd, dt)...)

Base.:(-)(nd::NanoDate, tm::Time) = (-)(promote(nd, tm)...)


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

# trunc, floor, ceil

for T in (:Year, :Quarter, :Month, :Week, :Day, :Hour, :Minute, :Second)
  @eval begin
    Base.trunc(nd::NanoDate, ::Type{$T}) = NanoDate(trunc(nd.datetime, $T))
    Base.floor(nd::NanoDate, ::Type{$T}) = trunc(nd, $T)
    Base.ceil(nd::NanoDate, ::Type{$T}) = NanoDate(ceil(nd.datetime, $T))
  end  
end

Base.trunc(nd::NanoDate, ::Type{Millisecond}) = NanoDate(trunc(nd.datetime, Millisecond))
Base.floor(nd::NanoDate, ::Type{Millisecond}) = trunc(nd, Millisecond)
Base.ceil(nd::NanoDate, ::Type{Millisecond}) =
    NanoDate(nd.datetime) + Millisecond(!iszero(nd.nanosecs))

function Base.trunc(nd::NanoDate, ::Type{Microsecond})
    cs, ns = fldmod(value(nd.nanosecs), NanosecondsPerMicrosecond)
    NanoDate(nd.datetime, nanosecs(Microsecond(cs)))
end
Base.floor(nd::NanoDate, ::Type{Microsecond}) = trunc(nd, Microsecond)
function Base.ceil(nd::NanoDate, ::Type{Microsecond})
    cs, ns = fldmod(value(nd.nanosecs), NanosecondsPerMicrosecond)
    NanoDate(nd.datetime, nanosecs(Microsecond(cs))) + Microsecond(!iszero(ns))
end

Base.trunc(nd::NanoDate, ::Type{Nanosecond}) = nd
Base.floor(nd::NanoDate, ::Type{Nanosecond}) = nd
Base.ceil(nd::NanoDate, ::Type{Nanosecond}) = nd

# trunc, floor, ceil for Dates.Time type

for T in (:Minute, :Second, :Millisecond, :Microsecond)
  @eval begin
    Base.floor(tm::Time, ::Type{$T}) = trunc(nd, $T)
    Base.ceil(tm::Time, ::Type{$T}) = NanoDate(ceil(nd.datetime, $T))
  end  
end

Base.floor(tm::Time, ::Type{Hour}) = tm - Hour(tm)
function Base.ceil(tm::Time, ::Type{Hour})
    nanos = value(tm)
    hr, rest = fldmod(nanos, NanosecondsPerHour)
    if hr < 24
       iszero(rest) ? (tm, Day(0)) : (tm + Hour(1), Day(0))
    elseif iszero(rest)
       (tm, Day(0))
    else
       (tm-Hour(tm), Day(1))
    end
end

Base.floor(tm::Time, ::Type{Nanosecond}) = tm
Base.ceil(tm::Time, ::Type{Nanosecond}) = tm

# rounding

for T in (:Year, :Quarter, :Month, :Week, :Day, :Hour, :Minute, :Second,
            :Millisecond, :Microsecond)
  @eval begin
    Base.round(nd::NanoDate, ::Type{$T}, ::RoundingMode{:Down}) = floor(nd, $T)
    Base.round(nd::NanoDate, ::Type{$T}, ::RoundingMode{:Up}) = ceil(nd, $T)
    function Base.round(nd::NanoDate, ::Type{$T}, ::RoundingMode{:NearestTiesUp})
        up = round(nd, $T, RoundUp)
        down = round(nd, $T, RoundDown)
        (up - nd) <= (nd - down) ? up : down
    end
    Base.round(nd::NanoDate, ::Type{$T}, ::RoundingMode{:Nearest})  = round(nd, $T)
    Base.round(nd::NanoDate, ::Type{$T}) = round(nd, $T, RoundNearestTiesUp)    
  end
end

Base.round(nd::NanoDate, ::Type{Nanosecond}, ::RoundingMode{:Down}) = nd
Base.round(nd::NanoDate, ::Type{Nanosecond}, ::RoundingMode{:Up}) = nd
Base.round(nd::NanoDate, ::Type{Nanosecond}, ::RoundingMode{:NearestTiesUp}) = nd

