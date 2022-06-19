#=
import Dates: Year, Quarter, Month, Week, Day,
              Hour, Minute, Second, Millisecond, 
              Microsecond, Nanosecond,
              year, quarter, month, week, day,
              hour, minute, second, millisecond,
              microsecond, nanosecond
=#
import Dates: quarter

for (P,p) in ((:Year, :year), 
              (:Quarter, :quarter), (:Month, :month), 
              (:Week, :week), (:Day, :day), 
              (:Hour, :hour), (:Minute, :minute), (:Second, :second),
              (:Millisecond, :millisecond), 
              (:Microsecond, :microsecond), (:Nanosecond, :nanosecond))
    @eval begin
        Dates.$P(x::Dates.$P) = x
        Dates.$p(x::Dates.$P) = value(x)

        Dates.$P(x::Period) = Dates.$P(0)
        Dates.$p(x::Period) = 0
  
        Dates.$P(x::CompoundPeriod) = Dates.$P(x.periods)
        Dates.$p(x::CompoundPeriod) = Dates.$p(x.periods)

        function Dates.$P(x::Vector{Period})
            idx = findfirst(v -> isa(v, $P), x)
            if isnothing(idx)
                Dates.$P(0)
            else
                x[idx]
            end
        end

        Dates.$p(x::Vector{Period}) = value(Dates.$P(x))
    end
end

function canonicalized(x::CompoundPeriod)
   c = canonicalize(x)
   if !iszero(Dates.quarter(x))
       q = Quarter(c)
       c -= q
       c += convert(Month, q)
   end
   if !iszero(Dates.week(x))
       w = Week(x)
       c -= w
       c += convert(Day, w)
   end
   c
end
   
function canonical(x::CompoundPeriod)
    c = canonicalized(x)
    canonicalized(c)
end

function canonical(x::Period)
    y = canonicalize(x)
    if length(y.periods) == 1 return x end
    canonicalized(y)
end

# trunc a compoundperiod and cnurt

Base.trunc(x::CompoundPeriod, ::Type{Year}) = Year(canonical(x)) + Day(0)
Base.trunc(x::CompoundPeriod, ::Type{Month}) = let c = canonical(x)
    Year(c) + Month(c)
end
Base.trunc(x::CompoundPeriod, ::Type{Day}) = let c = canonical(x)
    Year(c) + (Month(c) + Day(c))
end
Base.trunc(x::CompoundPeriod, ::Type{Hour}) = let c = canonical(x)
    Year(c) + (Month(c) + Day(c) + Hour(c))
end
Base.trunc(x::CompoundPeriod, ::Type{Minute}) = let c = canonical(x)
    Year(c) + (Month(c) + Day(c) + Hour(c) + Minute(c))
end
Base.trunc(x::CompoundPeriod, ::Type{Second}) = let c = canonical(x)
    Year(c) + (Month(c) + Day(c) + Hour(c) + Minute(c) + Second(c))
end
Base.trunc(x::CompoundPeriod, ::Type{Millisecond}) = let c = canonical(x)
    Year(c) + (Month(c) + Day(c) + Hour(c) + Minute(c) + Second(c) +
     Millisecond(c))
end
Base.trunc(x::CompoundPeriod, ::Type{Microsecond}) = let c = canonical(x)
    Year(c) + (Month(c) + Day(c) + Hour(c) + Minute(c) + Second(c) +
     Millisecond(c) + Microsecond(c))
end
Base.trunc(x::CompoundPeriod, ::Type{Nanosecond}) = canonical(x)

cnurt(x::CompoundPeriod, ::Type{Nanosecond}) = trunc(x, Microsecond)
cnurt(x::CompoundPeriod, ::Type{Microsecond}) = trunc(x, Millisecond)
cnurt(x::CompoundPeriod, ::Type{Millisecond}) = trunc(x, Second)
cnurt(x::CompoundPeriod, ::Type{Second}) = trunc(x, Minute)
cnurt(x::CompoundPeriod, ::Type{Minute}) = trunc(x, Hour)
cnurt(x::CompoundPeriod, ::Type{Hour}) = trunc(x, Day)
cnurt(x::CompoundPeriod, ::Type{Day}) = trunc(x, Month)
cnurt(x::CompoundPeriod, ::Type{Month}) = trunc(x, Year)
cnurt(x::CompoundPeriod, ::Type{Year}) = Month(0) + Minute(0)



