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
    Base.ceil(nd::NanoDate, ::Type{$T}) = NanoDate(ceil(nd.datetime), $T)
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
    NanoDate(nd.datetime, nanosec(Microsecond(cs))) + Microsecond(!iszero(ns))
end

Base.trunc(nd::NanoDate, ::Type{Nanosecond}) = nd
Base.floor(nd::NanoDate, ::Type{Nanosecond}) = nd
Base.ceil(nd::NanoDate, ::Type{Nanosecond}) = nd

# rounding

for T in (:Year, :Quarter, :Month, :Week, :Day, :Hour, :Minute, :Second,
            :Millisecond, :Microsecond)
  @eval begin
    Base.round(nd::NanoDate, ::Type{$T}, ::RoundingMode{:Down}) = floor(nd, $T)
    Base.round(nd::NanoDate, ::Type{$T}, ::RoundingMode{:Up}) = ceil(nd, $T)
    function Base.round(nd::NanoDate, ::Type{$T}, ::RoundingMode{:NearestTiesUp})
        up = round(nd, $T, RoundUp)
        dn = round(nd, $T, RoundDown)
        (up - nd) <= (nd - down) ? up : down
    end
    Base.round(nd::NanoDate, :;Type{$T}, ::RoundingMode{:Nearest})  = round(nd, $T)
    Base.round(nd::NanoDate, ::Type{$T}) = round(nd, $T, RoundNearestTiesUp)    
  end
end

Base.round(nd::NanoDate, ::Type{Nanosecond}, ::RoundingMode{:Down}) = nd
Base.round(nd::NanoDate, ::Type{Nanosecond}, ::RoundingMode{:Up}) = nd
Base.round(nd::NanoDate, ::Type{Nanosecond}, ::RoundingMode{:RoundNearestTiesUp}) = nd

