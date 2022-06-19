Base.iszero(x::CompoundPeriod) = isempty(x)

# Dates defines CompoundPeriod(t::Time)
Dates.CompoundPeriod(d::Date) =
    Year(d) + Month(d) + Day(d)

Dates.CompoundPeriod(dtm::DateTime) =
    Year(dtm) + Month(dtm) + Day(dtm) +
    Hour(dtm) + Minute(dtm) + Second(dtm) +
    Millisecond(dtm)

Dates.CompoundPeriod(nd::NanoDate) =
    Year(nd) + Month(nd) + Day(nd) +
    Hour(nd) + Minute(nd) + Second(nd) +
    Millisecond(nd) + Microsecond(nd) + Nanosecond(nd)

Dates.Date(yr::Year, utc::Bool=false) =
    Date(year(utc ? now(UTC) : now()))

Dates.Date(mn::Month, utc::Bool=false) =
    Date(year(utc ? now(UTC) : now()), value(mn))

Dates.Date(dy::Day, utc::Bool=false) =
    Date(year(utc ? now(UTC) : now()), 1, value(dy))

function Dates.Date(cperiod::CompoundPeriod, utc=false)
    ccperiod = canonical(cperiod)
    
    if iszero(year(ccperiod))
        ccperiod += Year(utc ? now(UTC) : now())
    end
    if iszero(month(ccperiod))
        ccperiod -= Year(1)
        ccperiod += Month(12)
    end
    result = Date(year(ccperiod), month(ccperiod))
    dy = day(ccperiod)
    if iszero(dy)
       result -= Month(1)
       result = lastdayofmonth(result)
    else
       result += Day(dy - (dy > 0))  
    end
    result
end

Dates.DateTime(yr::Year, utc::Bool=false) =
    DateTime(Date(yr, utc))

Dates.DateTime(mn::Month, utc::Bool=false) =
    DateTime(Date(mn, utc))

Dates.DateTime(dy::Day, utc::Bool=false) =
    DateTime(Date(dy, utc))

for P in (:Hour, :Minute, :Second, :Millisecond)
  @eval function Dates.DateTime(p::$P, utc::Bool=false)
            thedatetime = utc ? now(UTC) : now()
            cperiod = canonical(p)
            thedatetime + cperiod
        end
end

function Dates.DateTime(cperiod::CompoundPeriod, utc::Bool=false)
    ccperiod = canonical(cperiod)
    if iszero(year(ccperiod))
        ccperiod += Year(utc ? now(UTC) : now())
    end
    if iszero(month(ccperiod))
        ccperiod -= Year(1)
        ccperiod += Month(12)
    end
    result = DateTime(Date(year(ccperiod), month(ccperiod)))
    dy = day(ccperiod)
    if iszero(dy)
       result -= Month(1)
       result = lastdayofmonth(result)
    else
       result += Day(dy - (dy > 0))  
    end
    result + (ccperiod - CompoundPeriod(result))
end

NanoDate(yr::Year; utc::Bool=false) =
    NanoDate(DateTime(yr, utc))

NanoDate(mn::Month; utc::Bool=false) =
    NanoDate(DateTime(mn, utc))

NanoDate(dy::Day; utc::Bool=false) =
    NanoDate(DateTime(dy, utc))

for P in (:Hour, :Minute, :Second, :Millisecond,
          :Microsecond, :Nanosecond)
  @eval function NanoDate(p::$P; utc::Bool=false)
            thenanodate = NanoDate(utc ? now(UTC) : now())
            cperiod = canonical(p)
            thenanodate + cperiod
        end
end

function NanoDate(cperiod::CompoundPeriod; utc::Bool=false)
    ccperiod = canonical(cperiod)
    if iszero(year(ccperiod))
        ccperiod += Year(utc ? now(UTC) : now())
    end
    if iszero(month(ccperiod))
        ccperiod -= Year(1)
        ccperiod += Month(12)
    end
    result = NanoDate(year(ccperiod), month(ccperiod))
    dy = day(ccperiod)
    if iszero(dy)
       result -= Month(1)
       result = lastdayofmonth(result)
    else
       result += Day(dy - (dy > 0))  
    end
    result + (ccperiod - CompoundPeriod(result))
end

# length, iterate
Base.length(cperiod::CompoundPeriod) = length(cperiod.periods)

# reverse to process smaller period types before larger period types
Base.iterate(cperiod::CompoundPeriod) = iterate(reverse(cperiod.periods))
Base.iterate(cperiod::CompoundPeriod, state) = iterate(reverse(cperiod.periods), state)

function Base.:(+)(nd::NanoDate, cperiod::CompoundPeriod)
    for p in cperiod
        nd += p
    end
    nd
end
Base.:(+)(cperiod::CompoundPeriod, nd::NanoDate) = nd + cperiod

function Base.:(-)(nd::NanoDate, cperiod::CompoundPeriod)
    for p in cperiod
        nd -= p
    end
    nd
end

function Base.:(*)(a::Integer, b::CompoundPeriod)
    b = canonicalize(b)
    accum = similar(b.periods)
    for idx in eachindex(accum)
       accum[idx] = a * b.periods[idx]
    end
    CompoundPeriod(accum)
end

Base.:(*)(b::CompoundPeriod, a::Integer) = a * b

function Base.:(fld)(a::CompoundPeriod, b::Integer)
    b = canonicalize(a)
    accum = similar(a.periods)
    for idx in eachindex(accum)
       accum[idx] = fld(a.periods[idx], b)
    end
    CompoundPeriod(accum)
end

function Base.:(cld)(a::CompoundPeriod, b::Integer)
    b = canonicalize(a)
    accum = similar(a.periods)
    for idx in eachindex(accum)
       accum[idx] = cld(a.periods[idx], b)
    end
    CompoundPeriod(accum)
end

function Base.:(div)(a::CompoundPeriod, b::Integer)
    b = canonicalize(a)
    accum = similar(a.periods)
    for idx in eachindex(accum)
       accum[idx] = div(a.periods[idx], b)
    end
    CompoundPeriod(accum)
end

