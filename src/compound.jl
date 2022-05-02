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
    periods = canonicalize(cperiod).periods
    yr, mn, dy = 0, 1, 1
    idx = findfirst(x->isa(x,Year), periods)
    if !isnothing(idx)
        yr = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Month), periods)
    if !isnothing(idx)
        mn = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Day), periods)
    if !isnothing(idx)
        dy = value(periods[idx])
    end
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
    hr, mi, sc, ms = 0, 0, 0, 0
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
    DateTime(yr,mn,dy,hr,mi,sc,ms,cs,ns)
end

function NanoDate(cperiod::CompoundPeriod)
    periods = canonicalize(cperiod).periods
    yr, mn, dy = 0, 1, 1
    hr, mi, sc, ms, cs, ns = 0, 0, 0, 0, 0, 0
    idx = findfirst(x->isa(x,Year), periods)
    if !isnothing(idx)
        yr = value(periods[idx])
    end
    idx = findfirst(x->isa(x,Month), periods)
    if !isnothing(idx)
        mn = value(periods[idx])
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
    NanoDate(yr,mn,dy,hr,mi,sc,ms,cs,ns)
end

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
