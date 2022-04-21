yearmonthday(x::NanoDate) = yearmonthday(days(x.datetime))
yearmonth(x::NanoDate) = yearmonth(days(x.datetime))
monthday(x::NanoDate) = monthday(days(x.datetime))

for P in (:Year, :Quarter, :Month, :Week, :Day, :Hour, :Minute, :Second, :Millisecond)
    p = Symbol(lowercase(String(P)))
    @eval begin
        Dates.$P(nd::NanoDate) = $P(nd.datetime)
        Dates.$p(nd::NanoDate) = $p(nd.datetime)
    end
end

@inline Dates.microsecond(nd::NanoDate) = div(value(nd.nanosecs), 1000)
Dates.Microsecond(nd::NanoDate) = Microsecond(microsecond(nd))

@inline Dates.nanosecond(nd::NanoDate) = rem(value(nd.nanosecs), 1000)
Dates.Nanosecond(nd::NanoDate) = Nanosecond(nanosecond(nd))
