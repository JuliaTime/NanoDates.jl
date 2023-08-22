Base.zero(cperiod::Dates.CompoundPeriod) = Day(0) + Hour(0)
Base.sign(cperiod::Dates.CompoundPeriod) =
    if isempty(cperiod)
       0
    else
      sign((canonical(cperiod)).periods[1])
    end

Base.abs(cperiod::Dates.CompoundPeriod) =
    if sign(cperiod) === -1
       -cperiod
    else
       cperiod
    end


Dates.value(cperiod::Dates.CompoundPeriod) =
    sum(map(tons, cperiod.periods))

for P in (:Year, :Month, :Day, :Hour, :Minute, :Second, :Millisecond, :Microsecond, :Nanosecond)
  steprange = StepRange{NanoDate, P}
  @eval begin
    function nanosteprange(nd1::NanoDate, p::Dates.Period, nd2::NanoDate)
        separation = sign(p) * (nd1 - nd2)
        periodsep = trunc(separation, typeof(p))
        StepRange(nd1, periodsep, nd2)        
  end
end

Base.:(:)(a::NanoDate, b::NanoDate) = (:)(a, Day(1), b)

guess(a::NanoDate, b::NanoDate, c) = floor(Int64, (Int128(value(b)) - Int128(value(a))) / toms(c))
len(a::NanoDate, b::NanoDate, c) = Int64(div(value(b - a), tons(c)))
