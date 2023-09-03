Base.isempty(x::Dates.CompoundPeriod) = isempty(x.periods)

const AllPeriods = (:Nanosecond, :Microsecond, :Millisecond, :Second, :Minute, :Hour, :Day, :Week, :Month, :Quarter, :Year)
const FixedPeriods = (:Nanosecond, :Microsecond, :Millisecond, :Second, :Minute, :Hour, :Day, :Week)
const VariablePeriods = (:Month, :Quarter, :Year)

# allow period type relative duration determination
for shortidx in 1:length(AllPeriods)-1
    short = AllPeriods[shortidx]
    @eval Base.isless(::Type{$short}, ::Type{$short}) = false
    for longidx in shortidx+1:length(AllPeriods)
        long = AllPeriods[longidx]
        @eval Base.isless(::Type{$short}, ::Type{$long}) = true
        @eval Base.isless(::Type{$long}, ::Type{$short}) = false
    end
end

# allow periods to be expressed in Nanoseconds
widevalue(@nospecialize(x::Period))  = Int128(Dates.value(x))
tonanos(x::Nanosecond)  = widevalue(x)
tonanos(x::Microsecond) = widevalue(x) * 1_000
tonanos(x::Millisecond) = widevalue(x) * 1_000_000
tonanos(x::Second)  = widevalue(x) * 1_000_000_000
tonanos(x::Minute)  = widevalue(x) * (1_000_000_000 * 60)
tonanos(x::Hour)    = widevalue(x) * (1_000_000_000 * (60 * 60))
tonanos(x::Day)     = widevalue(x) * (1_000_000_000 * (60 * 60 * 24))
tonanos(x::Week)    = widevalue(x) * (1_000_000_000 * (60 * 60 * 24 * 7))
tonanos(x::Month)   = widevalue(x) *  2629746000000000 # * Int(Month(1))
tonanos(x::Quarter) = widevalue(x) *  7889238000000000 # * Int(Quarter(1))
tonanos(x::Year)    = widevalue(x) * 31556952000000000 # * Int(Year(1))

for P in AllPeriods
    @eval tonanos(::Type{$P}) = tonanos($P(1))
end

function tonanos(x::Dates.CompoundPeriod)
    isempty(x) && return 0
    mapfoldl(tonanos, +, x.periods)
end

function safeconvert(::Type{P}, x::Period) where {P<:Period}
    fld(tonanos(x), tonanos(P))
end

function safeconvert(::Type{P}, x::Dates.CompoundPeriod) where {P<:Period}
    fld(tonanos(x), tonanos(P))
end
