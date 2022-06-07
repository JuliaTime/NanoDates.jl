import Dates: Year, Quarter, Month, Week, Day, Hour, Minute, Second, Millisecond, Microsecond, Nanosecond,
    year, quarter, month, week, day, hour, minute, second, millisecond, microsecond, nanosecond

for (P,p) in ((:Year, :year), (:Quarter, :quarter), (:Month, :month), 
              (:Week, :week), (:Day, :day), (:Hour, :hour), (:Minute, :minute), (:Second, :second),
              (:Millisecond, :millisecond), (:Microsecond, :microsecond), (:Nanosecond, :nanosecond))
    @eval begin
        $P(x::$P) = x
        $p(x::$P) = value(x)

        $P(x::Period) = $P(0)
        $p(x::Period) = 0
  
        $P(x::CompoundPeriod) = $P(x.periods)
        $p(x::CompoundPeriod) = $p(x.periods)

        function $P(x::Vector{Period})
            idx = findfirst(v -> isa(v, $P), x)
            if isnothing(idx)
                $P(0)
            else
                x[idx]
            end
        end

        $p(x::Vector{Period}) = value($P(x))

    end
end

function canonical(x::CompoundPeriod)
    y = canonicalize(x)
    ydays = Day(y)
    ymonths = Month(y)
    yweeks = Week(y)
    yqrtrs = Quarter(y)
    delta = yqrtrs + ymonths + yweeks + ydays
    ydays += convert(Day, yweeks)
    ymonths += convert(Month, yqrtrs)
    y + (-delta + ymonths + ydays)
end
