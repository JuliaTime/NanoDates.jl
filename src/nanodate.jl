struct NanoDate <: Dates.AbstractDateTime
    datetime::DateTime      # DateTime(UTM(microsec))
    nanosecs::Nanosecond    # Nanosecond(microsecond * 1_000 + nanosecond)

    function NanoDate(datetime::DateTime, nanosecs::Nanosecond)
        nanosec = value(nanosecs)
        0 <= nanosec < 1_000_000 && return new(datetime, Nanosecond(nanosec))

        datetime2, nanosecs2 = canonical(millis=value(datetime), nanos=nanosec)
        new(datetime2, nanosecs2)
    end
end

function canonical_mn(millis::T, nanos::T) where {T<:Integer}
    micros, nanos = fldmod_1000(nanos)
    micromillis, micros = fldmod_1000(micros)
    millis += micromillis
    nanos = micros * NanosecondsPerMicrosecond + nanos
    return Millisecond(millis), Nanosecond(nanos)
end

function canonical_cn(micros::T, nanos::T) where {T<:Integer}
    nanomicros, nanos = fldmod_1000(nanos)
    micros += nanomicros
    micromillis, micros = fldmod_1000(micros)
    nanos = micros * NanosecondsPerMicrosecond + nanos
    return Millisecond(micromillis), Nanosecond(nanos)
end

function canonical_mc(millis::T, micros::T) where {T<:Integer}
    micromills, micros = fldmod_1000(micros)
    millis += micromillis
    nanos = micros * NanosecondsPerMicrosecond
    return Millisecond(millis), Nanosecond(nanos)
end

function canonical_mcn(millis::T, micros::T, nanos::T) where {T<:Integer}
    micronanos, nanos = fldmod_1000(nanos)
    micros += micronanos
    millimicros, micros = fldmod_1000(micros)
    millis += millimicros
    nanos = micros * NanosecondsPerMicrosecond + nanos
    return Millisecond(millis), Nanosecond(nanos)
end

canonical(micros::Microsecond, nanos::Nanosecond) =
    canonical_cn(value(micros), value(nanos))

canonical(millis::Millisecond, nanos::Nanosecond) =
    canonical_mn(value(millis), value(nanos))

canonical(millis::Millisecond, micros::Microsecond) =
    canonical_mc(value(millis), value(micros))

canonical(millis::Millisecond, micros::Microsecond, nanos::Nanosecond) =
    canonical_mcn(value(millis), value(micros), value(nanos))


@inline function canonical(; millis, nanos)
    micros, nanos = fldmod_1000(nanos)
    micromillis, micros = fldmod_1000(micros)
    millis += micromillis
    nanos += micros * NanosecondsPerMicrosecond
    datetime = DateTime(Dates.UTM(millis))
    nanosecs = Nanosecond(nanos)
    datetime, nanosecs
end

datetime(x::NanoDate) = x.datetime
nanosecs(x::NanoDate) = x.nanosecs

NanoDate(x::NanoDate) = x

#### Additional Constructors

function NanoDate(date::Date, time::Time)
    slowtime, fasttime = fldmod(value(time), NanosecondsPerMillisecond)
    datetime = DateTime(date) + Millisecond(slowtime)
    NanoDate(datetime, Nanosecond(fasttime))
end

@inline NanoDate(time::Time, date::Date) = NanoDate(date, time)

NanoDate(dt::DateTime, cs::Microsecond) = NanoDate(dt, Nanosecond(value(cs) * 1_000))
NanoDate(dt::DateTime, cs::Microsecond, ns::Nanosecond) =
    NanoDate(dt, nanosecs(cs, ns))

NanoDate(dt::Date, cs::Microsecond, ns::Nanosecond) = NanoDate(DateTime(dt), cs, ns)
NanoDate(dt::Date, cs::Microsecond) = NanoDate(DateTime(dt), cs)
NanoDate(dt::Date, ns::Nanosecond) = NanoDate(DateTime(dt), ns)

NanoDate(yr::Year, mn::Month=Month(1), dy::Day=Day(1)) = NanoDate(Date(yr, mn, dy))
NanoDate(yr::Year, mn::Month, dy::Day, hr::Hour, mi::Minute=Minute(0), sc::Second=Second(0),
    ms::Millisecond=Millisecond(0), cs::Microsecond=Microsecond(0), ns::Nanosecond=Nanosecond(0)) =
    NanoDate(DateTime(yr, mn, dy, hr, mi, sc, ms), nanosecs(cs, ns))

NanoDate(yr, mn=1, dy=1, hr=0, mi=0, sc=0, ms=0, cs=0, ns=0) =
    NanoDate(DateTime(yr, mn, dy, hr, mi, sc, ms), nanosecs(cs, ns))

NanoDate(cs::Microsecond, ns::Nanosecond) = NanoDate(DateTime0, nanosecs(cs, ns))

# for internal cse

csns(ns) = ns
@inline csns(cs, ns) = cs * 1_000 + ns

nanosecs(ns) = Nanosecond(ns)
nanosecs(ns::Nanosecond) = ns
nanosecs(cs::Microsecond) = Nanosecond(1_000 * value(cs))
nanosecs(ms::Millisecond, ns::Nanosecond) = Nanosecond(1_000_000 * value(ms) + value(ns))
nanosecs(ms::Millisecond, cs::Microsecond, ns::Nanosecond) = Nanosecond(1_000_000 * value(ms) + 1_000 * value(cs) + value(ns))

@inline nanosecs(cs, ns) = Nanosecond(csns(cs, ns))
@inline nanosecs(cs::Microsecond, ns::Nanosecond) = nanosecs(value(cs), value(ns))

NanoDate(dt::DateTime, x) = NanoDate(dt, nanosecs(x))
NanoDate(dt::DateTime, cs, ns) = NanoDate(dt, nanosecs(cs, ns))
NanoDate(d::Date, x) = NanoDate(d, nanosecs(x))
NanoDate(d::Date, cs, ns) = NanoDate(d, nanosecs(cs, ns))

NanoDate(dy::Day, ns::Nanosecond) = NanoDate(Date(UTD(dy)), ns)
NanoDate(dy::Day, cs::Microsecond) = NanoDate(Date(UTD(dy)), nanosecs(cs))
NanoDate(dy::Day, cs::Microsecond, ns::Nanosecond) = NanoDate(Date(UTD(dy)), nanosecs(cs, ns))

NanoDate(ms::Millisecond, ns::Nanosecond) = NanoDate(DateTime(UTM(ms)), ns)
NanoDate(ms::Millisecond, cs::Microsecond) = NanoDate(DateTime(UTM(ms)), nanosecs(cs))
NanoDate(ms::Millisecond, cs::Microsecond, ns::Nanosecond) = NanoDate(DateTime(UTM(ms)), nanosecs(cs, ns))

NanoDate() = NanoDate(now())
NanoDate(::Type{UTC}) = NanoDate(now(UTC))

for T in (:Year, :Quarter, :Month, :Week, :Day,
    :Hour, :Minute, :Second, :Millisecond)
    @eval NanoDate(nd::NanoDate, x::$T) = NanoDate(nd.datetime - $T(nd) + x, nd.nanosecs)
end

for T in (:Microsecond, :Nanosecond)
    @eval NanoDates.NanoDate(nd::NanoDate, x::$T) = nd - $T(nd) + x
end

NanoDate(nd::NanoDate, cs::Microsecond, ns::Nanosecond) =
    nd - Microsecond(nd) - Nanosecond(nd) + ns + cs

NanoDate(nd::NanoDate, dtm::DateTime) =
    NanoDate(dtm, nd.nanosecs)
NanoDate(nd::NanoDate, tm::Time) =
    NanoDate(Date(nd.datetime), tm)
NanoDate(nd::NanoDate, dt::Date) =
    NanoDate(DateTime(dt, trunc(Time(nd.datetime), Millisecond)), nd.nanosecs)

const NanoDate0 = NanoDate(0, 1, 1, 0, 0, 0, 0, 0, 0)

