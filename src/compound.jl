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

function Dates.Date(cperiod::CompoundPeriod)
    cperiod = canonicalize(cperiod)
    periods = canonicalize(cperiod).periods
    yr, mn, dy = 0, 1, 1
    qt, wk = 0, 0
    idx = findfirst(x->isa(x,Year), periods)
    if !isnothing(idx)
        yr = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Quarter), periods)
    if !isnothing(idx)
        qt = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Month), periods)
    if !isnothing(idx)
        mn = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Week), periods)
    if !isnothing(idx)
        wk = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Day), periods)
    if !isnothing(idx)
        dy = value(periods[idx])
    end
    mn = mn + 3*qt
    if iszero(mn) && !iszero(yr)
        mn = 12
        yr = yr - 1
    end
    dy = dy + 7*wk
    Date(yr,mn,dy)
end

function Dates.Time(cperiod::CompoundPeriod)
    periods = canonicalize(cperiod).periods
    hr, mi, sc, ms, cs, ns = 0, 0, 0, 0, 0, 0
    idx = findfirst(x->isa(x,Hour), periods)
    if !isnothing(idx)
        hr = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Minute), periods)
    if !isnothing(idx)
        mi = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Second), periods)
    if !isnothing(idx)
        sc = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Millisecond), periods)
    if !isnothing(idx)
        ms = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Microsecond), periods)
    if !isnothing(idx)
        cs = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Nanosecond), periods)
    if !isnothing(idx)
        ns = value(periods[idx])
    end
    Time(hr,mi,sc,ms,cs,ns)
end

function Dates.DateTime(cperiod::CompoundPeriod)
    periods = canonicalize(cperiod).periods
    yr, mn, dy = 0, 1, 1
    qt, wk = 0, 0
    hr, mi, sc, ms = 0, 0, 0, 0
    idx = findfirst(x->isa(x,Year), periods)
    if !isnothing(idx)
        yr = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Quarter), periods)
    if !isnothing(idx)
        qt = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Month), periods)
    if !isnothing(idx)
        mn = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Week), periods)
    if !isnothing(idx)
        wk = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Day), periods)
    if !isnothing(idx)
        dy = value(periods[idx])
    end    
    idx = findfirst(x->isa(x,Hour), periods)
    if !isnothing(idx)
        hr = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Minute), periods)
    if !isnothing(idx)
        mi = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Second), periods)
    if !isnothing(idx)
        sc = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Millisecond), periods)
    if !isnothing(idx)
        ms = value(periods[idx])
    end
    mn = mn + 3*qt
    dy = dy + 7*wk
    if iszero(mn) && !iszero(yr)
        mn = 12
        yr = yr - 1
    end
    DateTime(yr,mn,dy,hr,mi,sc,ms)
end

function NanoDate(cperiod::CompoundPeriod)
    periods = canonicalize(cperiod).periods
    yr, mn, dy = 0, 1, 1
    qt, wk = 0, 0
    hr, mi, sc, ms, cs, ns = 0, 0, 0, 0, 0, 0
    idx = findfirst(x->isa(x,Year), periods)
    if !isnothing(idx)
        yr = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Quarter), periods)
    if !isnothing(idx)
        qt = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Month), periods)
    if !isnothing(idx)
        mn = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Week), periods)
    if !isnothing(idx)
        wk = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Day), periods)
    if !isnothing(idx)
        dy = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Hour), periods)
    if !isnothing(idx)
        hr = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Minute), periods)
    if !isnothing(idx)
        mi = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Second), periods)
    if !isnothing(idx)
        sc = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Millisecond), periods)
    if !isnothing(idx)
        ms = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Microsecond), periods)
    if !isnothing(idx)
        cs = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Nanosecond), periods)
    if !isnothing(idx)
        ns = value(periods[idx])
    end
    mn = mn + 3*qt
    dy = dy + 7*wk
    if iszero(mn) && !iszero(yr)
        mn = 12
        yr = yr - 1
    end
    NanoDate(yr,mn,dy,hr,mi,sc,ms,cs,ns)
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

