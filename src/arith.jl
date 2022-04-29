#=
function Base.:(-)(x::NanoDate, y::NanoDate)
    canonicalize((x.datetime - y.datetime) + canonicalize(x.nanosecs - y.nanosecs))
end
Base.:(-)(x::NanoDate, y::DateTime) = (-)(promote(x,y)...)
Base.:(-)(x::NanoDate, y::Date) = (-)(promote(x,y)...)
Base.:(-)(x::DateTime, y::NanoDate) = (-)(promote(x,y)...)
Base.:(-)(x::Date, y::NanoDate) = (-)(promote(x,y)...)
=#

function Base.:(-)(nd::NanoDate, tm::Time)
    tm_nd = Time(nd)
    dt_nd = Date(nd)
    if tm_nd < tm
        dt_nd -= Day(1)
        tm_nd = tm_nd - tm + Hour(24)
    else
        tm_md = tm_nd - tm
    end
    tm_nd = canonicalize(tm_nd)
    tm = Time(tm_nd)
    return NanoDate(dt_nd, tm)
end

Base.:(-)(nd::NanoDate, dtm::DateTime) = (-)(promote(nd, dtm)...)

Base.:(-)(dtm::DateTime, nd::NanoDate) = (-)(promote(nd, dtm)...)

Base.:(-)(nd::NanoDate, dt::Date) = (-)(promote(nd, dt)...)

function Base.:(-)(nd::NanoDate, tm::Time)
     NanoDate(NanoDate(tm), Year(0))
    = (-)(promote(nd, tm)...)


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

